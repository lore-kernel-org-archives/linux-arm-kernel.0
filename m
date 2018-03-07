From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 Mar 2018 12:40:53 +0000
Subject: [PATCH 0/2] KVM: arm/arm64: GICv2-on-v3 fixes
Message-ID: <20180307124055.13800-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been trying to run VMs on a GICv3-based system that offers the
GICv2 compatibility feature, and noticed that they would tend to
slowly die under load.

It turned out that this is due to KVM not being exactly true to the
architecture, and ends up injecting multiple SGI with the same vintid,
which the architecture clearly outlines as a "don't do that". This bug
has been there since the first days of the "new vgic".

Another issue is that we don't use the right barriers when exiting
from the guest, as we only synchronize stores, while the architecture
requires to synchronize both loads and stores. And we miss an isb to
force execution of the previous dsb.

Unless someone shouts, I'm planning to take these patches into 4.16 as
they directly affect my laptop (yes, I'm biased).

Marc Zyngier (2):
  KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid
  kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2
    on v3

 virt/kvm/arm/hyp/vgic-v3-sr.c |  3 ++-
 virt/kvm/arm/vgic/vgic.c      | 11 +----------
 2 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.14.2
