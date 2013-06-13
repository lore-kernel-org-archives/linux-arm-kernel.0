From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:58 +0900
Subject: [PATCH 08/11] ARM: shmobile: r8a7778: add support HSPI driver
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a platform device for the r8a7778 HSPI.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 9e5835b..af668c4 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -25,6 +25,7 @@ extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
+extern void r8a7778_add_hspi_device(int id);
 
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6625a38..a1e6930 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -151,6 +151,29 @@ void __init r8a7778_add_i2c_device(int id)
 		i2c_resources + (2 * id), 2);
 }
 
+/* HSPI */
+static struct resource hspi_resources[] __initdata = {
+	/* HSPI0 */
+	DEFINE_RES_MEM(0xfffc7000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x5f)),
+	/* HSPI1 */
+	DEFINE_RES_MEM(0xfffc8000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x74)),
+	/* HSPI2 */
+	DEFINE_RES_MEM(0xfffc6000, 0x18),
+	DEFINE_RES_IRQ(gic_iid(0x75)),
+};
+
+void __init r8a7778_add_hspi_device(int id)
+{
+	BUG_ON(id < 0 || id > 2);
+
+	platform_device_register_simple(
+		"sh-hspi", id,
+		hspi_resources + (2 * id), 2);
+}
+
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.8.2.1
