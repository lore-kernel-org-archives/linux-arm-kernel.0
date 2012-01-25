From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:41:15 +0000
Subject: [PATCH 33/33] MFD: mcp-sa11x0/assabet: move assabet reset handling
 out of mcp-sa11x0.c
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq42F-0000a2-F7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the assabet specific reset handling out of mcp-sa11x0.c, into its
board file.  This leaves the mcp code free from all board specific
details.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    8 ++++++++
 drivers/mfd/mcp-sa11x0.c       |    6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index c45402f..b5955ad 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -70,6 +70,13 @@ void ASSABET_BCR_frob(unsigned int mask, unsigned int val)
 
 EXPORT_SYMBOL(ASSABET_BCR_frob);
 
+static void assabet_ucb1x00_reset(enum ucb1x00_reset state)
+{
+	if (state == UCB_RST_PROBE)
+		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
+}
+
+
 static void assabet_backlight_power(int on)
 {
 #ifndef ASSABET_PAL_VIDEO
@@ -201,6 +208,7 @@ static struct irda_platform_data assabet_irda_data = {
 };
 
 static struct ucb1x00_plat_data assabet_ucb1x00_data = {
+	.reset		= assabet_ucb1x00_reset,
 	.gpio_base	= -1,
 };
 
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index c381436..1c0ceac 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -27,8 +27,6 @@
 #include <asm/system.h>
 #include <mach/mcp.h>
 
-#include <mach/assabet.h>
-
 #define DRIVER_NAME "sa11x0-mcp"
 
 struct mcp_sa11x0 {
@@ -208,10 +206,6 @@ static int mcp_sa11x0_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, mcp);
 
-	if (machine_is_assabet()) {
-		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
-	}
-
 	/*
 	 * Initialise device.  Note that we initially
 	 * set the sampling rate to minimum.
-- 
1.7.4.4
