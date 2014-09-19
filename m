From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Sep 2014 20:34:41 -0700
Subject: [PATCH] pinctrl: qcom: use restart_notifier mechanism for ps_hold
In-Reply-To: <541B9ADA.2070107@roeck-us.net>
References: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
 <541B9ADA.2070107@roeck-us.net>
Message-ID: <541BA451.9010508@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 07:54 PM, Guenter Roeck wrote:
> On 09/18/2014 03:32 PM, Josh Cartwright wrote:
>> By converting to the restart_notifier mechanism for restart, we allow
>> for other mechanisms, like the watchdog, to be used for restart in the
>> case where PS_HOLD has failed to reset the chip.
>>
>> Choose priority 128, as according to documentation, this mechanism "is
>> sufficient to restart the entire system".
>>
>> Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-msm.c | 38 ++++++++++++++++++++++++++------------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index d5ed127..9fced3b 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -27,8 +27,7 @@
>>   #include <linux/gpio.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/spinlock.h>
>> -
>> -#include <asm/system_misc.h>
>> +#include <linux/reboot.h>
>>
>>   #include "../core.h"
>>   #include "../pinconf.h"
>> @@ -43,6 +42,7 @@
>>    * @dev:            device handle.
>>    * @pctrl:          pinctrl handle.
>>    * @chip:           gpiochip handle.
>> + * @restart_nb:     restart notifier block.
>>    * @irq:            parent irq for the TLMM irq_chip.
>>    * @lock:           Spinlock to protect register resources as well
>>    *                  as msm_pinctrl data structures.
>> @@ -56,6 +56,7 @@ struct msm_pinctrl {
>>       struct device *dev;
>>       struct pinctrl_dev *pctrl;
>>       struct gpio_chip chip;
>> +    struct notifier_block restart_nb;
>>       int irq;
>>
>>       spinlock_t lock;
>> @@ -852,13 +853,14 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>       return 0;
>>   }
>>
>> -#ifdef CONFIG_ARM
>
> Unrelated to this patch, but is this going to be executed (and potentially used)
> on any non-arm architectures ?
>
> Reason for asking that the restart handler mechanism is currently only
> implemented on arm and arm64. If it is going to be used with other
> architectures, we'll have to add the necessary call into the architecture
> restart code.
>
>> -static void __iomem *msm_ps_hold;
>> -
>> -static void msm_reset(enum reboot_mode reboot_mode, const char *cmd)
>> +static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
>> +                   void *data)
>>   {
>> -    writel(0, msm_ps_hold);
>> +    struct msm_pinctrl *pctrl = container_of(nb, struct msm_pinctrl, restart_nb);
>> +
>> +    writel(0, pctrl->regs + PS_HOLD_OFFSET);
>>       mdelay(10000);
>
> Sure you still want to wait for 10 seconds here ?
> Would it make sense to choose a more reasonable timeout ?
>
> Thanks,
> Guenter
>
>> +    return NOTIFY_DONE;
>>   }
>>
>>   static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>> @@ -868,13 +870,16 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>>
>>       for (; i <= pctrl->soc->nfunctions; i++)
>>           if (!strcmp(func[i].name, "ps_hold")) {
>> -            msm_ps_hold = pctrl->regs + PS_HOLD_OFFSET;
>> -            arm_pm_restart = msm_reset;
>> +            pctrl->restart_nb.notifier_call = msm_ps_hold_restart;
>> +            pctrl->restart_nb.priority = 128;
>> +            if (register_restart_handler(&pctrl->restart_nb)) {
>> +                dev_err(pctrl->dev,
>> +                    "failed to setup restart handler.\n");
>> +                pctrl->restart_nb.notifier_call = NULL;
>> +            }
>> +            break;
>>           }
>>   }
>> -#else
>> -static void msm_pinctrl_setup_pm_reset(const struct msm_pinctrl *pctrl) {}
>> -#endif
>>
>>   int msm_pinctrl_probe(struct platform_device *pdev,
>>                 const struct msm_pinctrl_soc_data *soc_data)
>> @@ -943,6 +948,15 @@ int msm_pinctrl_remove(struct platform_device *pdev)
>>
>>       pinctrl_unregister(pctrl->pctrl);
>>
>> +    if (pctrl->restart_nb.notifier_call) {

One more comment: The conditional is really unnecessary. Just let
unregister_restart_handler deal with it ...

>> +        ret = unregister_restart_handler(&pctrl->restart_nb);

and just ignore the error return. The function will only return an error
if the entry was not found, and then it is a don't care.

Thanks,
Guenter

>> +        if (ret) {
>> +            dev_err(&pdev->dev,
>> +                "unable to unregister restart handler\n");
>> +            return ret;
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(msm_pinctrl_remove);
>>
>
