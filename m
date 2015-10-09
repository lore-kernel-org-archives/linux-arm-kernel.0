From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  9 Oct 2015 17:51:47 +0200
Subject: [PATCH] ARM: tegra: Comment out gpio-ranges properties
Message-ID: <1444405907-17996-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

While the addition of these properties is technically correct it unveils
a bug with deferred probe. The problem is that the presence of the gpio-
range property causes the gpio-tegra driver to defer probe (it needs the
pinctrl driver to be ready). That's technically correct, but it causes a
couple of issues:

  - The keyboard on Chromebooks stops working. The reason for that is
    that the gpio-tegra device has not registered an IRQ domain by the
    time the EC SPI device is registered, hence the interrupt number
    resolves to 0. This is technically a bug in the SPI core, since it
    should really resolve the interrupt at probe time and defer if the
    IRQ domain isn't available yet. This is similar to what's done for
    I2C and platform device already.

  - The gpio-tegra device deferring probe means that it is moved to the
    end of the dpm_list. This list defines the suspend/resume order for
    devices. However the core lacks a way to move all users of the
    gpio-tegra device to the end of the dpm_list at the same time. This
    in turn results in a subtle bug on Jetson TK1, where the gpio-keys
    device is used to expose the power key as input. The power key is a
    convenient way to wake the system from suspend. Interestingly, the
    gpio-keys device ends up getting probed at a point after gpio-tegra
    has been probed successfully from having been deferred earlier. As
    such the driver doesn't need to defer the probe itself, and hence
    the device isn't moved to the end of the dpm_list. This causes the
    gpio-tegra device to be suspended before gpio-keys, which in turn
    leaves gpio-keys unable to wake the system from suspend.

There are patches in the works to fix both of the above issues, but they
are too involved to make it into v4.3, so in the meantime let's fix the
regressions by commenting out the gpio-ranges properties until the fixes
have landed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 ++
 arch/arm/boot/dts/tegra124.dtsi | 2 ++
 arch/arm/boot/dts/tegra20.dtsi  | 2 ++
 arch/arm/boot/dts/tegra30.dtsi  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 71b992dba71c..136fe2043b2f 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -243,7 +243,9 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		/*
 		gpio-ranges = <&pinmux 0 0 246>;
+		*/
 	};
 
 	apbmisc at 70000800 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index ec10e769819f..a8828dbe621d 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -273,7 +273,9 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		/*
 		gpio-ranges = <&pinmux 0 0 251>;
+		*/
 	};
 
 	apbdma: dma at 0,60020000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6ac74be843d1..9c7759697d58 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -256,7 +256,9 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		/*
 		gpio-ranges = <&pinmux 0 0 224>;
+		*/
 	};
 
 	apbmisc at 70000800 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 9b4fa02be321..dcbccb6e9206 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -365,7 +365,9 @@
 		gpio-controller;
 		#interrupt-cells = <2>;
 		interrupt-controller;
+		/*
 		gpio-ranges = <&pinmux 0 0 248>;
+		*/
 	};
 
 	apbmisc at 70000800 {
-- 
2.5.0
