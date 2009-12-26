From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 26 Dec 2009 21:25:49 +0100
Subject: [PATCH 3/4] pxa/zeus: Relax memory timings on Zeus ethernet ports
In-Reply-To: <1261859150-17335-3-git-send-email-maz@misterjones.org>
References: <1261859150-17335-1-git-send-email-maz@misterjones.org>
	<1261859150-17335-2-git-send-email-maz@misterjones.org>
	<1261859150-17335-3-git-send-email-maz@misterjones.org>
Message-ID: <1261859150-17335-4-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DM9000s on Zeus sometime fail under heavy load.
Relaxing the timings a bit seems to be of a great help.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/zeus.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 865df5d..7ddd265 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -726,9 +726,18 @@ static mfp_cfg_t zeus_pin_config[] __initdata = {
 	GPIO99_GPIO,		/* CF RDY */
 };
 
+/* 
+ * DM9k MSCx settings:	SRAM, 16 bits
+ *			17 cycles delay first access
+ *			 5 cycles delay next access
+ *			13 cycles recovery time
+ *			faster device
+ */
+#define DM9K_MSC_VALUE		0xe4c9;
+
 static void __init zeus_init(void)
 {
-	u16 dm9000_msc = 0xe279;
+	u16 dm9000_msc = DM9K_MSC_VALUE;
 
 	system_rev = __raw_readw(ZEUS_CPLD_VERSION);
 	pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4, (system_rev & 0x0f));
-- 
1.6.5.7
