From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 6 Mar 2018 11:49:06 +0000
Subject: [PATCH] KVM: arm/arm64: VGIC MMIO: add missing irq_lock
In-Reply-To: <20180306092106.13044-1-andre.przywara@arm.com>
References: <20180306092106.13044-1-andre.przywara@arm.com>
Message-ID: <292d6ef0-9adf-361a-42f4-5051af6a18e9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/03/18 09:21, Andre Przywara wrote:
> Our irq_is_pending() helper function accesses multiple members of the
> vgic_irq struct, so we need to hold the lock when calling it.
> Add that requirement as a comment to the definition and take the lock
> around the call in vgic_mmio_read_pending(), where we were missing it
> before.

for the records and since Marc asked for it:
Currently we have the following users of irq_is_pending():
- vgic_v2_populate_lr(): The irq_lock must be held by the caller.
- vgic_v3_populate_lr(): The irq_lock must be held by the caller.
- vgic_irq_cmp(): locks are taken around the call
- kvm_vgic_vcpu_pending_irq(): lock are taken around the call
- vgic_target_oracle(): The irq_lock must be held by the caller

So vgic_mmio_read_pending() is the only instance right now where we
don't get the lock.

Cheers,
Andre.
