From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Aug 2013 14:00:13 -0600
Subject: [PATCH] ARM: tegra: always enable USB VBUS regulators
Message-ID: <1377028813-32762-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This fixes a regression exposed during the merge window by commit
9f310de "ARM: tegra: fix VBUS regulator GPIO polarity in DT"; namely that
USB VBUS doesn't get turned on, so USB devices are not detected. This
affects the internal USB port on TrimSlice (i.e. the USB->SATA bridge, to
which the SSD is connected) and the external port(s) on Seaboard/
Springbank and Whistler.

The Tegra DT as written in v3.11 allows two paths to enable USB VBUS:

1) Via the legacy DT binding for the USB controller; it can directly
   acquire a VBUS GPIO and activate it.

2) Via a regulator for VBUS, which is referenced by the new DT binding
   for the USB controller.

Those two methods both use the same GPIO, and hence whichever of the
USB controller and regulator gets probed first ends up owning the GPIO.
In practice, the USB driver only supports path (1) above, since the
patches to support the new USB binding are not present until v3.12:-(

In practice, the regulator ends up being probed first and owning the
GPIO. Since nothing enables the regulator (the USB driver code is not
yet present), the regulator ends up being turned off. This originally
caused no problem, because the polarity in the regulator definition was
incorrect, so attempting to turn off the regulator actually turned it
on, and everything worked:-(

However, when testing the new USB driver code in v3.12, I noticed the
incorrect polarity and fixed it in commit 9f310de "ARM: tegra: fix VBUS
regulator GPIO polarity in DT". In the context of v3.11, this patch then
caused the USB VBUS to actually turn off, which broke USB ports with VBUS
control. I got this patch included in v3.11-rc1 since it fixed a bug in
device tree (incorrect polarity specification), and hence was suitable to
be included early in the rc series. I evidently did not test the patch at
all, or correctly, in the context of v3.11, and hence did not notice the
issue that I have explained above:-(

Fix this by making the USB VBUS regulators always enabled. This way, if
the regulator owns the GPIO, it will always be turned on, even if there
is no USB driver code to request the regulator be turned on. Even
ignoring this bug, this is a reasonable way to configure the HW anyway.

If this patch is applied to v3.11, it will cause a couple pretty trivial
conflicts in tegra20-{trimslice,seaboard}.dts when creating v3.12, since
the context right above the added lines changed in patches destined for
v3.12.

Reported-by: Kyle McMartin <kmcmarti@redhat.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a patch for v3.11-rc*

 arch/arm/boot/dts/tegra20-seaboard.dts  | 2 ++
 arch/arm/boot/dts/tegra20-trimslice.dts | 2 ++
 arch/arm/boot/dts/tegra20-whistler.dts  | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 365760b..40e6fb2 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -830,6 +830,8 @@
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
 			gpio = <&gpio 24 0>; /* PD0 */
+			regulator-always-on;
+			regulator-boot-on;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index ed4b901..37c93d3 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -412,6 +412,8 @@
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
 			gpio = <&gpio 170 0>; /* PV2 */
+			regulator-always-on;
+			regulator-boot-on;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index ab67c94..a3d0eba 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -588,6 +588,8 @@
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
 			gpio = <&tca6416 0 0>; /* GPIO_PMU0 */
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		vbus3_reg: regulator at 3 {
@@ -598,6 +600,8 @@
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
 			gpio = <&tca6416 1 0>; /* GPIO_PMU1 */
+			regulator-always-on;
+			regulator-boot-on;
 		};
 	};
 
-- 
1.8.1.5
