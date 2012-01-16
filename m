From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 15:44:18 +0000
Subject: [PATCH 2/2] ARM: cache: assume 64-byte L1 cachelines for ARMv7 CPUs
In-Reply-To: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
References: <1326728658-10029-1-git-send-email-will.deacon@arm.com>
Message-ID: <1326728658-10029-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To ensure correct alignment of cacheline-aligned data, the maximum
cacheline size needs to be known at compile time.

Since Cortex-A8 and Cortex-A15 have 64-byte cachelines (and it is likely
that there will be future ARMv7 implementations with the same line size)
then it makes sense to assume that CPU_V7 implies a 64-byte L1 cacheline
size. For CPUs with smaller caches, this will result in some harmless
padding but will help with single zImage work and avoid hitting subtle
bugs with misaligned data structures.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4cefb57..493e5ea5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -887,7 +887,7 @@ config ARM_L1_CACHE_SHIFT_6
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARM_L1_CACHE_SHIFT_6
+	default 6 if ARM_L1_CACHE_SHIFT_6 || CPU_V7
 	default 5
 
 config ARM_DMA_MEM_BUFFERABLE
-- 
1.7.4.1
