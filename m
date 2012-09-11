From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Sep 2012 13:08:51 -0500
Subject: [PATCH v2] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <1346962375-26163-8-git-send-email-robherring2@gmail.com>
Message-ID: <1347386932-29930-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to support multi-platform kernels, move all the dtb targets
out of the mach Makefile.boot and into the arch/arm/boot/dts/Makefile
which is closer to the sources.

DTBs are only built when CONFIG_OF is enabled and now use top level
CONFIG_ARCH_xxx instead of chip or board specific config options.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---

v2:  
- whitespace and sorting clean-up
- use CONFIG_ARCH_xxx instead of per board/SOC config options
- make conditional on CONFIG_OF

 arch/arm/boot/Makefile                |    2 +
 arch/arm/boot/dts/Makefile            |   71 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile.boot      |   24 -----------
 arch/arm/mach-exynos/Makefile.boot    |    3 --
 arch/arm/mach-imx/Makefile.boot       |    7 ----
 arch/arm/mach-kirkwood/Makefile.boot  |   11 -----
 arch/arm/mach-lpc32xx/Makefile.boot   |    2 -
 arch/arm/mach-mvebu/Makefile.boot     |    2 -
 arch/arm/mach-mxs/Makefile.boot       |    9 -----
 arch/arm/mach-spear13xx/Makefile.boot |    3 --
 arch/arm/mach-spear3xx/Makefile.boot  |    4 --
 arch/arm/mach-spear6xx/Makefile.boot  |    2 -
 arch/arm/mach-tegra/Makefile.boot     |    8 ----
 arch/arm/mach-ux500/Makefile.boot     |    2 -
 arch/arm/mach-vexpress/Makefile.boot  |    5 ---
 15 files changed, 73 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/Makefile

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index c877087..3fdab01 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -15,6 +15,8 @@ ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
+include $(srctree)/arch/arm/boot/dts/Makefile
+
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
new file mode 100644
index 0000000..d081e6a
--- /dev/null
+++ b/arch/arm/boot/dts/Makefile
@@ -0,0 +1,71 @@
+ifeq ($(CONFIG_OF),y)
+
+dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb \
+	at91sam9263ek.dtb \
+	at91sam9g20ek_2mmc.dtb \
+	at91sam9g20ek.dtb \
+	at91sam9g25ek.dtb \
+	at91sam9m10g45ek.dtb \
+	at91sam9n12ek.dtb \
+	ethernut5.dtb \
+	evk-pro3.dtb \
+	kizbox.dtb \
+	tny_a9260.dtb \
+	tny_a9263.dtb \
+	tny_a9g20.dtb \
+	usb_a9260.dtb \
+	usb_a9263.dtb \
+	usb_a9g20.dtb
+dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
+	exynos4210-smdkv310.dtb \
+	exynos5250-smdk5250.dtb
+dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
+dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
+dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
+	kirkwood-dns325.dtb \
+	kirkwood-dreamplug.dtb \
+	kirkwood-goflexnet.dtb \
+	kirkwood-ib62x0.dtb \
+	kirkwood-iconnect.dtb \
+	kirkwood-lschlv2.dtb \
+	kirkwood-lsxhl.dtb \
+	kirkwood-ts219-6281.dtb \
+	kirkwood-ts219-6282.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
+	armada-xp-db.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
+	imx53-ard.dtb \
+	imx53-evk.dtb \
+	imx53-qsb.dtb \
+	imx53-smd.dtb \
+	imx6q-arm2.dtb \
+	imx6q-sabrelite.dtb \
+	imx6q-sabresd.dtb
+dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
+	imx23-olinuxino.dtb \
+	imx23-stmp378x_devb.dtb \
+	imx28-apx4devkit.dtb \
+	imx28-cfa10036.dtb \
+	imx28-evk.dtb \
+	imx28-m28evk.dtb \
+	imx28-tx28.dtb
+dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
+dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
+	spear1340-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
+	spear310-evb.dtb \
+	spear320-evb.dtb
+dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
+dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
+	tegra20-paz00.dtb \
+	tegra20-seaboard.dtb \
+	tegra20-trimslice.dtb \
+	tegra20-ventana.dtb \
+	tegra20-whistler.dtb \
+	tegra30-cardhu.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
+	vexpress-v2p-ca9.dtb \
+	vexpress-v2p-ca15-tc1.dtb \
+	vexpress-v2p-ca15_a7.dtb
+
+endif
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 30bb733..5309f9b 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -12,27 +12,3 @@ else
 params_phys-y	:= 0x20000100
 initrd_phys-y	:= 0x20410000
 endif
-
-# Keep dtb files sorted alphabetically for each SoC
-# sam9260
-dtb-$(CONFIG_MACH_AT91SAM_DT) += aks-cdu.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += ethernut5.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += evk-pro3.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9260.dtb
-# sam9263
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9263ek.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9263.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9263.dtb
-# sam9g20
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g20ek_2mmc.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += kizbox.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9g20.dtb
-dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9g20.dtb
-# sam9g45
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb
-# sam9n12
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9n12ek.dtb
-# sam9x5
-dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g25ek.dtb
diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
index 31bd181..b9862e2 100644
--- a/arch/arm/mach-exynos/Makefile.boot
+++ b/arch/arm/mach-exynos/Makefile.boot
@@ -1,5 +1,2 @@
    zreladdr-y	+= 0x40008000
 params_phys-y	:= 0x40000100
-
-dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb
-dtb-$(CONFIG_MACH_EXYNOS5_DT) += exynos5250-smdk5250.dtb
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 05541cf..b27815d 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -37,10 +37,3 @@ initrd_phys-$(CONFIG_SOC_IMX53)	:= 0x70800000
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
-
-dtb-$(CONFIG_MACH_IMX51_DT) += imx51-babbage.dtb
-dtb-$(CONFIG_MACH_IMX53_DT) += imx53-ard.dtb imx53-evk.dtb \
-			       imx53-qsb.dtb imx53-smd.dtb
-dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
-			   imx6q-sabrelite.dtb \
-			   imx6q-sabresd.dtb \
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index a13299d..760a0ef 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -1,14 +1,3 @@
    zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-
-dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
-dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
-dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
-dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
-dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
-dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6281.dtb
-dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6282.dtb
-dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
-dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
-dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
index 697323b..d7392a4 100644
--- a/arch/arm/mach-lpc32xx/Makefile.boot
+++ b/arch/arm/mach-lpc32xx/Makefile.boot
@@ -1,5 +1,3 @@
    zreladdr-y	+= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x82000000
-
-dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
diff --git a/arch/arm/mach-mvebu/Makefile.boot b/arch/arm/mach-mvebu/Makefile.boot
index 2579a2f..b327175 100644
--- a/arch/arm/mach-mvebu/Makefile.boot
+++ b/arch/arm/mach-mvebu/Makefile.boot
@@ -1,3 +1 @@
 zreladdr-y := 0x00008000
-dtb-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-db.dtb
-dtb-$(CONFIG_MACH_ARMADA_370_XP) += armada-xp-db.dtb
diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
index 4582999..07b11fe 100644
--- a/arch/arm/mach-mxs/Makefile.boot
+++ b/arch/arm/mach-mxs/Makefile.boot
@@ -1,10 +1 @@
 zreladdr-y += 0x40008000
-
-dtb-y += imx23-evk.dtb \
-	 imx23-olinuxino.dtb \
-	 imx23-stmp378x_devb.dtb \
-	 imx28-apx4devkit.dtb \
-	 imx28-cfa10036.dtb \
-	 imx28-evk.dtb \
-	 imx28-m28evk.dtb \
-	 imx28-tx28.dtb \
diff --git a/arch/arm/mach-spear13xx/Makefile.boot b/arch/arm/mach-spear13xx/Makefile.boot
index 403efd7..4674a4c 100644
--- a/arch/arm/mach-spear13xx/Makefile.boot
+++ b/arch/arm/mach-spear13xx/Makefile.boot
@@ -1,6 +1,3 @@
 zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-
-dtb-$(CONFIG_MACH_SPEAR1310)	+= spear1310-evb.dtb
-dtb-$(CONFIG_MACH_SPEAR1340)	+= spear1340-evb.dtb
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
index d93e217..4674a4c 100644
--- a/arch/arm/mach-spear3xx/Makefile.boot
+++ b/arch/arm/mach-spear3xx/Makefile.boot
@@ -1,7 +1,3 @@
 zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-
-dtb-$(CONFIG_MACH_SPEAR300)	+= spear300-evb.dtb
-dtb-$(CONFIG_MACH_SPEAR310)	+= spear310-evb.dtb
-dtb-$(CONFIG_MACH_SPEAR320)	+= spear320-evb.dtb
diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
index af493da..4674a4c 100644
--- a/arch/arm/mach-spear6xx/Makefile.boot
+++ b/arch/arm/mach-spear6xx/Makefile.boot
@@ -1,5 +1,3 @@
 zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-
-dtb-$(CONFIG_BOARD_SPEAR600_DT)	+= spear600-evb.dtb
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index 7a1bb62..2943381 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -1,11 +1,3 @@
 zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
-
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-harmony.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-paz00.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-seaboard.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-trimslice.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-ventana.dtb
-dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-whistler.dtb
-dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
index dd5cd00..760a0ef 100644
--- a/arch/arm/mach-ux500/Makefile.boot
+++ b/arch/arm/mach-ux500/Makefile.boot
@@ -1,5 +1,3 @@
    zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-
-dtb-$(CONFIG_MACH_SNOWBALL) += snowball.dtb
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 318d308..c6dd891 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -3,8 +3,3 @@
    zreladdr-y	+= 0x60008000
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
-
-dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb \
-				   vexpress-v2p-ca9.dtb \
-				   vexpress-v2p-ca15-tc1.dtb \
-				   vexpress-v2p-ca15_a7.dtb
-- 
1.7.9.5
