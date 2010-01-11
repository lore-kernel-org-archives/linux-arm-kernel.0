From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:28 -0800
Subject: [RFC 09/18] arm: mm: support error reporting in L1/L2 caches on QSD
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-10-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

The Scorpion processor supports reporting L2 errors, L1 icache parity
errors, and L1 dcache parity errors as imprecise external aborts. If
this option is not enabled these errors will go unreported and data
corruption will occur.

Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/Kconfig   |    8 ++++++++
 arch/arm/mm/proc-v7.S |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index baf6384..8ae3fce 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -687,6 +687,14 @@ config CPU_DCACHE_SIZE
 	  If your SoC is configured to have a different size, define the value
 	  here with proper conditions.
 
+config CPU_CACHE_ERR_REPORT
+	bool "Report errors in the L1 and L2 caches"
+	depends on ARCH_MSM_SCORPION
+	default y
+	help
+	  Say Y here to have errors in the L1 and L2 caches reported as
+	  imprecise data aborts.
+
 config CPU_DCACHE_WRITETHROUGH
 	bool "Force write through D-cache"
 	depends on (CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b331f23..88da392 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -241,6 +241,14 @@ __v7_setup:
 #ifdef CONFIG_ARCH_MSM_SCORPION
 	mov     r0, #0x77
 	mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
+
+	mrc     p15, 0, r0, c1, c0, 1           @ read ACTLR
+#ifdef CONFIG_CPU_CACHE_ERR_REPORT
+	orr     r0, r0, #0x37                   @ turn on L1/L2 error reporting
+#else
+	bic     r0, r0, #0x37
+#endif
+	mcr     p15, 0, r0, c1, c0, 1           @ write ACTLR
 #endif
 	/*
 	 * Memory region attributes with SCTLR.TRE=1
-- 
1.6.3.3
