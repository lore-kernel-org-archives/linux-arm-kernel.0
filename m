From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 11 Sep 2017 22:01:04 +0900
Subject: [PATCH 5/5] nvmem: set nvmem->owner to nvmem->dev->driver->owner if
 unset
In-Reply-To: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1505134864-11975-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All nvmem drivers are supposed to set the owner field of struct
nvmem_config, but this matches nvmem->dev->driver->owner.

As far as I see in drivers/nvmem/ directory, all the drivers are
the case.  So, make nvmem_register() set the nvmem's owner to the
associated driver's owner unless nvmem_config sets otherwise.

Remove .owner settings in the drivers that are now redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/nvmem/bcm-ocotp.c      | 1 -
 drivers/nvmem/core.c           | 2 ++
 drivers/nvmem/imx-iim.c        | 1 -
 drivers/nvmem/imx-ocotp.c      | 1 -
 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 drivers/nvmem/lpc18xx_otp.c    | 1 -
 drivers/nvmem/meson-efuse.c    | 1 -
 drivers/nvmem/mtk-efuse.c      | 1 -
 drivers/nvmem/mxs-ocotp.c      | 1 -
 drivers/nvmem/qfprom.c         | 1 -
 drivers/nvmem/rockchip-efuse.c | 1 -
 drivers/nvmem/sunxi_sid.c      | 1 -
 drivers/nvmem/vf610-ocotp.c    | 1 -
 13 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 3c56e3b..5e9e324 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -232,7 +232,6 @@ static struct nvmem_config bcm_otpc_nvmem_config = {
 	.read_only = false,
 	.word_size = 4,
 	.stride = 4,
-	.owner = THIS_MODULE,
 	.reg_read = bcm_otpc_read,
 	.reg_write = bcm_otpc_write,
 };
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2ba5589..0d5e893 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -462,6 +462,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
+	if (!nvmem->owner && config->dev->driver)
+		nvmem->owner = config->dev->driver->owner;
 	nvmem->stride = config->stride;
 	nvmem->word_size = config->word_size;
 	nvmem->size = config->size;
diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index a599260..52cfe91d 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -133,7 +133,6 @@ static int imx_iim_probe(struct platform_device *pdev)
 	cfg.read_only = true,
 	cfg.word_size = 1,
 	cfg.stride = 1,
-	cfg.owner = THIS_MODULE,
 	cfg.reg_read = imx_iim_read,
 	cfg.dev = dev;
 	cfg.size = drvdata->nregs;
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 193ca8f..e57e2a5 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -303,7 +303,6 @@ static struct nvmem_config imx_ocotp_nvmem_config = {
 	.read_only = false,
 	.word_size = 4,
 	.stride = 4,
-	.owner = THIS_MODULE,
 	.reg_read = imx_ocotp_read,
 	.reg_write = imx_ocotp_write,
 };
diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index 6c7e2c4..b1af966 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -159,7 +159,6 @@ static struct nvmem_config lpc18xx_nvmem_config = {
 	.word_size = 4,
 	.reg_read = lpc18xx_eeprom_read,
 	.reg_write = lpc18xx_eeprom_gather_write,
-	.owner = THIS_MODULE,
 };
 
 static int lpc18xx_eeprom_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index be8d074..95268db 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -64,7 +64,6 @@ static struct nvmem_config lpc18xx_otp_nvmem_config = {
 	.read_only = true,
 	.word_size = LPC18XX_OTP_WORD_SIZE,
 	.stride = LPC18XX_OTP_WORD_SIZE,
-	.owner = THIS_MODULE,
 	.reg_read = lpc18xx_otp_read,
 };
 
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 70bfc98..dbedfce 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -37,7 +37,6 @@ static int meson_efuse_read(void *context, unsigned int offset,
 
 static struct nvmem_config econfig = {
 	.name = "meson-efuse",
-	.owner = THIS_MODULE,
 	.stride = 1,
 	.word_size = 1,
 	.read_only = true,
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index c4058b5..9ee3479 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -72,7 +72,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-	econfig.owner = THIS_MODULE;
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index d26dd03..7018e2e 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -118,7 +118,6 @@ static struct nvmem_config ocotp_config = {
 	.name = "mxs-ocotp",
 	.stride = 16,
 	.word_size = 4,
-	.owner = THIS_MODULE,
 	.reg_read = mxs_ocotp_read,
 };
 
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index b96730e..cb3b48b 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -56,7 +56,6 @@ static int qfprom_remove(struct platform_device *pdev)
 
 static struct nvmem_config econfig = {
 	.name = "qfprom",
-	.owner = THIS_MODULE,
 	.stride = 1,
 	.word_size = 1,
 	.reg_read = qfprom_reg_read,
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 63e3eb5..e292bbe 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -149,7 +149,6 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 
 static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
-	.owner = THIS_MODULE,
 	.stride = 1,
 	.word_size = 1,
 	.read_only = true,
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 0d6648b..1c3b5cf 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -40,7 +40,6 @@ static struct nvmem_config econfig = {
 	.read_only = true,
 	.stride = 4,
 	.word_size = 1,
-	.owner = THIS_MODULE,
 };
 
 struct sunxi_sid_cfg {
diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 72e4faa..5ae9e00 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -206,7 +206,6 @@ static int vf610_ocotp_read(void *context, unsigned int offset,
 
 static struct nvmem_config ocotp_config = {
 	.name = "ocotp",
-	.owner = THIS_MODULE,
 	.stride = 4,
 	.word_size = 4,
 	.reg_read = vf610_ocotp_read,
-- 
2.7.4
