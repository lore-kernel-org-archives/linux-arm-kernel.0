From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 16:36:11 -0500
Subject: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB)
 for secondary cores
Message-ID: <20180612213611.2484-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
ICIALLU) when branch hardening is enabled for kernel.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on: next-20180612 +
Uboot series posted:  https://marc.info/?l=u-boot&m=152883522011042&w=2

With Just u-boot changes alone: OMAP5-uevm: https://pastebin.ubuntu.com/p/9yDM22bJ6n/
with kernel changes added on: https://pastebin.ubuntu.com/p/gXPBGGYRPX/

 arch/arm/mach-omap2/omap-smp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 69df3620eca5..28fc80ea675b 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,6 +109,32 @@ void omap5_erratum_workaround_801819(void)
 static inline void omap5_erratum_workaround_801819(void) { }
 #endif
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+static void omap5_harden_predictor(void)
+{
+	u32 acr, acr_mask;
+
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+
+	/*
+	 * BIT(0) - Disables streaming. All write-allocate lines allocate in
+	 */
+	acr_mask = BIT(0);
+
+	/* do we already have it done.. if yes, skip expensive smc */
+	if ((acr & acr_mask) == acr_mask)
+		return;
+
+	acr |= acr_mask;
+	omap_smc1(OMAP5_DRA7_MON_SET_ACR_INDEX, acr);
+
+	pr_debug("%s: ARM ACR setup for CVE_2017_5715 applied on CPU%d\n",
+		 __func__, smp_processor_id());
+}
+#else
+static inline void omap5_harden_predictor(void) { }
+#endif
+
 static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
@@ -131,6 +157,8 @@ static void omap4_secondary_init(unsigned int cpu)
 		set_cntfreq();
 		/* Configure ACR to disable streaming WA for 801819 */
 		omap5_erratum_workaround_801819();
+		/* Enable ACR to allow for ICUALLU workaround */
+		omap5_harden_predictor();
 	}
 
 	/*
-- 
2.15.1
