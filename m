From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:26 +0900
Subject: [RFC 00/15] tree-wide: mfd: syscon: Fix unmet ioremap dependency
Message-ID: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Building allyesconfig on ARCH=um fails with:
   drivers/mfd/syscon.c: In function ?of_syscon_register?:
   drivers/mfd/syscon.c:67:9: error: implicit declaration of function ?ioremap? [-Werror=implicit-function-declaration]
      base = ioremap(res.start, resource_size(&res));

Since commit c89c0114955a ("mfd: syscon: Set regmap max_register in
of_syscon_register") the syscon depends on HAS_IOMEM because
it uses the ioremap().

However syscon is often directly selected... so first the dependency on
HAS_IOMEM has to be added to all selecting symbols.

Comments are welcomed whether this is appropriate approach.


The last patch "mfd: syscon: Fix build of missing ioremap on UM" should
enter all other to avoid kbuild complains like:

warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X &&
DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW
&& PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE &&
S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK &&
RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST
&& QCOM_GSBI && PHY_HI6220_USB)
selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)


Best regards,
Krzysztof


Krzysztof Kozlowski (15):
  clocksource: atmel: Add missing MFD_SYSCON dependency on HAS_IOMEM
  dmaengine: nxp: Add missing MFD_SYSCON dependency on HAS_IOMEM
  hwspinlock: qcom: Add missing MFD_SYSCON dependency on HAS_IOMEM
  irqchip: st: Add missing MFD_SYSCON dependency on HAS_IOMEM
  phy: hi6220: Add missing MFD_SYSCON dependency on HAS_IOMEM
  pinctrl: rockchip: Add missing MFD_SYSCON dependency on HAS_IOMEM
  pinctrl: mvebu: Add missing MFD_SYSCON dependency on HAS_IOMEM
  rtc: at91sam9: Add missing MFD_SYSCON dependency on HAS_IOMEM
  media: platform: Add missing MFD_SYSCON dependency on HAS_IOMEM
  net: ethernet: Add missing MFD_SYSCON dependency on HAS_IOMEM
  power: reset: keystone: Add missing MFD_SYSCON dependency on HAS_IOMEM
  soc: qcom: Add missing MFD_SYSCON dependency on HAS_IOMEM
  staging: media: omap4iss: Add missing MFD_SYSCON dependency on
    HAS_IOMEM
  usb: xhci: mtk: Add missing MFD_SYSCON dependency on HAS_IOMEM
  mfd: syscon: Fix build of missing ioremap on UM

 drivers/clocksource/Kconfig                 | 1 +
 drivers/dma/Kconfig                         | 1 +
 drivers/hwspinlock/Kconfig                  | 1 +
 drivers/irqchip/Kconfig                     | 1 +
 drivers/media/platform/Kconfig              | 1 +
 drivers/media/platform/exynos4-is/Kconfig   | 1 +
 drivers/mfd/Kconfig                         | 1 +
 drivers/net/ethernet/hisilicon/Kconfig      | 1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 6 ++++++
 drivers/net/ethernet/ti/Kconfig             | 1 +
 drivers/phy/Kconfig                         | 1 +
 drivers/pinctrl/Kconfig                     | 1 +
 drivers/pinctrl/mvebu/Kconfig               | 1 +
 drivers/power/reset/Kconfig                 | 1 +
 drivers/rtc/Kconfig                         | 1 +
 drivers/soc/qcom/Kconfig                    | 1 +
 drivers/staging/media/omap4iss/Kconfig      | 1 +
 drivers/usb/host/Kconfig                    | 1 +
 18 files changed, 23 insertions(+)

-- 
2.5.0
