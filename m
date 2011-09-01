From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  1 Sep 2011 13:27:23 +0100
Subject: [PATCH 5/5] mach-ux500: add a SoC ID (serial) callback for the u8500
In-Reply-To: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1314880043-22517-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch applied the Export SoC Information framework
will be able to callback into u8500 Platform code in order to
probe for the SoC's unique Identification (serial) number.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c               |   16 ++++++++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    4 ++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 655639e..9824cd3 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -167,6 +167,20 @@ static void __init db8500_add_gpios(void)
 			 IRQ_DB8500_GPIO0, &pdata);
 }
 
+static const char *db8500_get_soc_id(void)
+{
+	void __iomem *uid_base;
+	char buf[1024];
+	ssize_t sz = 0;
+	int i;
+
+	uid_base = __io_address(U8500_BB_UID_BASE);
+	for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
+		sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
+	}
+	return kasprintf(GFP_KERNEL, "%s", buf);
+}
+
 static int usb_db8500_rx_dma_cfg[] = {
 	DB8500_DMA_DEV38_USB_OTG_IEP_1_9,
 	DB8500_DMA_DEV37_USB_OTG_IEP_2_10,
@@ -208,6 +222,8 @@ void __init u8500_init_devices(void)
 		"cpufreq-u8500", -1, NULL, 0, NULL, 0);
 
 	if (soc_dev) {
+		soc_dev->pfn_soc_id = db8500_get_soc_id;
+
 		for (i=0; i<ARRAY_SIZE(platform_devs); i++)
 			platform_devs[i]->dev.parent = &soc_dev->dev;
 	}
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 0499971..f569d5c 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -166,4 +166,8 @@
 #define U8500_MODEM_BASE	0xe000000
 #define U8500_APE_BASE		0x6000000
 
+/* SoC identification number information */
+#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
+#define U8500_BB_UID_LENGTH 5
+
 #endif
-- 
1.7.4.1
