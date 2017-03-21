From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Mar 2017 12:05:25 +0100
Subject: [PATCH 0/5] Clarify GICC_PMR export format and remove struct vmcr
Message-ID: <20170321110530.15857-1-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series addresses two issues with the way we export the GIC
CPU interface registers to userspace.

First, we clarify that the ABI is slightly broken and misleading, in
that we export the GICC_PMR using an invented format where we put the
GICH_VMCR.VMPriMask field in the lower five bits of the GICC_PMR
exported to userspace.

Second, since we don't have any non-version-specific users of the struct
vmcr representation, we don't have any clear benefit of using this
indirection inside the kernel, and this has already led to confusion.
Instead, slightly rework some of the user access functions and get rid
of the VMCR structure entirely, which results in a rather nice diffstat
considering I've added quite a few lines of comments.

Based on v4.11-rc1.

Thanks,
-Christoffer

Christoffer Dall (5):
  KVM: arm/arm64: Clarify GICC_PMR export format
  KVM: arm64: vgic: Factor out access_gic_ctlr into separate r/w
    functions
  KVM: arm64: vgic: Rename vgic_v3_cpu to vgic_cpu
  KVM: arm64: vgic: Get rid of struct vmcr for GICv3
  KVM: arm/arm64: vgic: Get rid of struct vmcr for GICv2

 Documentation/virtual/kvm/devices/arm-vgic.txt |   6 +
 arch/arm64/kvm/vgic-sys-reg-v3.c               | 239 ++++++++++++-------------
 virt/kvm/arm/vgic/vgic-mmio-v2.c               |  51 ++++--
 virt/kvm/arm/vgic/vgic-mmio.c                  |  16 --
 virt/kvm/arm/vgic/vgic-v2.c                    |  29 ---
 virt/kvm/arm/vgic/vgic-v3.c                    |  38 ----
 virt/kvm/arm/vgic/vgic.h                       |  16 --
 7 files changed, 155 insertions(+), 240 deletions(-)

-- 
2.9.0
