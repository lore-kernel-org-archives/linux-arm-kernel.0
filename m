From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 26 Jun 2018 12:22:33 +0200
Subject: [PATCH v2 03/15] ARM: davinci: dm644-evm: use nvmem lookup for mac
 address
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Message-ID: <20180626102245.30711-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 48436f74fd71..adbe8630ef19 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -28,6 +28,7 @@
 #include <linux/v4l2-dv-timings.h>
 #include <linux/export.h>
 #include <linux/leds.h>
+#include <linux/nvmem-provider.h>
 
 #include <media/i2c/tvp514x.h>
 
@@ -476,6 +477,15 @@ static struct pcf857x_platform_data pcf_data_u35 = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len	= (256*1024) / 8,
 	.page_size	= 64,
@@ -828,6 +838,8 @@ static __init void davinci_evm_init(void)
 		phy_register_fixup_for_uid(LXT971_PHY_ID, LXT971_PHY_MASK,
 						davinci_phy_fixup);
 	}
+
+	nvmem_register_lookup(&dm6446evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
-- 
2.17.1
