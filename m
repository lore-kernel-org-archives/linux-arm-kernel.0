From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 9 May 2011 17:53:34 +0530
Subject: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
	enable uart
In-Reply-To: <87bozf962e.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-12-git-send-email-govindraj.raja@ti.com>
	<87pqnym2f2.fsf@ti.com>
	<BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com>
	<87liylkxdi.fsf@ti.com>
	<BANLkTinr8n0P31LWPrwL83sWCzVQOqo6=Q@mail.gmail.com>
	<87bozf962e.fsf@ti.com>
Message-ID: <BANLkTimruC2dWUCEUyiABQ-M5PABtL32SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2011 at 9:25 PM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Thu, May 5, 2011 at 8:28 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>
>>> [...]
>>>
>>>>>
>>>>> ... this is just putting back basically the same thing that was removed in
>>>>> patch 1. ?IOW, this is now being checked for *every* PRCM wakeup, which
>>>>> is no different than having it in the idle path.
>>>>>
>>>>> I thought I understood that you had the SW IRQ triggering working, so
>>>>> this part should not be necessary.
>>>>
>>>> Actually I tried few experiments but couldn't get it working.
>>>
>>> What exactly is not working? ? The interrupt is not firing at all? ?The
>>> driver's ISR is not being called?
>>>
>>
>> It throws a oops as here
>>
>> http://pastebin.com/5bcPjAA0
>
> This doesn't help understand what exactly is not working. ?This needs
> to be debugged further to understand the root cause.
>
> A quick glance at the oops shows a fault when accessing a *physical*
> address within the INTC. ?The MMU is enabled here, and HW accesss should
> be using a virtual address.

Today we could get console_uart booted with irq_patches + uart_runtime
shared by Avinash [Irq_chaining + some local hacks, still not clean patches]

But AFAIK looks like still soft irq method is not generic as we dont
have any similar mechanism for omap4 so how to keep it consistent.

So Shall we retain resume method until we have a generic approach ?

--
Thanks,
Govindraj.R


>
> Also, early in the boot there are a pile of other errors coming from the
> clock framework suggesting that this kernel has some other basic
> problems as well.
>
>> Reproduced with below [EXP-1] change + below kernel.
>>
>> git://gitorious.org/uart_runtime/pm.git
>> [Has uart runtime patches based on pm-core branch]
>>
>>>> Tried below but didn't help.
>>>>
>>>> ------------------------------------
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>>> index 3960330..2c1dfc2 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
>>>> irq, void *dev_id)
>>>> ? ? ? ? do {
>>>> ? ? ? ? ? ? ? ? if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
>>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP3430_IO_ST_MASK)) {
>>>> +#if 1
>>>> + ? ? ? ? ? ? ? ? ? ? ? /*
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?* EXP-1: SET UART1 SOFT IRQ BIT
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?* 3430 -SDP UART1 console.
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?* M_IRQ_72, INTCPS_ISR_SET
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?* 0x4820 0090 + (0x20 * n)
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?* bit-8 n = 2
>>>> + ? ? ? ? ? ? ? ? ? ? ? ?*/
>>>> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x100 , 0x482000D0);
>>>> +#endif
>>>> ? ? ? ? ? ? ? ? ? ? ? ? c = _prcm_int_handle_wakeup();
>>>>
>>>> ? ? ? ? ? ? ? ? ? ? ? ? /*
>>>>
>>>> -----------------------------------
>>>>
>>>> Currently we are planning to integrate irq_chaining patches
>>>> on top uart_runtime patches which is work-in-progress.
>>>> Will remove resume_idle once we have irq_chaining patches available.
>>>
>>> Well, I'm not OK with $SUBJECT patch as it is since it's just moving an
>>> ugly hack from serial.c to the PRCM ISR. ?If the hack is going to stay,
>>> then it should stay where it is until it can be fixed for real.
>>
>> Now with runtime changes we are cutting clocks independently
>> whereas prior to this we where cutting clocks only in sram_idle path.
>>
>> With runtime changes:
>> 1.) Once we cut uart clocks and send a char to uart it directs wakeup_irq to
>> prcm_irq_handler the one way to wakeup uart from there was to check
>> uart mod wakeup status bits if wakeup event occurred then wakeup the
>> particular uart.
>> 2.) Moving this resume back to sram path will break module wakeup after
>> uart clocks are disabled(using put_sync)
>>
>> Thats the reason I have moved this to prcm_irq path to ensure
>> once auto-suspend happens after inactivity period we have resume_call
>> to wakeup uart port.
>
> I understand, but the point is that this approach is still the same as
> the previous hack (check for UART wakeup on *every* wakeup event.)
>
> What is needed is to further investigate using SW triggered IRQs can be
> done for these wakeup events so we can get away from the above approach
> all together.
>
> Kevin
>
