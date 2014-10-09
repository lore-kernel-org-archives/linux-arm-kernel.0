From: lanchon@gmail.com (Lanchon)
Date: Thu, 09 Oct 2014 19:20:14 -0300
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
References: <54345FA7.9030606@gmail.com>	<20141007221515.GY5182@n2100.arm.linux.org.uk>	<5434F387.804@gmail.com>	<20141008083509.GD5182@n2100.arm.linux.org.uk>
 <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
Message-ID: <54370A1E.6070707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/08/2014 05:53 AM, Ard Biesheuvel wrote:
> On 8 October 2014 10:35, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>>> for instance, you say that if an ISR uses the FPU it would corrupt user
>>> FP state. fine, but it is not that simple. what if the FPU was disabled
>>> at the time of interrupt? (ie: lazy restore did not yet happen in this
>>> time-slice.)
>> At that point, it depends on which kernel version you are using.  Yes,
>> older kernels will just restore the state.  Newer kernels will trap this
>> and complain.
>>
> Indeed. As part of the kernel mode NEON support (which landed in 3.12
> I think?), the VFP trap handling now checks whether it occurred in
> kernel mode or user mode.
> Check arch/arm/vfp/vfphw.S:84 in your kernel tree for
>
> """
> ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
> and r3, r3, #MODE_MASK @ are supported in kernel mode
> teq r3, #USR_MODE
> bne vfp_kmode_exception @ Returns through lr
> """
>
> Without these lines, the lazy restore machinery may kick in during the
> execution of an ISR that uses NEON registers inadvertently, and
> overwrite your VFP state with that of the process that happens to be
> active when the interrupt is taken.

thank you for this! just one question. i suppose the 'kernel mode' test 
used here will be positive if the trap happens while executing a kernel 
thread. it should also be positive if the trap happens while executing 
an ISR that interrupted a kernel thread.  but what if the trap happens 
while executing an ISR that interrupted userland? would this 'kernel 
mode' test also be positive?

the 'official' kernels (like the one i linked in my first message) do 
not have this feature. but i found this commit in Dorimanx, which is a 
fairly used alternative kernel:
https://github.com/dorimanx/Dorimanx-SG2-I9100-Kernel/commit/d4f9e67b9395d5f0d7ce2a836f7c9b6edbae0fa0

i will have people retest with this kernel. but AFAIK, people do not 
report panics or reboots with Dorimanx. and it is unreasonable to 
believe a priori of cause that every single time an ISR or kernel thread 
is about to corrupt FPs, the FPU just happened to be enabled. so this 
fail-fast mechanism not triggering points to the code being ok, and this 
being more of a hardware issue.

>
> You should also be aware that q4 is an alias of d8-d9, so grep'ing
> your objdump for d8 is not sufficient.
>

thanks! i have objdumped the kernel and *.ko files again and found no 
'qNN' registers mentioned either.

---

there is a new piece of information:
the FP corruption seems to only happen in these android devices if the 
display is off. the charger may be connected or not, but if the display 
is on, the corruption won't happen.

i wonder if the kernel could be turning off the FPU and then back on 
without saving the FPU state. i would think corruption would be seen 
more often then.

maybe it is restoring state before voltage to the FPU has stabilized. 
this could be easily checked by instrumenting the state restore with a 
check. but sounds unreasonable: the delay implied by the lazy restore 
mechanism should hide the effects of this 'race condition' of sorts.
