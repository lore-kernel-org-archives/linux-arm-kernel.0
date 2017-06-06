From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Jun 2017 19:08:32 +0100
Subject: [PATCH 0/3] arm/arm64: KVM: SCTLR_EL2/HSCTLR setup fixes
Message-ID: <20170606180835.14421-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of issues have recently cropped up regarding the way we setup
SCTLR_EL2:

(1) We accidentally zero some RES1 bits. This doesn't have any impact
    on current revision of the architecture, but may have unexpected
    impacts on future revisions.

(2) We set SCTLR_EL2.A (trap on aligned accesses), but don't provide
    any code to handle such trap (we panic). So far, this has never
    been an issue, but GCC 7 has started emiting such accesses, and
    the EL2 code explodes. The best course of action is actually to
    let these accesses take place, as we don't have any particular
    restrictions there.

This short series addresses both issues, and provides (2) for 32bit
ARM as well (though we haven't had any report of that exploding yet).

Marc Zyngier (3):
  arm64: KVM: Preserve RES1 bits in SCTLR_EL2
  arm64: KVM: Allow unaligned accesses at EL2
  arm: KVM: Allow unaligned accesses at HYP

 arch/arm/kvm/init.S             |  5 ++---
 arch/arm64/include/asm/sysreg.h |  4 ++++
 arch/arm64/kvm/hyp-init.S       | 11 +++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.11.0
