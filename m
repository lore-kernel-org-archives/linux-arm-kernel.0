From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 23 Oct 2015 14:32:27 +0800
Subject: [PATCH v3 2/3] thermal: rockchip: ensure the otp states before
 resetting the controller
In-Reply-To: <CAD=FV=WZqXRt4R_TTaz4LJxWo5B0fmrBjma52cVidpO=OkjcaQ@mail.gmail.com>
References: <1445565296-31517-1-git-send-email-wxt@rock-chips.com>
 <1445565296-31517-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=WZqXRt4R_TTaz4LJxWo5B0fmrBjma52cVidpO=OkjcaQ@mail.gmail.com>
Message-ID: <5629D47B.2030204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?10?23? 12:04, Doug Anderson ??:
> Caesar,
>
> On Thu, Oct 22, 2015 at 9:54 PM, Caesar Wang <wxt@rock-chips.com> wrote:
>> We need the OTP pin is gpio state before resetting the TSADC controller,
>> since the tshut polarity will generate a high signal.
>>
>> Says:
>> The TSHUT temperature is setting more than 80 degree, the
>> default tshut polarity is high.
>>
>> If T > 80C, the OTP output the high signal.
>> If T < 80C, the OTP output the low signal.
>>
>> On the moment, the tshut polarity will be low in a short period of time
>> if the TSADC controller is reset.
>>
>> So:
>> If T < 80C, the OTP output the High Signal.
>> If T > 80C, the OTP output the Low Signal.
>>
>> In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
>> accept the reset response time to avoid this issue.
>> In other words, the system will be always reboot if we
>> make the OTP pin is connected the others IC to control the power.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>>    - Add the pinctrl state for in the suspend/resume.
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   drivers/thermal/rockchip_thermal.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index c89ffb2..3b8fbda 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -642,6 +642,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>>          clk_disable(thermal->pclk);
>>          clk_disable(thermal->clk);
>>
>> +       pinctrl_pm_select_sleep_state(dev);
>> +
>>          return 0;
>>   }
>>
>> @@ -678,6 +680,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>>          for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
>>                  rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>
>> +       pinctrl_pm_select_default_state(dev);
>> +
>>          return 0;
>>   }
> The patch looks totally fine, but the description is a little
> confusing.  Reading this patch it's all about adding support for the
> "sleep" state in the tsadc driver, but nothing in the description
> talks about that.  I'd expect something like:
>
> thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
>
> When we come out of system suspend state (S3) the tsadc will have been
> reset and back at its default state.  While reprogramming the tsadc
> it's possible that we'll glitch the output and unintentionally cause
> the "over temperature" GPIO to be asserted.  Since the over
> temperature GPIO is often hooked up to something that will cause a
> reboot or shutdown in hardware, this glitch can be catastrophic on
> some boards.
>
> We'll add support for selecting the "sleep" pinctrl state at suspend
> time.  Boards can use this to effectively disable the tsadc at suspend
> time and avoid glitches when the system is resumed.

Thanks Doug to take your time reviewing this series patchs.
The commit is very good for this patch.

>
> ---
>
> Note that although this pinctrl approach is fine IMHO, I am left
> wondering whether we could just change the tsadc init sequence to
> avoid the glitch.  I can't easily test myself, but if we can program
> the temperatures before re-enabling the tsadc would it avoid the
> problem too?

It's the chip behaviour, the glitches is aways occured by reset controller.
The best way need  change to the gpio state before reset the controller.


>   Like could we just swap things like:
>
>                  thermal->chip->set_tshut_temp(id, thermal->regs,
>                                                thermal->hw_shut_temp);
>                  thermal->chip->set_tshut_mode(id, thermal->regs,
>                                                thermal->tshut_mode);
>
>
> Does that help?

It didn't work on box board.

>
>
> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
