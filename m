From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 10 Aug 2018 10:05:08 +0200
Subject: [PATCH v2 11/29] ARM: davinci: mityomapl138: add nvmem cells lookup
 entries
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Message-ID: <20180810080526.27207-12-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..48a9bae76e4a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,7 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
@@ -160,6 +161,25 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
+	{
+		.info = {
+			.name = "factory-config",
+			.offset = 0x0,
+			.bytes = sizeof(struct factory_config),
+		},
+		.nvmem_name = "1-00500",
+	},
+	{
+		.info = {
+			.name = "mac-address",
+			.offset = 0x64,
+			.bytes = ETH_ALEN,
+		},
+		.nvmem_name = "1-00500",
+	}
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -534,6 +554,8 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_add_lookup_table(mityomapl138_nvmem_cells,
+			       ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.18.0
