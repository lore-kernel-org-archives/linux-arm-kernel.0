From: fu.wei@linaro.org (Fu Wei)
Date: Sun, 28 Feb 2016 22:01:55 +0800
Subject: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <56D0A72B.8020100@codeaurora.org>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
 <56D0A72B.8020100@codeaurora.org>
Message-ID: <CADyBb7s9eX6mn6vkb3tn=m=TfD83d4R+U5=iLPADa+XHBE3kDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 27 February 2016 at 03:27, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei at linaro.org wrote:
>>
>> +       if (action) {
>> +               irq = platform_get_irq(pdev, 0);
>> +               if (irq < 0) {
>> +                       action = 0;
>> +                       dev_warn(dev, "unable to get ws0 interrupt.\n");
>> +               } else {
>> +                       if (devm_request_irq(dev, irq,
>> sbsa_gwdt_interrupt, 0,
>> +                                            pdev->name, gwdt)) {
>> +                               action = 0;
>> +                               dev_warn(dev, "unable to request IRQ
>> %d.\n",
>> +                                        irq);
>> +                       }
>> +               }
>> +               if (!action)
>> +                       dev_warn(dev, "falling back to signle stage
>> mode.\n");
>> +       }
>> +
>> +       /*
>> +        * Get the frequency of system counter from the cp15 interface of
>> ARM
>> +        * Generic timer. We don't need to check it, because if it returns
>> "0",
>> +        * system would panic in very early stage.
>> +        */
>> +       gwdt->clk = arch_timer_get_cntfrq();
>> +       gwdt->refresh_base = rf_base;
>> +       gwdt->control_base = cf_base;
>
>
> I think you need to ping the watchdog before enabling the interrupt, in case
> there is a pending interrupt.  This just happened to me in testing, so I
> recommend this:
>
>>         /*
>>          * Get the frequency of system counter from the cp15 interface of
>> ARM
>>          * Generic timer. We don't need to check it, because if it returns
>> "0",
>>          * system would panic in very early stage.
>>          */
>>         gwdt->clk = arch_timer_get_cntfrq();
>>         gwdt->refresh_base = rf_base;
>>         gwdt->control_base = cf_base;
>>
>>         if (action) {
>>                 irq = platform_get_irq(pdev, 0);
>>                 if (irq < 0) {
>>                         action = 0;
>>                         dev_warn(dev, "unable to get ws0 interrupt.\n");
>>                 } else {
>>                         sbsa_gwdt_keepalive(&gwdt->wdd);
>>                         if (devm_request_irq(dev, irq,
>> sbsa_gwdt_interrupt, 0,
>>                                              pdev->name, gwdt)) {
>>                                 action = 0;
>>                                 dev_warn(dev, "unable to request IRQ
>> %d.\n",
>>                                          irq);
>>                         }
>>                 }
>>                 if (!action)
>>                         dev_warn(dev, "falling back to single stage
>> mode.\n");
>>         }
>
>
> In fact, I think you need to move the "if (action) {" block near the end of
> sbsa_gwdt_probe().  We don't want to enable the interrupt until the watchdog
> is fully initialized.
>

Good point! Thanks for your testing :-)

Will post v14 for this change.

> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
