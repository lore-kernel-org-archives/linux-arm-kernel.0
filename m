From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Nov 2012 19:02:10 +0900
Subject: Build failure: OMAP4430 failed due to exynos4 pinctrl
In-Reply-To: <20121112093329.GC28327@n2100.arm.linux.org.uk>
References: <20121112093329.GC28327@n2100.arm.linux.org.uk>
Message-ID: <007701cdc0bc$c84b11c0$58e13540$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> Last night's randconfig for OMAP4430 failed with:
> 
> drivers/built-in.o:(.rodata+0x1a60): undefined reference to
> `exynos4210_pin_ctrl'
> 
> Config and log:
> http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2693
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2693

Oops, yeah right.

Thanks for pointing out :-)

Please test again with following?...

(+ Linus Walleij)

8<-------------------------------------------------------------
From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] pinctrl/samsung: adds dependency for pinctrl-samsung/exynos

The pinctrl-exynos should be built with ARCH_EXYNOS and pinctrl-samsung
should be built with pinctrl-exynos. If not, following error can be
happened.

drivers/built-in.o:(.rodata+0x1a60): undefined reference to
'exynos4210_pin_ctrl'

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/pinctrl/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7bf914d..18b473b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -179,11 +179,13 @@ config PINCTRL_COH901
 
 config PINCTRL_SAMSUNG
 	bool "Samsung pinctrl driver"
+	depends on PLAT_SAMSUNG
 	select PINMUX
 	select PINCONF
 
 config PINCTRL_EXYNOS4
 	bool "Pinctrl driver data for Exynos4 SoC"
+	depends on PINCTRL_SAMSUNG && ARCH_EXYNOS4
 	select PINCTRL_SAMSUNG
 
 config PINCTRL_MVEBU
-- 
1.7.4.1

8<-------------------------------------------------------------

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
