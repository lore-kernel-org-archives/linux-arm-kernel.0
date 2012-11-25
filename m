From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun, 25 Nov 2012 21:17:02 +0100
Subject: [PATCH 1/4] apf27: enable Ethernet PHY
In-Reply-To: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
References: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <1353874625-14754-2-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At startup the Ethernet PHY is in power down mode, so we need
to force the "all capable" mode to activate it.

Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 arch/arm/mach-imx/imx27-dt.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index e80d523..f212f81 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -12,6 +12,8 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/delay.h>
+#include <linux/phy.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -32,8 +34,27 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
+int apf27_lan8700_wakeup(struct phy_device *phydev)
+{
+	int rc = phy_read(phydev, MII_DCOUNTER);
+
+	phy_write(phydev, MII_DCOUNTER, rc | 0xE0);
+	phy_write(phydev, MII_BMCR, BMCR_RESET);
+	udelay(1000);
+
+	return 0;
+}
+
+static void __init apf27_init(void)
+{
+	phy_register_fixup_for_id("imx27-fec.0-1:1f", apf27_lan8700_wakeup);
+}
+
 static void __init imx27_dt_init(void)
 {
+	if (of_machine_is_compatible("armadeus,imx27-apf27"))
+		apf27_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     imx27_auxdata_lookup, NULL);
 }
-- 
1.7.4.4
