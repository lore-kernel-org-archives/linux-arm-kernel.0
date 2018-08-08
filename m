From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  8 Aug 2018 17:31:47 +0200
Subject: [PATCH 25/28] ARM: davinci: remove dead code related to MAC address
 reading
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Message-ID: <20180808153150.23444-26-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it. Also
remove the mac_addr field from the emac platform data struct.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7ba84e9..0c6cc354a4aa 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -28,21 +28,6 @@ EXPORT_SYMBOL(davinci_soc_info);
 void __iomem *davinci_intc_base;
 int davinci_intc_type;
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	off_t offset = (off_t)context;
-
-	if (!IS_BUILTIN(CONFIG_NVMEM)) {
-		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
-		return;
-	}
-
-	/* Read MAC addr from EEPROM */
-	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
-		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-}
-
 static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 {
 	int			i;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 05b97144d342..19888b27706d 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -19,7 +19,6 @@ struct mdio_platform_data {
 };
 
 struct emac_platform_data {
-	char mac_addr[ETH_ALEN];
 	u32 ctrl_reg_offset;
 	u32 ctrl_mod_reg_offset;
 	u32 ctrl_ram_offset;
@@ -46,5 +45,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.18.0
