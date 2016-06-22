From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jun 2016 09:26:12 +0100
Subject: [PATCH v6 05/15] KVM: arm/arm64: VGIC: add refcounting for IRQs
In-Reply-To: <331a1fa6-1a53-cd83-fba2-6d2018765bba@arm.com>
References: <1466165327-32060-1-git-send-email-andre.przywara@arm.com>
 <1466165327-32060-6-git-send-email-andre.przywara@arm.com>
 <331a1fa6-1a53-cd83-fba2-6d2018765bba@arm.com>
Message-ID: <576A4BA4.6090103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/16 09:18, Andre Przywara wrote:
> Hi Marc,
> 
> On 17/06/16 13:08, Andre Przywara wrote:
>> In the moment our struct vgic_irq's are statically allocated at guest
>> creation time. So getting a pointer to an IRQ structure is trivial and
>> safe. LPIs are more dynamic, they can be mapped and unmapped at any time
>> during the guest's _runtime_.
>> In preparation for supporting LPIs we introduce reference counting to
>> those structures. Since private IRQs and SPIs are statically allocated,
>> the reqcount never drops to 0 at the moment, but we increase it when an
>> IRQ gets onto a VCPU list and decrease it when it gets removed.
>> Also vgic_get_irq() gets changed to take the irq_lock already, this is
>> later needed to avoid a race between a potential LPI unmap and the
>> window between us getting the pointer and locking the IRQ.
>> This introduces vgic_put_irq(), which just does the unlock and makes
>> the new locking sequence look more symmetrical.
>> This approach deviates from the classical Linux refcounting with using
>> atomic_* types and functions, because the users of vgic_get_irq() take
>> the irq_lock anyway, so we just use an int and adjust the refcount while
>> holding the lock.
> 
> As discussed verbally, I am almost done on an implementation that uses
> the kernel's kref_* infrastructure to implement the ref-counting, on top
> of the existing vgic_irq locking.
> Since we consider the atomic inc/dec operations comparably cheap, that
> shouldn't sacrifice performance, but will increase readability and
> avoids nasty bugs in our own refcounting implementation by using well
> tested and reviewed code.

Indeed. And for further reference, here's the reason why I'm pushing for
kref being used: https://lwn.net/Articles/75920/

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
