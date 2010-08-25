From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:40 -0700
Subject: [PATCH 11/24] msm: 8x60: gic initialization fixup for RUMI
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-12-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

On RUMI platform STIs are not enabled by default, contrary to the
GIC spec. The bits for STIs in the enable/enable clear registers
are also RW instead of RO. STIs need to be enabled at initialization
time.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8x60.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 3ab4bd9..c6bf8e3 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -18,6 +18,8 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/io.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -42,9 +44,28 @@ static void __init msm8x60_map_io(void)
 
 static void __init msm8x60_init_irq(void)
 {
+	unsigned int i;
+
 	gic_dist_init(0, MSM_QGIC_DIST_BASE, 1);
 	gic_cpu_base_addr = (void *)MSM_QGIC_CPU_BASE;
 	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
+
+	/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
+	writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
+
+	/* RUMI does not adhere to GIC spec by enabling STIs by default.
+	 * Enable/clear is supposed to be RO for STIs, but is RW on RUMI.
+	 */
+	writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
+
+	/* FIXME: Not installing AVS_SVICINT and AVS_SVICINTSWDONE yet
+	 * as they are configured as level, which does not play nice with
+	 * handle_percpu_irq.
+	 */
+	for (i = GIC_PPI_START; i < GIC_SPI_START; i++) {
+		if (i != AVS_SVICINT && i != AVS_SVICINTSWDONE)
+			set_irq_handler(i, handle_percpu_irq);
+	}
 }
 
 static void __init msm8x60_init(void)
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
