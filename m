From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jul 2018 11:12:33 +0100
Subject: [PATCH v4 00/10] KVM: arm/arm64: vgic: Virtual interrupt grouping
 support
In-Reply-To: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
Message-ID: <96b935cc-9090-881e-8872-97650583b431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/18 14:06, Christoffer Dall wrote:
> This series addresses a peculiarity of the current VGIC
> implementation, namely that we don't support interrupt grouping.
> 
> KVM either implements a GICv2 without support for the security
> extensions, or a GICv3 with DS=1.  For GICv2, on systems without the
> security extensions, group 0 interrupts can be configured to be either
> signalled as FIQs or as IRQs by the VM, whereas group 1 interrupts are
> always IRQs.  For GICv3, with DS=1, group 1 interrupts are always IRQs
> and group 0 interrupts are always FIQs, and there is no concept of
> secure vs. non-secure group 1 interrupts when DS=1.
> 
> We were treating all interrupts on GICv2 as group 0, but yet telling the
> guest that they were group 1.  The first patch changes this behavior,
> which seems to have no effect on no known guests, but still.
> 
> The remaining patches introduce proper interrupt grouping support, along
> with MMIO accessors for the VM and userspace to retrieve and set the
> which group SGIs, PPIs, and SPIs belong to.  LPIs are always group 1
> interrupts as per the architecture, and there is no way to modify this
> configuration (no IGROUPR registers for LPIs or equivalent ITS
> commands).
> 
> Tested on Seattle, TX1, and the foundation model.  I've run a
> GICv2 guest on a GICv3 host on the foundation model.  I've tested
> migration on Seattle, and migration from an old kernel to a newer kernel
> with an unmodified QEMU binary continues to work.  I also tested a
> modified userspace that sets some interrupts to group 1, and that is
> reflected in the vgic debug output.

Applied to kvmarm/next

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
