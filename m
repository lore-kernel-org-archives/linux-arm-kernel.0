From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 18 Dec 2013 22:36:45 -0800
Subject: [PATCH 2/4] ARM: imx: Add cpu frequency scaling support
In-Reply-To: <20131219054758.GU6691@S2101-09.ap.freescale.net>
References: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
 <1387410656-36053-2-git-send-email-john.tobias.ph@gmail.com>
 <20131219054758.GU6691@S2101-09.ap.freescale.net>
Message-ID: <CACUGKYMQsb-eaDa1oXt38hsKzWVV=5xbNi-5-v0r8cWAMu_Rrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for checking again. I should carefully check the unnecessary
braces and exercise the tools available in script.
Will re-submit again tomorrow.

Regards,

john

On Wed, Dec 18, 2013 at 9:48 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 18, 2013 at 03:50:54PM -0800, John Tobias wrote:
>> Re-using iMX6Q driver for cpu frequency scaling.
>>
>> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
>> ---
>>  arch/arm/mach-imx/mach-imx6sl.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
>> index 2f952e3..a8b1543 100644
>> --- a/arch/arm/mach-imx/mach-imx6sl.c
>> +++ b/arch/arm/mach-imx/mach-imx6sl.c
>> @@ -8,7 +8,6 @@
>>   */
>>
>>  #include <linux/irqchip.h>
>> -#include <linux/of.h>
>
> This is an unrelated change to the patch.
>
>>  #include <linux/of_platform.h>
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>> @@ -34,6 +33,17 @@ static void __init imx6sl_fec_init(void)
>>       }
>>  }
>>
>> +static struct platform_device imx6q_cpufreq_pdev = {
>> +     .name = "imx6q-cpufreq",
>> +};
>> +
>> +static void __init imx6sl_init_late(void)
>> +{
>> +     if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
>
> Unnecessary braces.
>
>> +             platform_device_register(&imx6q_cpufreq_pdev);
>
> Register the device in the following way will save imx6q_cpufreq_pdev.
>
>         platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
>
> Shawn
>
>> +     }
>> +}
>> +
>>  static void __init imx6sl_init_machine(void)
>>  {
>>       struct device *parent;
>> @@ -70,6 +80,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
>>       .map_io         = debug_ll_io_init,
>>       .init_irq       = imx6sl_init_irq,
>>       .init_machine   = imx6sl_init_machine,
>> +     .init_late      = imx6sl_init_late,
>>       .dt_compat      = imx6sl_dt_compat,
>>       .restart        = mxc_restart,
>>  MACHINE_END
>> --
>> 1.8.3.2
>>
>
