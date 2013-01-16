From: gleb@redhat.com (Gleb Natapov)
Date: Wed, 16 Jan 2013 12:40:55 +0200
Subject: [kvmarm] [PATCH v5 06/14] KVM: ARM: Inject IRQs and FIQs from
 userspace
In-Reply-To: <50F582E9.40402@suse.de>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183917.46302.55603.stgit@ubuntu>
 <20130115095622.GJ11529@redhat.com>
 <CAFEAcA9wEtXu6B-4bUuezntvybhu8MCYfciKhdLK_Cs--qP8_w@mail.gmail.com>
 <20130115125241.GK11529@redhat.com>
 <CAFEAcA8gzD4F4BPKR_dSDDD-iyv0ONt6H+yrj_nHifeCFBfpPA@mail.gmail.com>
 <20130115151757.GD12489@redhat.com> <50F582E9.40402@suse.de>
Message-ID: <20130116104055.GQ11529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 05:25:13PM +0100, Alexander Graf wrote:
> On 01/15/2013 04:17 PM, Gleb Natapov wrote:
> >On Tue, Jan 15, 2013 at 02:04:47PM +0000, Peter Maydell wrote:
> >>On 15 January 2013 12:52, Gleb Natapov<gleb@redhat.com>  wrote:
> >>>On Tue, Jan 15, 2013 at 12:15:01PM +0000, Peter Maydell wrote:
> >>>>On 15 January 2013 09:56, Gleb Natapov<gleb@redhat.com>  wrote:
> >>>>>>ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
> >>>>>CPU level interrupt should use KVM_INTERRUPT instead.
> >>>>No, that would be wrong. KVM_INTERRUPT is for interrupts which must be
> >>>>delivered synchronously to the CPU. KVM_IRQ_LINE is for interrupts which
> >>>>can be fed to the kernel asynchronously. It happens that on x86 "must be
> >>>>delivered synchronously" and "not going to in kernel irqchip" are the same, but
> >>>>this isn't true for other archs. For ARM all our interrupts can be fed
> >>>>to the kernel asynchronously, and so we use KVM_IRQ_LINE in all
> >>>>cases.
> >>>I do no quite understand what you mean by synchronously and
> >>>asynchronously.
> >>Synchronously: the vcpu has to be stopped and userspace then
> >>feeds in the interrupt to be taken when the guest is resumed.
> >>Asynchronously: any old thread can tell the kernel there's an
> >>interrupt, and the guest vcpu then deals with it when needed
> >>(the vcpu thread may leave the guest but doesn't come out of
> >>the host kernel to qemu).
> >>
> >>>The difference between KVM_INTERRUPT and KVM_IRQ_LINE line
> >>>is that former is used when destination cpu is known to userspace later
> >>>is used when kernel code is involved in figuring out the destination.
> >>This doesn't match up with Avi's explanation at all.
> >>
> >>>The
> >>>injections themselves are currently synchronous for both of them on x86
> >>>and ARM. i.e vcpu is kicked out from guest mode when interrupt need to
> >>>be injected into a guest and vcpu state is changed to inject interrupt
> >>>during next guest entry. In the near feature x86 will be able to inject
> >>>interrupt without kicking vcpu out from the guest mode does ARM plan to
> >>>do the same? For GIC interrupts or for IRQ/FIQ or for both?
> >>>
> >>>>There was a big discussion thread about this on kvm and qemu-devel last
> >>>>July (and we cleaned up some of the QEMU code to not smoosh together
> >>>>all these different concepts under "do I have an irqchip or not?").
> >>>Do you have a pointer?
> >>   http://lists.gnu.org/archive/html/qemu-devel/2012-07/msg02460.html
> >>and there was a later longer (but less clear) thread which included
> >>this mail from Avi:
> >>   http://lists.gnu.org/archive/html/qemu-devel/2012-07/msg02872.html
> >>basically explaining that the reason for the weird synchronous
> >>KVM_INTERRUPT API is that it's emulating a weird synchronous
> >>hardware interface which is specific to x86. ARM doesn't have
> >>a synchronous interface in the same way, so it's much more
> >>straightforward to use KVM_IRQ_LINE.
> >>
> >OK. I see. So basically Avi saw KVM_INTERRUPT as an oddball interface
> >required only for APIC emulation in userspace. It is used for PIC also,
> >where this is not strictly needed, but this is for historical reasons
> >(KVM_IRQ_LINE was introduces late and it is GSI centric on x86).
> >
> >Thank you for the pointer.
> 
> Yeah, please keep in mind that KVM_INTERRUPT is not a unified
> interface either. In fact, it is asynchronous on PPC :). And it's
> called KVM_S390_INTERRUPT on s390 and also asynchronous. X86 is the
> oddball here.
> 
KVM_INTERRUPT needs vcpu fd to be issues. Usually such ioctls are
issued only by vcpu thread which makes them synchronous and vcpu_load()
synchronise them anyway if the rule is not met. And sure enough those
KVM_S390_INTERRUPT/KVM_INTERRUPT are special cased in kvm_vcpu_ioctl()
to not call vcpu_load(), sigh :(

There was an idea to change vcpu ioctls to kvm syscall which would have
made it impossible to use KVM_INTERRUPT asynchronously.


> But I don't care whether we call the ioctl to steer CPU interrupt
> pins KVM_INTERRUPT, KVM_S390_INTERRUPT or KVM_IRQ_LINE, as long as
> the code makes it obvious what is happening.
> 
Some consistency would be nice though. You do not always look at the
kernel code when you read userspace code and iothread calling KVM_INTERRUPT
would have made me suspicious.

--
			Gleb.
