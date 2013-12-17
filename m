From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 12:16:17 +0000
Subject: [PATCH 2/2] ARM: kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS for
 CPUv6+ && MMU
In-Reply-To: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
References: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
Message-ID: <1387282577-2753-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARM CPUs can perform efficient unaligned memory accesses in
hardware and this feature is relied up on by code such as the dcache
word-at-a-time name hashing.

This patch selects HAVE_EFFICIENT_UNALIGNED_ACCESS for these cores and
reworks the kconfig select logic for DCACHE_WORD_ACCESS to use the new
symbol.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 38ccfd0adbf9..f8c64af7c768 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,7 +11,7 @@ config ARM
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
-	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
+	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IDLE_POLL_SETUP
@@ -35,6 +35,7 @@ config ARM
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
-- 
1.8.2.2
