From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 15 Jan 2013 12:15:01 +0000
Subject: [kvmarm] [PATCH v5 06/14] KVM: ARM: Inject IRQs and FIQs from
 userspace
In-Reply-To: <20130115095622.GJ11529@redhat.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183917.46302.55603.stgit@ubuntu>
 <20130115095622.GJ11529@redhat.com>
Message-ID: <CAFEAcA9wEtXu6B-4bUuezntvybhu8MCYfciKhdLK_Cs--qP8_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2013 09:56, Gleb Natapov <gleb@redhat.com> wrote:
> On Tue, Jan 08, 2013 at 01:39:17PM -0500, Christoffer Dall wrote:
>> From: Christoffer Dall <cdall@cs.columbia.edu>
>>
>> All interrupt injection is now based on the VM ioctl KVM_IRQ_LINE.  This
>> works semantically well for the GIC as we in fact raise/lower a line on
>> a machine component (the gic).  The IOCTL uses the follwing struct.
>>
>> struct kvm_irq_level {
>>       union {
>>               __u32 irq;     /* GSI */
>>               __s32 status;  /* not used for KVM_IRQ_LEVEL */
>>       };
>>       __u32 level;           /* 0 or 1 */
>> };
>>
>> ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
> CPU level interrupt should use KVM_INTERRUPT instead.

No, that would be wrong. KVM_INTERRUPT is for interrupts which must be
delivered synchronously to the CPU. KVM_IRQ_LINE is for interrupts which
can be fed to the kernel asynchronously. It happens that on x86 "must be
delivered synchronously" and "not going to in kernel irqchip" are the same, but
this isn't true for other archs. For ARM all our interrupts can be fed
to the kernel
asynchronously, and so we use KVM_IRQ_LINE in all cases.

There was a big discussion thread about this on kvm and qemu-devel last
July (and we cleaned up some of the QEMU code to not smoosh together
all these different concepts under "do I have an irqchip or not?").

>> (GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
>> specific cpus.  The irq field is interpreted like this:
>>
> Haven't read about GIC yet. Is PPI an interrupt that device can send
> directly to a specific CPU? Can we model that with irq routing like we do
> for MSI?

There is no routing involved -- you are raising a specific signal
line (which happens to result in prodding a particular CPU), that's all.

-- PMM
