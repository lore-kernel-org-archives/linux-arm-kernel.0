From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Jul 2013 14:51:49 +0200
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <0735ab8c-0f80-4b64-b2b2-8d4553482c2a@CO9EHSMHS013.ehs.local>
References: <20130717210417.GP13667@xsjandreislx>
 <51E72DCA.9070500@codeaurora.org>
 <f5b76049-7e5b-4dd0-9863-19cfd1d599b9@TX2EHSMHS006.ehs.local>
 <51E7435B.3060605@codeaurora.org>
 <ff4d40be-7177-4a55-ab2f-dff11fa18642@DB9EHSMHS009.ehs.local>
 <51ED8DF2.60600@codeaurora.org> <20130722201348.GI453@xsjandreislx>
 <0735ab8c-0f80-4b64-b2b2-8d4553482c2a@CO9EHSMHS013.ehs.local>
Message-ID: <51F66565.7010600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 12:41 AM, S?ren Brinkmann wrote:
> Hi,
> 
> adding LKML and LAKML (which I forgot on the original email, sorry)
> 
> On Mon, Jul 22, 2013 at 01:13:48PM -0700, S?ren Brinkmann wrote:
>> On Mon, Jul 22, 2013 at 12:54:26PM -0700, Stephen Boyd wrote:
>>> On 07/22/13 11:25, S?ren Brinkmann wrote:
>>>> On Wed, Jul 17, 2013 at 06:22:35PM -0700, Stephen Boyd wrote:
>>>>> On 07/17/13 17:59, S?ren Brinkmann wrote:
>>>>>> Hi Stephen,
>>>>>>
>>>>>> On Wed, Jul 17, 2013 at 04:50:34PM -0700, Stephen Boyd wrote:
>>>>>>> On 07/17/13 14:04, S?ren Brinkmann wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I'm trying to enable the arm_global_timer on Zynq platforms with the
>>>>>>>> attached patch. Unfortunately that patch breaks booting up. It hangs
>>>>>>>> when handing over to init/early userspace (see attached boot.log).
>>>>>>>>
>>>>>>>> The funny thing is, if I remove either the global timer or the
>>>>>>>> arm,cortex-a9-twd-timer node from my dts, it works. So, it looks like
>>>>>>>> the two timer (drivers) interfere somehow. Does anybody have an idea of
>>>>>>>> what is going on and probably even how to resolve it?
>>>>>>>>
>>>>>>>> The patch is based on commit c0d15cc in Linus' tree.
>>>>>>> If you boot with one CPU does it hang? It looks like secondary CPUs
>>>>>>> aren't getting interrupts but I'm not sure why. Maybe you can try this
>>>>>>> patch and/or put some prints in the timer interrupt handler to see if
>>>>>>> interrupts are firing on secondary CPUs.
>>>>>> Your proposed patch does not seem to make a difference, but adding
>>>>>> 'maxcpus=1' to the kernel command line makes the system boot.
>>>>> Hmm I guess that doesn't really confirm much because TWD doesn't
>>>>> register itself on maxcpus=1 systems, so it's the same as removing the
>>>>> node from DT. Probably easier to put a printk in the interrupt handler
>>>>> and confirm that you're receiving interrupts on secondary CPUs.
>>>> Turns out it does work when I disable Zynq's cpuidle driver. I think I
>>>> can blame that driver.
>>>>
>>>
>>> Hmm.. Perhaps the arm_global_timer driver also needs FEAT_C3_STOP added
>>> to it. Do you know if that timer is reset during low power modes?
>>
>> Our cpudidle driver is not powering off anything, AFAIK. I think it just
>> executes 'wfi' on the CPU. I don't know how the timer core handles it,
>> but I'd expect the CPU should find the timer just a it was left before
>> entering idle (well, the timer continues to run I assume, but other than
>> that).
>> I'll do some debugging and see if I can find out what exactly causes the
>> hang.
> 
> So, what I found:
> The Zynq cpuidle driver provides two idle states, which are both
> basically just ARM wfi states. But the second one set's these flags:
> 	.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP,
> 
> I don't know what these flags cause in detail. But the
> CPUIDLE_FLAG_TIMER_STOP seemed suspicious, since wfi does not have any
> effect on the timer. So, I removed that one and things are working.
> 
> I also tried the other approach: Leaving cpuidle as is and adding the
> C3STOP flag to the global timer. That solves it too.
> 
> Does anybody know what the correct solution is?
> In case the C3STOP flag is considered to be corret for the timer, I
> could prepare a patch for that and bundle it with the one to enable the
> timer for Zynq?

Hi Soren,

the CPUIDLE_FLAG_TIMER_STOP flag tells the cpuidle framework the local
timer will be stopped when entering to the idle state. In this case, the
cpuidle framework will call clockevents_notify(ENTER) and switches to a
broadcast timer and will call clockevents_notify(EXIT) when exiting the
idle state, switching the local timer back in use.

The C3STOP flag has a similar semantic than the CPUIDLE_FLAG_TIMER_STOP,
that is the timer can be shutdown with a specific idle state. This flag
is used by the tick broadcast code.

If the C3STOP flag is not set for a local timer, the
CPUIDLE_FLAG_TIMER_STOP does not make sense because it will be ignored
by the tick-broadcast code.

If the local timer could be shutdown at idle time, you *must* specify
this flag.

If the idle state shutdowns the cpu with its local timer, you *must*
specify the CPUIDLE_FLAG_TIMER_STOP flag for this specific state.

At the first glance, the idle state #2 is aimed to do DDR self refresh
and to switch to WFI, so no power gating, then no local timer down. The
CPUIDLE_FLAG_TIMER_STOP shouldn't be used here.

IIUC, the global timer does not belong to the CPU and the cluster power
domains, so it can't be shutdown: the C3STOP shouldn't be used.

I hope that helps.

  -- Daniel


> @Michal: What do we do about the cpuidle driver? If you asked me, we
> should rip out the second state completely. We have it as disabled
> placeholder in our vendor tree and it seems to break things having it
> enabled in mainline.
> 
> 
> 	S?ren
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
