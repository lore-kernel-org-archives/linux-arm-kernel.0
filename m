From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 17 Dec 2015 10:16:17 -0500
Subject: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <CAGS+omA1mgmFH_JXffUTC-aq3rOy7dRYsdveiJ8LcnB5gg0ELw@mail.gmail.com>
References: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
 <1562792.sV6cmsyeOM@wuerfel> <56715136.3060908@gmail.com>
 <CAGS+omA1mgmFH_JXffUTC-aq3rOy7dRYsdveiJ8LcnB5gg0ELw@mail.gmail.com>
Message-ID: <20151217151617.GY2772@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver] On 17/12/2015 (Thu 10:52) Daniel Kurtz wrote:

[...]

> 
> Also, since scpsys' Kconfig is "bool" not "tristate" it isn't a real
> module so I think we should use:
> builtin_platform_driver not module_platform_driver
> 
> CC'ing Paul Gortmaker who seems to be on a mass
> builtin_platform_driver conversion at the moment, see:
> https://lkml.org/lkml/2015/12/9/952
> 

Good guess.  In my giant queue I have that change.  I just haven't got
around to the requisite triple check and multi arch rebuild tests and
put out a series for soc yet.  Here is the short list for soc:

drivers-soc-make-mediatek-mtk-scpsys.c-explicitly-no.patch
drivers-soc-make-qcom-spm.c-explicitly-non-modular.patch
drivers-soc-make-samsung-exynos-srom.c.c-explicitly-.patch
drivers-soc-make-sunxi_sram.c-explicitly-non-modular.patch
drivers-soc-tegra-make-fuse-tegra.c-explicitly-non-m.patch

...and here is the patch you predicted.  If someone wants to fold
the change into their work then great; I'll be happy to drop
mine and be with one less patch to herd along.

Paul.
--

 From eb32cc2c1db8192c08dd64af69cb172b3be4c98b Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 4 Sep 2015 19:33:54 -0400
Subject: [PATCH] drivers/soc: make mediatek/mtk-scpsys.c explicitly
 non-modular

The Kconfig currently controlling compilation of this code is:

drivers/soc/mediatek/Kconfig:config MTK_SCPSYS
drivers/soc/mediatek/Kconfig:   bool "MediaTek SCPSYS Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modularity so that when reading the
driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 164a7d8439b1..ae0ca34e64dd 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -484,5 +484,4 @@ static struct platform_driver scpsys_drv = {
 		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
 	},
 };
-
-module_platform_driver_probe(scpsys_drv, scpsys_probe);
+builtin_platform_driver_probe(scpsys_drv, scpsys_probe);
-- 
2.5.0
