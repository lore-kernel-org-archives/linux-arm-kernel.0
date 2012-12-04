From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 4 Dec 2012 19:44:11 +0800
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
Message-ID: <20121204114410.GA7450@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 12:02:55PM +0000, Peter Maydell wrote:
> On 3 December 2012 10:36, Dong Aisheng <b29396@freescale.com> wrote:
> > The patch is mainly for implementing the vgic state save and retore function.
> > I'm not sure the current implementation method is the most proper way.
> > So i'd like to send out the patch for RFC on the direction and issues i met
> > during the implementation.
> >
> > There're mainly two ways to implement such function while it looks different
> > ways have different issues respectively.
> > 1) Firstly i tried using ONE_REG interfaces that user spaces could
> > read all virtual gic dist registers and gic virtual interfaces control
> > registers for saving gic states. (The vitural cpu interfaces registers
> > are not exported since it's state could be got from GICH_VMCR register which
> > already reflects the basic cpu interface states.)
> > The way to do this could be to mannually emulate MMIO access in
> > kernel to re-use vgic_handle_mmio code since the vgic code in kernel does
> > not maintain gic state in registers format and we can not simply memcpy
> > the kernel gic registers to user spaces.
> >
> > For this way, the problem is that it looks a bit low efficiency for emulate
> > register access
> 
> Efficiency is really not a significant concern here, because state
> save and restore only happens when doing VM migration, which is
> already a slow process (mostly dominated by the costs of moving the
> VM memory from one machine to another).

Okay, i agree.
Comparing to other slow processing, this may be really not a big deal.

> > and via current ONE_REG interface we do not know which CPU
> > is performing the register access, so the banked registers are not
> > suppported well,
> 
> Actually you do, because it's a vcpu ioctl. That does raise a

Sorry, i did not describe the issue clearly.
You're right we know which vcpu are performing the ONE_REG ioctl.
The problem is that for banked registers, it requires each CPU to read
registers to get its own value, while during gic state saving, it looks
the gic_saving function in qemu is only called once, then we can only
get the value of banked registers of current CPU who read register.
For the banked registers of other CPUs, we can not use this CPU to
get them.

Probably one way we could try to avoid this issue is also saving the
banked registers value in kernel, then using it as return value of ONE_REG
access of specified VCPU rather than performing real register access to get
the correct banked register value.

> different question, though. ONE_REG is currently aimed as a vcpu
> ioctl for CPU state save/restore -- how does it need to change
> to handle device state save/restore where the device is not per-cpu?
> 
What do you mean not per-cpu device? Or should it be said per-cpu device?
I'm a bit confused. For per-cpu variable, it means each cpu has
its own copy of the variable.
Then my understanding of non per-cpu device is that the device state
is consistent between all CPUs. It does not care which CPU is accessing
it. Then what issues do you mean for such devices when using ONE_REG?

> > e.g. some banked dist registers and banked cpu virtual interfaces
> > control registers.
> > So i'm not sure we should still go follow this way.
> 
> You can handle banked registers the same way we handle the cache
> ID registers in the main CPU. In general ONE_REG is not supposed
> to expose direct access to registers which behave like the hardware
> registers: it is supposed to expose access to registers which
> merely store "state", ie which can be idempotently saved and loaded.
> Sometimes this means the kernel has to invent its own registers which
> don't have side effects.
> 

Okay, i will check it. Thanks for the info.

> > 2) Another way is, as x86, to use standard KVM_SET_IRQCHIP/KVM_GET_IRQCHIP
> > ioctl to save and restore irq chip state. e.g. arch/x86/kvm/x86.c.
> > This method does not have banked registers issue since it could all be
> > handled by SW and it looks simpler than the first way.
> > The problem is that the x86 kvm irqchip driver are using almost the same data
> > structure as user space to represent irqchip states which then can be easily
> > copied to user spaces. But arm vgic driver are using different data structure,
> > e.g. qemu gic common code is using gic_state while in kernel vgic code is using
> > a number of vgic_bitmaps.
> > We could either read all the in-kernel vgic_bitmaps from user space and
> > mannually convert it to git_state for user space to use to re-use the exist
> > common state handle codes in qemu or convert to git_state format in kernel
> > and then export to user space, but neither way looks good and they also
> > look low efficiency, so i can not see enough reasons to do so.
> 
> Somebody needs to do this conversion, or TCG-to-KVM migrations won't work.
> I don't have a strong opinion whether it ought to be userspace or kernel;
> I think the deciding factor is probably going to be which is the easiest
> for the kernel to support into the future as a stable ABI (even as GIC
> versions change etc).
> 

I don't know too much about TCG, will spend some time to research.
It looks to me if we're using ONE_REG, we then have to do it in qemu.

> > The current implementation in this patch does not do any convertion
> > between the two different state formats and it just simply export what we have
> > in kernel to represent gic state to user space via KVM_GET_IRQCHIP,
> > that means we does not use much common state handle code in arm_gic_common.c
> > in qemu.
> 
> This is definitely the wrong approach, I'm afraid. I still strongly
> feel we should be using the standard ONE_REG interfaces here (though
> there is perhaps an argument to be made against this, along the lines
> of my remarks above about it being a vcpu ioctl).
> 

I could try ONE_REG if the banked registers access issue is not exist.
I'm not very familiar with x86 virtualization hw support, but i did refer to
x86 i8259.c code to implement this function for arm. And it looks the
KVM_SET_IRQCHIP/KVM_GET_IRQCHIP is designed for irqchip state save/retore.
Maybe the hw is too much different between x86 and arm.

> > However, by comparing to first method, the disadvantage of second method
> > is that it has side effect. Once the kernel vgic state code changes, it may
> > also need change the user space code accordingly since the user space
> > are using the kernel state definition.
> 
> Any approach that doesn't maintain binary compatibility across kernel
> versions is definitely not going to work. In particular you have to
> be able to accept state that may have been saved out by a different
> older kernel version (for doing VM migrations between host machines
> with different kernels installed).
> 
> By far the largest part of the save/restore work here is figuring out
> what the right state to expose to userspace is so we can retain that
> compatibility guarantee. Whether we then use ONE_REG or a single struct
> as the userspace view of that state is really a very minor part of it.
> This is the thing you really need to be thinking about and presenting
> as an RFC proposal, in my opinion.
> 

You're right, this is the key point.
Will reply you my thinking on your another mail in this thread.
Thanks for the suggestion.

Regards
Dong Aisheng
