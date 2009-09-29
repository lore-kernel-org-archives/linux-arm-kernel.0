From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Mon, 28 Sep 2009 20:43:15 -0500
Subject: U-Bit in CortexA8
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039AE1703C@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is there some reason for v7 to not allow alignment warnings and signals?

Today no matter how you set the A bit you are going to get hardware fix ups for alignment faults.  An mis-aligned access is almost never faster even if hardware fixes it up.  It seems people who want to know should have the ability to enable faults and check out the counters.  However, as U-bit on A8 is forever set we will never see any faults registered.

There is no U bit in ARMv7 so acting like there is seems a bit misleading.

static void omap_mask_ack_irq(unsigned int irq)
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 3a398be..09bb5b3 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -810,7 +810,7 @@ static int __init alignment_init(void)
         * CPUs since we spin re-faulting the instruction without
         * making any progress.
         */
-       if (cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U)) {
+       if (cpu_architecture() == CPU_ARCH_ARMv6 && (cr_alignment & CR_U)) {
                cr_alignment &= ~CR_A;
                cr_no_alignment &= ~CR_A;
                set_cr(cr_alignment);

Regards,
Richard W.
