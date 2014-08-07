From: caesar.wang@rock-chips.com (caesar)
Date: Thu, 07 Aug 2014 12:05:34 +0800
Subject: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
In-Reply-To: <CAD=FV=XhN__4hoGu=3hSXP69-T6T7KTxRiFY4Ac4bNJAYf+6jQ@mail.gmail.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>	<1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>	<CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>	<53E2D605.2000704@rock-chips.com>	<CAD=FV=Xw8tz2keCUtO+qYUmnuv=+DPGZjY9-j_2XmAcP3Luzjg@mail.gmail.com>	<53E2F11A.1040109@rock-chips.com>	<CAD=FV=Wuj2_q+iW2EAj7w8TvgS=C2juSu+h_iG24NvPk4UqhKQ@mail.gmail.com>	<53E2F471.6020701@rock-chips.com>
 <CAD=FV=XhN__4hoGu=3hSXP69-T6T7KTxRiFY4Ac4bNJAYf+6jQ@mail.gmail.com>
Message-ID: <53E2FB0E.40301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,
? 2014?08?07? 11:46, Doug Anderson ??:
> Caesar,
>
> On Wed, Aug 6, 2014 at 8:37 PM, caesar <caesar.wang@rock-chips.com> wrote:
>> Doug,
>>
>> ? 2014?08?07? 11:26, Doug Anderson ??:
>>
>>> caesar,
>>>
>>> On Wed, Aug 6, 2014 at 8:23 PM, caesar <caesar.wang@rock-chips.com> wrote:
>>>> ? 2014?08?07? 10:16, Doug Anderson ??:
>>>>
>>>>> Caesar,
>>>>>
>>>>> On Wed, Aug 6, 2014 at 6:27 PM, caesar <caesar.wang@rock-chips.com>
>>>>> wrote:
>>>>>> Doug,
>>>>>>
>>>>>> ? 2014?08?07? 06:46, Doug Anderson ??:
>>>>>>
>>>>>>> Caesar,
>>>>>>>
>>>>>>> On Thu, Jul 24, 2014 at 3:21 AM, Caesar Wang
>>>>>>> <caesar.wang@rock-chips.com>
>>>>>>> wrote:
>>>>>>>> +static const struct rockchip_pwm_data pwm_data_v1 = {
>>>>>>>> +       .regs.duty = PWM_HRC,
>>>>>>>> +       .regs.period = PWM_LRC,
>>>>>>>> +       .regs.cntr = PWM_CNTR,
>>>>>>>> +       .regs.ctrl = PWM_CTRL,
>>>>>>>> +       .prescaler = PRESCALER,
>>>>>>>> +       .set_enable = rockchip_pwm_set_enable_v1,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static const struct rockchip_pwm_data pwm_data_v2 = {
>>>>>>>> +       .regs.duty = PWM_LRC,
>>>>>>>> +       .regs.period = PWM_HRC,
>>>>>>>> +       .regs.cntr = PWM_CNTR,
>>>>>>>> +       .regs.ctrl = PWM_CTRL,
>>>>>>>> +       .prescaler = PRESCALER-1,
>>>>>>>> +       .set_enable = rockchip_pwm_set_enable_v2,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static const struct rockchip_pwm_data pwm_data_vop = {
>>>>>>>> +       .regs.duty = PWM_LRC,
>>>>>>>> +       .regs.period = PWM_HRC,
>>>>>>>> +       .regs.cntr = PWM_CTRL,
>>>>>>>> +       .regs.ctrl = PWM_CNTR,
>>>>>>> Did you really mean to flip CTRL and CNTR here?  If so, that's super
>>>>>>> confusing and deserves a comment.  AKA, I think the above should not
>>>>>>> be:
>>>>>>>
>>>>>>>      +       .regs.cntr = PWM_CTRL,
>>>>>>>      +       .regs.ctrl = PWM_CNTR,
>>>>>>>
>>>>>>> ...but should be
>>>>>>>
>>>>>>>      +       .regs.cntr = PWM_CNTR,
>>>>>>>      +       .regs.ctrl = PWM_CTRL,
>>>>>>>
>>>>>>> If you didn't mean to flip CTRL and CNTR here, then just get rid of
>>>>>>> pwm_data_vop and refer to pwm_data_v2.  In fact, I'd suggest that you
>>>>>>> totally remove the "rockchip,vop-pwm" since there's nothing different
>>>>>>> between "rockchip,rk3288-pwm" and "rockchip,vop-pwm".
>>>>>>
>>>>>> Sorry,I think it's no problem. the  "rockchip,rk3288-pwm" and
>>>>>> "rockchip,vop-pwm" are seperate PWM controllers.
>>>>>> They are just different registers address between CNTR and CTRL .
>>>>> OK, I looked up in the TRM.  Right, the CNTR and CTRL are flipped on
>>>>> the vop.  So I think that the only change you need is to add:
>>>>>
>>>>> #define PWM_VOP_CTRL  0x00
>>>>> #define PWM_VOP_CNTR  0x0c
>>>>>
>>>>> ...then use these new #defines for the vop structure.
>>>>>
>>>>>
>>>>> As you have the code written right now it's very confusing.  The new
>>>>> #defines will fix this.
>>>>>
>>>> yeah, I think they can be used in the same context.
>>>>
>>>> I will fix it in patch v5 if it is really need.
>>> I think you should fix this, but if Thierry doesn't think so then it's
>>> really his decision.
>> I remember In patch v2 [1],Thierry suggests me to fix it so if I have no to
>> get wrong.
>>
>> [1]: https://lkml.org/lkml/2014/7/21/113
> I think Thierry might not have realized that they were flipped...
>
> -Doug
>
>
>
Maybe you are right.
I will sent patch v5 fix the about tomorrow if it has no other problems.
