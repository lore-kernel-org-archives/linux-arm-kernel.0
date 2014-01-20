From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 20 Jan 2014 12:44:15 +0100
Subject: [PATCH v2] can: flexcan: fix flexcan driver build for big endian on
 ARM and little endian on PowerPc
In-Reply-To: <52DD0A5E.6010303@pengutronix.de>
References: <52DD0A5E.6010303@pengutronix.de>
Message-ID: <1390218255-19074-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

There is no reason to disallow building the driver on big-endian ARM kernels.
Furthermore, the current behavior is actually broken on little-endian PowerPC
as well.

The choice of register accessor functions must purely depend on the CPU
architecture, not which endianess the CPU is running on. Note that we nowadays
allow both big-endian ARM and little-endian PowerPC kernels.

With this patch applied, we will do the right thing in all four combinations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
* squash the revert of the original patch with the wrong fix

 drivers/net/can/Kconfig   | 2 +-
 drivers/net/can/flexcan.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d447b88..9e7d95d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -104,7 +104,7 @@ config CAN_JANZ_ICAN3
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on (ARM && CPU_LITTLE_ENDIAN) || PPC
+	depends on ARM || PPC
 	---help---
 	  Say Y here if you want to support for Freescale FlexCAN.
 
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index aaed97b..320bef2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -235,9 +235,12 @@ static const struct can_bittiming_const flexcan_bittiming_const = {
 };
 
 /*
- * Abstract off the read/write for arm versus ppc.
+ * Abstract off the read/write for arm versus ppc. This
+ * assumes that PPC uses big-endian registers and everything
+ * else uses little-endian registers, independent of CPU
+ * endianess.
  */
-#if defined(__BIG_ENDIAN)
+#if defined(CONFIG_PPC)
 static inline u32 flexcan_read(void __iomem *addr)
 {
 	return in_be32(addr);
-- 
1.8.5.2
