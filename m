From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Mon, 18 Dec 2017 12:51:29 +0100
Subject: [PATCH v4 0/4] rtc: add mxc driver for i.MX53 SRTC
Message-ID: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.

This is driver enables support for the low power domain SRTC features:
- 32-bit MSB of non-rollover time counter
- 32-bit alarm register

Select the new config option RTC_DRV_MXC_V2 to build this driver

Based on:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

v4:
- rename "srtc" node into generic "rtc" keep the label as "srtc" to avoid
  duplication with imx53-m53.dtsi
- fix Signed-off-by: in bindings-patch

v3:
- introduce new config option with the same patch, which adds the driver
- call rtc_update_irq() only if necessary
- merge mxc_rtc_write_alarm_locked() with mxc_rtc_set_alarm()
- only use clk_enable/disable (without "prepare") during operation
- rebase on v4.15-rc3
- consistently use rtc_tm_to_time64() and time64_t
- refactor mxc_rtc_read_time(): don't lock for readl() only;
  don't rtc_valid_tm(); use time64_t
- check returncode of mxc_rtc_wait_for_flag()
- restructure mxc_rtc_sync_lp_locked() to replace pr_err() with
  dev_err_once(); remove explicit 'inline'
- don't touch imx_v4_v5_defconfig, instead add to imx_v6_v7_defconfig

v2:
- have seperate patches for dt-binding, CONFIG option, imx53.dtsi and driver
- add SPDX-License-Identifier and cleanup copyright notice
- replace __raw_readl/writel() with readl/writel()
- fix PM_SLEEP callbacks
- add CONFIG_RTC_DRV_MXC_V2 to build rtc-mxc_v2.c
- remove misleading or obvious comments and fix style of the remaining
- avoid endless loop while waiting for hw
- implement consistent locking; make spinlock a member of dev struct
- enable clk only for register accesses
- remove all udelay() calls since they are obsolete or redundant
  (we are already waiting for register flags to change)
- init platform_data before registering irq callback
- let set_time() fail, when 32 bit rtc counter exceeded
- make names more consistent
- cleanup and reorder includes
- cleanup and remove unused defines

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc at vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel at vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---

Patrick Bruenn (4):
  dt-bindings: rtc: add bindings for i.MX53 SRTC
  ARM: dts: imx53: add srtc node
  rtc: add mxc driver for i.MX53 SRTC
  ARM: imx_v6_v7_defconfig: enable RTC_DRV_MXC_V2

 .../devicetree/bindings/rtc/rtc-mxc_v2.txt         |  17 +
 arch/arm/boot/dts/imx53.dtsi                       |   7 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-mxc_v2.c                           | 422 +++++++++++++++++++++
 6 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
 create mode 100644 drivers/rtc/rtc-mxc_v2.c

-- 
2.11.0
