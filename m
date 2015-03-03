From: rockford@yandex.ru (Andrey Panov)
Date: Tue,  3 Mar 2015 20:42:59 +0300
Subject: [PATCH] ARM: i.MX6Q: Add fixup for RTL8211E Gigabit Ethernet PHY
Message-ID: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTL8211E Ethernet PHY found in Embedsky E9 board is need
an additional initialization.
Taken from vendor's binary-only module.

Signed-off-by: Andrey Panov <rockford@yandex.ru>
---
 arch/arm/mach-imx/mach-imx6q.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4ad6e47..41708f5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -166,6 +166,18 @@ static int ar8035_phy_fixup(struct phy_device *dev)
 
 #define PHY_ID_AR8035 0x004dd072
 
+static int rtl8211e_phy_fixup(struct phy_device *dev)
+{
+	phy_write(dev, 0x00, 0x3140);
+	mdelay(10);
+	phy_write(dev, 0x00, 0x3340);
+	mdelay(10);
+
+	return 0;
+}
+
+#define PHY_ID_RTL8211E 0x001cc915
+
 static void __init imx6q_enet_phy_init(void)
 {
 	if (IS_BUILTIN(CONFIG_PHYLIB)) {
@@ -177,6 +189,8 @@ static void __init imx6q_enet_phy_init(void)
 				ar8031_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
 				ar8035_phy_fixup);
+		phy_register_fixup_for_uid(PHY_ID_RTL8211E, 0xffffffff,
+				rtl8211e_phy_fixup);
 	}
 }
 
-- 
2.1.4
