From: gleb@redhat.com (Gleb Natapov)
Date: Tue, 15 Jan 2013 14:52:41 +0200
Subject: [kvmarm] [PATCH v5 06/14] KVM: ARM: Inject IRQs and FIQs from
 userspace
In-Reply-To: <CAFEAcA9wEtXu6B-4bUuezntvybhu8MCYfciKhdLK_Cs--qP8_w@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183917.46302.55603.stgit@ubuntu>
 <20130115095622.GJ11529@redhat.com>
 <CAFEAcA9wEtXu6B-4bUuezntvybhu8MCYfciKhdLK_Cs--qP8_w@mail.gmail.com>
Message-ID: <20130115125241.GK11529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 12:15:01PM +0000, Peter Maydell wrote:
> On 15 January 2013 09:56, Gleb Natapov <gleb@redhat.com> wrote:
> > On Tue, Jan 08, 2013 at 01:39:17PM -0500, Christoffer Dall wrote:
> >> From: Christoffer Dall <cdall@cs.columbia.edu>
> >>
> >> All interrupt injection is now based on the VM ioctl KVM_IRQ_LINE.  This
> >> works semantically well for the GIC as we in fact raise/lower a line on
> >> a machine component (the gic).  The IOCTL uses the follwing struct.
> >>
> >> struct kvm_irq_level {
> >>       union {
> >>               __u32 irq;     /* GSI */
> >>               __s32 status;  /* not used for KVM_IRQ_LEVEL */
> >>       };
> >>       __u32 level;           /* 0 or 1 */
> >> };
> >>
> >> ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
> > CPU level interrupt should use KVM_INTERRUPT instead.
> 
> No, that would be wrong. KVM_INTERRUPT is for interrupts which must be
> delivered synchronously to the CPU. KVM_IRQ_LINE is for interrupts which
> can be fed to the kernel asynchronously. It happens that on x86 "must be
> delivered synchronously" and "not going to in kernel irqchip" are the same, but
> this isn't true for other archs. For ARM all our interrupts can be fed
> to the kernel
> asynchronously, and so we use KVM_IRQ_LINE in all cases.
> 
I do no quite understand what you mean by synchronously and
asynchronously. The difference between KVM_INTERRUPT and KVM_IRQ_LINE line
is that former is used when destination cpu is known to userspace later
is used when kernel code is involved in figuring out the destination. The
injections themselves are currently synchronous for both of them on x86
and ARM. i.e vcpu is kicked out from guest mode when interrupt need to
be injected into a guest and vcpu state is changed to inject interrupt
during next guest entry. In the near feature x86 will be able to inject
interrupt without kicking vcpu out from the guest mode does ARM plan to
do the same? For GIC interrupts or for IRQ/FIQ or for both?

> There was a big discussion thread about this on kvm and qemu-devel last
> July (and we cleaned up some of the QEMU code to not smoosh together
> all these different concepts under "do I have an irqchip or not?").
Do you have a pointer?

> 
> >> (GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
> >> specific cpus.  The irq field is interpreted like this:
> >>
> > Haven't read about GIC yet. Is PPI an interrupt that device can send
> > directly to a specific CPU? Can we model that with irq routing like we do
> > for MSI?
> 
> There is no routing involved -- you are raising a specific signal
> line (which happens to result in prodding a particular CPU), that's all.
> 
We call it "irq routing", but it is not really a router. It just a
configuration to let KVM know how specific lines are wired. We abuse it
for MSI injection. So instead of encoding destination into kvm_irq_level
you configure "irq routing" entry with this information and get back a
cookie. You provide the cookie in kvm_irq_level->irq to KVM_IRQ_LEVEL
ioctl. This way you are not limited to 8 bit of cpuid for instance. This
is not efficient if "irq routing" is very dynamic though.
 
--
			Gleb.
