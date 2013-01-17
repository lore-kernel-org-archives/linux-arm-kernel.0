From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 17 Jan 2013 18:03:14 +0800
Subject: [PATCH v6 0/3] Fix the Build error for fsl_mxc_udc.c
Message-ID: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v6:
- Only using imx-udc-mx27 and imx-udc-mx51 stands for
all kinds of i.mx udc
- Fix below build error for platform_device_id at fsl_udc_core.c
drivers/usb/gadget/fsl_usb2_udc: struct platform_device_id is 24 bytes.? The last of 5 is:
| 0x69 0x6d 0x78 0x2d 0x75 0x64 0x63 0x2d 0x6d 0x78 0x35 0x31 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+0x00 0x00 0x00
| FATAL: drivers/usb/gadget/fsl_usb2_udc: struct platform_device_id is not terminated with a NULL entry!
| make[1]: *** [__modpost] Error 1

Changes for v5:
- Using strcmp to get specific SoC
- Delete one cpu_is_mx35() as it has already pdata runtime check

Changes for v4:
- Using pdev's struct resource to do ioremap
- Add ioremap return value check

Changes for v3:
- Split the one big patch into three patches

Changes for v2:
- Add const for fsl_udc_devtype
- Do ioremap for phy address at fsl-mxc-udc

Peter Chen (3):
  usb: fsl-mxc-udc: replace cpu_is_xxx() with platform_device_id
  usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
  ARM: i.MX clock: Change the connection-id for fsl-usb2-udc

 arch/arm/mach-imx/clk-imx25.c                     |    6 +-
 arch/arm/mach-imx/clk-imx27.c                     |    6 +-
 arch/arm/mach-imx/clk-imx31.c                     |    6 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 ++++---
 drivers/usb/gadget/fsl_mxc_udc.c                  |   40 +++++++++++++-------
 drivers/usb/gadget/fsl_udc_core.c                 |   42 ++++++++++++--------
 drivers/usb/gadget/fsl_usb2_udc.h                 |    5 +-
 10 files changed, 78 insertions(+), 55 deletions(-)
