From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  6 Feb 2013 23:47:25 -0200
Subject: [PATCH v2] ARM: mxs: Select ARM_CPU_SUSPEND
Message-ID: <1360201645-2456-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select ARM_CPU_SUSPEND so that suspend/resume can be tested on mxs platforms.

Tested on a mx28evk board:

$ echo enabled > /sys/devices/80000000.apb/80040000.apbx/80074000.serial/tty/ttyAMA0/power/wakeup
$ echo mem > /sys/power/state
[  507.040000] PM: Syncing filesystems ... done.
[  507.060000] mmc0: card e624 removed
[  507.160000] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  507.180000] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  507.200000] Suspending console(s) (use no_console_suspend to debug)

(Then send any character via DUART to wakeup the system).

[  507.220000] PM: suspend of devices complete after 10.468 msecs
[  507.220000] PM: late suspend of devices complete after 3.531 msecs
[  507.230000] PM: noirq suspend of devices complete after 5.187 msecs
[  507.230000] PM: noirq resume of devices complete after 2.312 msecs
[  507.230000] PM: early resume of devices complete after 2.437 msecs
[  507.320000] PM: resume of devices complete after 81.312 msecs
[  507.360000] Restarting tasks ... done.
[  507.530000] mmc0: new SDHC card at address e624
[  507.550000] mmcblk0: mmc0:e624 SU04G 3.69 GiB
[  507.560000]  mmcblk0: p1 p2 p3
[  509.240000] libphy: 800f0000.etherne:01 - Link is Down
[  511.240000] libphy: 800f0000.etherne:01 - Link is Up

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Replace AUART with DUART, since ttyAMA0 is the debug UART.

 arch/arm/mach-mxs/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index ecc4319..c4495a1 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -3,6 +3,7 @@ if ARCH_MXS
 config SOC_IMX23
 	bool
 	select ARM_AMBA
+	select ARM_CPU_SUSPEND if PM
 	select CPU_ARM926T
 	select HAVE_PWM
 	select PINCTRL_IMX23
@@ -10,6 +11,7 @@ config SOC_IMX23
 config SOC_IMX28
 	bool
 	select ARM_AMBA
+	select ARM_CPU_SUSPEND if PM
 	select CPU_ARM926T
 	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_PWM
-- 
1.7.9.5
