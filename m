From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  4 Jul 2018 23:07:44 +0100
Subject: [PATCH 0/2] arm64: Handle mismatched cache type registers
Message-ID: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, we detect mismatches in the cache line sizes (exposed
via CTR_EL0) across CPUs and trap userspace accesses to the register
to provide a system wide safe value. We also hotpatch the kernel
to use the safe values for kernel cache operations.

However, with the recent additions of IDC & DIC fields to the CTR,
our checks could detect the mismatch and take all the steps above
with a following message:

"CPU features: enabling workaround for Mismatched cache line size"

which could be confusing even if the cache line sizes match.
Also the kernel doesn't need patching if there is no minline
size mismatch. This series fixes this issue by splitting the
checks to :

 1) Mismatch on D/I minline sizes
 2) Everything "strict" except (1).


Applies on 4.18-rc2

Suzuki K Poulose (2):
  arm64: Fix mismatched cache line size detection
  arm64: Handle mismatched cache type

 arch/arm64/include/asm/cache.h   |  4 ++++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 23 ++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c   |  2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.9.5
