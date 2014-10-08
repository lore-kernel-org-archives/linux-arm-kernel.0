From: lanchon@gmail.com (Lanchon)
Date: Wed, 08 Oct 2014 04:58:42 -0300
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <20141007221515.GY5182@n2100.arm.linux.org.uk>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk>
Message-ID: <5434EEB2.7060306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thank you for your answer, please see comments below.


On 10/07/2014 07:15 PM, Russell King - ARM Linux wrote:
> On Tue, Oct 07, 2014 at 06:48:23PM -0300, Lanchon wrote:
>> Simply busy-spinning in userland waiting for FP corruption does not seem
>> to trigger the issue. Concurrently accessing storage in another process
>> while spinning also does not work; power management (sleep, etc) may be
>> involved.
> You need two processes accessing VFP to cause VFP state to be saved and
> restored.
yes. these are dual core systems so i used 4 simultaneous processes 
running the busy-spin.
>> We do not have 'kernel_neon_begin' nor 'kernel_vfp_begin' support in
>> these kernels; the code is just not there.
> Which means that the kernel itself must /never/ make use of floating
> point itself - if it does, it /will/ corrupt the user state in the way
> you are seeing.  That's a pretty hard requirement, and something that
> we have enforced with mainline kernels by building the kernel in
> soft FP mode, thereby preventing the compiler emitting FP instructions.
> Hence, the only way to get VFP instructions in the kernel is via
> explicit assembly sequences.
>
> The exception to this rule is the VFP support code itself, which
> maintains the VFP state on behalf of the hardware and userspace (and
> even then, that code is only concerned with reading and writing the
> VFP registers, not using FP itself.)
and also the VFP support trap for corner cases needed in old VFP 
implementations (VFP 2?). as i said before, this is consistent with what 
i found with objdump: only context switch and old VFP support trap code.
>
> In SMP environments, VFP state is saved each time we context switch
> away from a thread.  If we resume the thread on the _same_ CPU and
> no one else has used the VFP since, we just re-enable access to VFP.
> Otherwise, we re-load the VFP state from the previously saved state.
>
> In UP environments, we do something similar, but we don't save until
> we need to.
this is SMP, and i verified that the resulting kernel uses eager FP 
state save (as required for SMP) and lazy restore.
>
> However, neon shares the VFP registers, and we have some code (crypto
> stuff) which uses neon, and this has appropriate guards to ensure that
> userspace does not see any changes.  This is only available when
> CONFIG_KERNEL_MODE_NEON is enabled (but as you say you don't have
> kernel_neon_begin anywhere, you should /never/ execute any neon
> instructions in the kernel.)
no other neon/vfp instructions found in objdumps. the crypto 
acceleration (if the crypto code is in our trees at all) must be 
disabled then, for lack of CONFIG_KERNEL_MODE_NEON or some other config. 
i am grepping the output of the full kernel and *.ko objdumps (see 
previous link) for 'dN' and 'dNN'; i am supposing that any useful 
VFP/NEON code that clobbers d8 should refer to some 'd' register by name.
>
> I hope this helps; I didn't answer your specific questions because it
> seemed I would just end up repeating what I've said above.
>
actually no, answers to my very specific questions would help me 
understand this: if we had a close-source driver (ISR or kernel thread) 
that touched the FPU, how would the kernel react? would the kernel 
fast-fail in every possible instance? if not, where would the code need 
to be and under what circumstances would it not cause fast-fail? knowing 
this would help me find the offending code (it such code exists; it may 
well be hardware error).

thanks again.
