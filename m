From: jason77.wang@gmail.com (Hui Wang)
Date: Tue, 22 May 2012 10:16:34 +0800
Subject: [PATCH 2/2] ARM: SMP: use per cpu state to replace
In-Reply-To: <alpine.LFD.2.02.1205211524040.3231@ionos>
References: <1337593531-16191-1-git-send-email-jason77.wang@gmail.com>
 <1337593531-16191-2-git-send-email-jason77.wang@gmail.com>
 <1337593531-16191-3-git-send-email-jason77.wang@gmail.com>
 <20120521123321.GA24270@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205211524040.3231@ionos>
Message-ID: <4FBAF702.8020900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review and glad to know this will be fixed from the root cause.

Hi Russell,

What about my first patch, the tasklist_lock is not easy changed to the 
raw lock in the RT kernel since this lock is used by various subsystems, 
and change this lock to raw lock will affect RT performance.

Regards,
Hui.

Thomas Gleixner wrote:
> On Mon, 21 May 2012, Russell King - ARM Linux wrote:
>
>   
>> On Mon, May 21, 2012 at 05:45:31PM +0800, Hui Wang wrote:
>>     
>>> CPU hotplug will bring following call trace in the RT kernel:
>>> BUG: sleeping function called from invalid context at linux/kernel/rtmutex.c:707
>>> pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper
>>> [<800413a0>] (unwind_backtrace+0x0/0xe4) from [<804ff214>] (rt_spin_lock+0x30/0x5c)
>>> [<804ff214>] (rt_spin_lock+0x30/0x5c) from [<8005a848>] (complete+0x1c/0x54)
>>> [<8005a848>] (complete+0x1c/0x54) from [<804f59f8>] (cpu_die+0x34/0x70)
>>> [<804f59f8>] (cpu_die+0x34/0x70) from [<8003b840>] (cpu_idle+0x54/0xd8)
>>> [<8003b840>] (cpu_idle+0x54/0xd8) from [<104f9ecc>] (0x104f9ecc)
>>>
>>> To avoid this call trace, we use per cpu variable to replace
>>> completion, and it is safe for this modification since all reference
>>> of per cpu_state variable is in the preempt disabled context.
>>>       
>> This is silly.  Why is RT preventing things that work perfectly well in
>> the standard kernel from being used in the RT kernel?
>>     
>
> The silliness is in some of the users of waitqueues. waitqueues are
> protected by a spinlock, which we cannot convert to a raw spinlock on
> rt because some of the wq users run insane callbacks from the wakeup
> context with interrupts disabled.....
>  
>   
>> Being able to call complete() from atomic contexts is one of the
>> fundamentals that RT seems to be breaking here.
>>     
>
> Yeah, I have a simpler waitqueue variant (no callbacks) which I want
> to use for completions.
>
> Thanks,
>
> 	tglx
>
>   
