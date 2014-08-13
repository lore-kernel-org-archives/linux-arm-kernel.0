From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Aug 2014 17:55:49 +0200
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <20140813172023.52ad3902@bbrezillon>
References: <1407330702-2926-1-git-send-email-ronald.wahl@raritan.com>	<20140812033456.16355.48522@quantum>	<20140813145348.GA26008@piout.net>
 <20140813172023.52ad3902@bbrezillon>
Message-ID: <53EB8A85.6070509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/2014 17:20, Boris BREZILLON :
> On Wed, 13 Aug 2014 16:53:49 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
>> Hi Mike,
>>
>> On 11/08/2014 at 20:34:56 -0700, Mike Turquette wrote :
>>> Quoting Ronald Wahl (2014-08-06 06:11:42)
>>>> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
>>>> interrupt context. This is not allowed as it might sleep. Move clock
>>>> preparation into process context (at91udc_probe).
>>>> ---
>>>>  drivers/usb/gadget/udc/at91_udc.c | 39 ++++++++++++++++++++++++++++++---------
>>>>  1 file changed, 30 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
>>>> index cfd18bc..0b347a0 100644
>>>> --- a/drivers/usb/gadget/udc/at91_udc.c
>>>> +++ b/drivers/usb/gadget/udc/at91_udc.c
>>>> @@ -872,10 +872,10 @@ static void clk_on(struct at91_udc *udc)
>>>>  
>>>>         if (IS_ENABLED(CONFIG_COMMON_CLK)) {
>>>
>>> Why is this check necessary at all? Drivers shouldn't have to care at
>>> all about the underlying clock framework implementation.
>>>
>>
>> I believe it has been done because without the common clock framework,
>> usb_clk is not defined.
> 
> Absolutely: uclk is only available when using the CCF. In the old at91
> clock implementation the USB clock rate was configured during early boot
> at registration time.
> With the CCF implementation USB clk rate is no longer hardcoded at init
> time and we have to configure it appropriately before using it (the
> prepare and enable actions are useless though because uclk is the parent
> of fclk, and thus will be prepared/enabled when fclk is
> prepared/enabled).
> 
> What we could do here is test for CONFIG_COMMON_CLK_AT91 instead of
> CONFIG_COMMON_CLK (so that there's no direct dependency on the CCF).
> 
> Another option is to implement determine_rate in the new at91 usb clk
> implementation and then call clk_set_rate on fclk (without testing the
> return code, because the old clk implementation will always return
> -EINVAL).

I would recommend to keep it like that until we remove all need for the
old clock implementation. Then we will be able to remove this test and
simplify the code.
In the meantime, it is stated explicitly and I find it more obvious than
trying to hide this matter of fact.

Bye,

>>>>                 clk_set_rate(udc->uclk, 48000000);
>>>> -               clk_prepare_enable(udc->uclk);
>>>> +               clk_enable(udc->uclk);
>>>>         }
>>>> -       clk_prepare_enable(udc->iclk);
>>>> -       clk_prepare_enable(udc->fclk);
>>>> +       clk_enable(udc->iclk);
>>>> +       clk_enable(udc->fclk);
>>>>  }
>>>>  
>>>>  static void clk_off(struct at91_udc *udc)
>>>> @@ -884,10 +884,10 @@ static void clk_off(struct at91_udc *udc)
>>>>                 return;
>>>>         udc->clocked = 0;
>>>>         udc->gadget.speed = USB_SPEED_UNKNOWN;
>>>> -       clk_disable_unprepare(udc->fclk);
>>>> -       clk_disable_unprepare(udc->iclk);
>>>> +       clk_disable(udc->fclk);
>>>> +       clk_disable(udc->iclk);
>>>>         if (IS_ENABLED(CONFIG_COMMON_CLK))
>>>> -               clk_disable_unprepare(udc->uclk);
>>>> +               clk_disable(udc->uclk);
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -1780,14 +1780,23 @@ static int at91udc_probe(struct platform_device *pdev)
>>>>         }
>>>>  
>>>>         /* don't do anything until we have both gadget driver and VBUS */
>>>> +       if (IS_ENABLED(CONFIG_COMMON_CLK)) {
>>>
>>> Same question here. What does the clock framework implementation have to
>>> do with uclk?
>>>
>>> Regards,
>>> Mike
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> 
> 


-- 
Nicolas Ferre
