From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:57 +0900
Subject: [PATCH 07/11] ARM: shmobile: r8a7778: add support I2C driver
In-Reply-To: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106861-25626-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a platform device for the r8a7778 I2C.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index b5173b3..9e5835b 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -24,6 +24,8 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
+extern void r8a7778_add_i2c_device(int id);
+
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index ce44fbb..6625a38 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -126,6 +126,31 @@ void __init r8a7778_sdhi_init(int id,
 		info, sizeof(*info));
 }
 
+/* I2C */
+static struct resource i2c_resources[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xffc70000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x63)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xffc71000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6e)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xffc72000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6c)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xffc73000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6d)),
+};
+
+void __init r8a7778_add_i2c_device(int id)
+{
+	BUG_ON(id < 0 || id > 3);
+
+	platform_device_register_simple(
+		"i2c-rcar", id,
+		i2c_resources + (2 * id), 2);
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.8.2.1
