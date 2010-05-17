From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 17 May 2010 10:27:38 +1000
Subject: [PATCH] phy/marvell: Add special settings for D-Link DNS-323 rev C1
Message-ID: <1274056058.21352.697.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this change, the network LED doesn't work on the device. The
value itself comes from the vendor kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/net/phy/marvell.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 64c7fbe..22b1efa 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -34,6 +34,10 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_ARM
+#include <asm/mach-types.h>
+#endif
+
 #define MII_M1011_IEVENT		0x13
 #define MII_M1011_IEVENT_CLEAR		0x0000
 
@@ -350,7 +354,14 @@ static int m88e1118_config_init(struct phy_device *phydev)
 		return err;
 
 	/* Adjust LED Control */
+#ifdef CONFIG_MACH_DNS323
+	/* The DNS-323 needs a special value in here for the LED to work */
+	if (machine_is_dns323())
+		err = phy_write(phydev, 0x10, 0x1100);
+	else
+#else
 	err = phy_write(phydev, 0x10, 0x021e);
+#endif
 	if (err < 0)
 		return err;
 
