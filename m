From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 08 Sep 2015 10:28:04 +0100
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <1441535972.22230.5.camel@mhfsdcap03>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>	
 <55DB4609.5040904@arm.com>	
 <CAGS+omBnoitju07KQ1Y7JHTbce6+DO4WqWHTaKz5D+T157zEJA@mail.gmail.com>
 <1441535972.22230.5.camel@mhfsdcap03>
Message-ID: <55EEAA24.6080706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/09/15 11:39, maoguang meng wrote:
> On Wed, 2015-09-02 at 14:02 +0800, Daniel Kurtz wrote:
>> Hi maoguang,
>>
>> On Tue, Aug 25, 2015 at 12:27 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>
>>> On 14/08/15 09:38, maoguang.meng at mediatek.com wrote:
>>>>
>>>> From: Maoguang Meng <maoguang.meng@mediatek.com>
>>>>
>>>> This patch implement irq_set_wake to get who is wakeup source and
>>>> setup on suspend resume.
>>>>
>>>> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
>>>>
>> [snip]
>>
>> Can you please respond to Sudeep's questions:
>>
>>> Does this pinmux controller:
>>>
>>> 1. Support wake-up configuration ? If not, you need to use
>>>     IRQCHIP_SKIP_SET_WAKE. I don't see any value in writing the
>>>     mask_{set,clear} if the same registers are used for {en,dis}able
>
>    YES.
>    we can call enable_irq_wake(irq) to config this irq as a wake-up
> source.
>

No that doesn't answer my question. Yes you can always call
enable_irq_wake(irq) as along as you have irq_set_wake implemented.
But my question was does this pinmux controller support wake-up
configuration.

IMHO, by looking at the implementation I can confirm *NO*, it doesn't.
So please stop copy-pasting the implementation from other drivers.
The reason is you operate on the same mask_{set,clear} which you use
to {en,dis}able the interrupts which means you don't have to do anything
to configure an interrupt as a wakeup source other than just keeping
them enabled. Hopefully this clarifies.

>>>
>>> 2. Is in always on domain ? If not, you need save/restore only to
>>>     resume back the functionality. Generally we can set
>>>     IRQCHIP_MASK_ON_SUSPEND to ensure non-wake-up interrupts are
>>>     disabled during suspend and re-enabled in resume path. You just
>>>     save/restore raw values without tracking the wake-up source.
>
>    YES.
>

Again *YES* for what part of my question. If it's always-on, then you
don't need this suspend/resume callbacks at all, so I assume the answer
is *NO*.

>>>
>>> Also I see that no care is taken to set the port irq as wake enable
>>> source. It may work with current mainline, but won't with -next. Please
>>> ensure the port irq to the parent interrupt controller remains
>>> enabled(i.e set as wake).
>
> As you know, we do not care the port irq as wake enbale source,
> when enter suspend we think no matter what the port irq is
> enabled/disabled which are not affected as a wake-up source,
> Because eint has a line to receive SPM.
>

I understand that, but for proper wakeup functionality you need to do
configure the parent if you want to identify and handle that wakeup
interrupt. If you don't care then it should be fine.

> For example,after suspend,press power key(use eint5) will generate an
> electrical signal which is send to spm by eint.
> and then spm wake cpu.

Yes I got that, as I mentioned above, I think you don't need to identify
and handle the wakeup interrupt. E.g. if it's a keyboard key press, you
may need to identify the key pressed, so it needs to be handled
properly. In your case, I assume it's just power button whose main
function is to wake/boot and that's already achieved when you are woken up.

Regards,
Sudeep
