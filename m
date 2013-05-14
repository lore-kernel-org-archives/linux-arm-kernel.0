From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:37 +0100
Subject: [PATCH 1/8] ARM: mpu: add PMSA related registers and bitfields to
 existing headers
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the following definitions relevant to the PMSA:

Add SCTLR bit 17, (CR_BR - Background Region bit) to the list of CR_*
bitfields. This bit determines whether to use the architecturally defined
memory map

Add the MPUIR to the available registers when using read_cpuid macro. The
MPUIR is the MPU type register.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/cp15.h    |    5 +++++
 arch/arm/include/asm/cputype.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 1f3262e..a524a23 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -23,6 +23,11 @@
 #define CR_RR	(1 << 14)	/* Round Robin cache replacement	*/
 #define CR_L4	(1 << 15)	/* LDR pc can set T bit			*/
 #define CR_DT	(1 << 16)
+#ifdef CONFIG_MMU
+#define CR_HA	(1 << 17)	/* Hardware management of Access Flag   */
+#else
+#define CR_BR	(1 << 17)	/* MPU Background region enable (PMSA)  */
+#endif
 #define CR_IT	(1 << 18)
 #define CR_ST	(1 << 19)
 #define CR_FI	(1 << 21)	/* Fast interrupt (lower latency mode)	*/
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 7652712..a29bc43 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -8,6 +8,7 @@
 #define CPUID_CACHETYPE	1
 #define CPUID_TCM	2
 #define CPUID_TLBTYPE	3
+#define CPUID_MPUIR	4
 #define CPUID_MPIDR	5
 
 #define CPUID_EXT_PFR0	"c1, 0"
-- 
1.7.9.5
