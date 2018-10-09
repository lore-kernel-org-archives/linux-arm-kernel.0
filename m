From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  9 Oct 2018 14:47:03 +0100
Subject: [PATCH v2 0/3] arm64: cpufeature: Fix handling of CTR_EL0
Message-ID: <20181009134707.3479-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes sure that we handle the CTR_EL0 field mismatches
properly, especially for the IDC field. Also, skip trapping CTR
accesses on a CPU if it matches the safe value.

Applies on arm64 for-next/core.

Changes since v1
 - Fix wrong hunk in has_cache_idc()
 - Allow a late secondary CPU with raw CTR_EL0.IDC = 0 and effective
   CTR_EL0.IDC = 1, to boot on a system without IDC available.

Suzuki K Poulose (3):
  arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
  arm64: cpufeature: Fix handling of CTR_EL0.IDC field
  arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

 arch/arm64/include/asm/cache.h | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpufeature.c | 35 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++-
 4 files changed, 110 insertions(+), 9 deletions(-)

-- 
2.19.0
