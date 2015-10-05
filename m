From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  5 Oct 2015 17:41:56 -0600
Subject: [PATCH 1/2] dt: update Tegra XUSB padctl binding for Tegra210
Message-ID: <1444088517-31615-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra210 introduces some new options for pad muxing. Document these in
the XUSB padctl binding.

Be more explicit about the valid values for the compatible property, and
in particular point out that Tegra210 isn't fully backwards-compatible
with Tegra124, since some registers have moved about.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        | 34 +++++++++++++++-------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
index 30676ded85bb..3952d893635c 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
@@ -13,9 +13,12 @@ how to describe and reference PHYs in device trees.
 
 Required properties:
 --------------------
-- compatible: For Tegra124, must contain "nvidia,tegra124-xusb-padctl".
-  Otherwise, must contain '"nvidia,<chip>-xusb-padctl",
-  "nvidia-tegra124-xusb-padctl"', where <chip> is tegra132 or tegra210.
+- compatible: Valid options are:
+  Tegra124: "nvidia,tegra124-xusb-padctl".
+  Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia-tegra124-xusb-padctl".
+  Tegra210: "nvidia-tegra210-xusb-padctl".
+    Note that Tegra210 is not backwards-compatible with Tegra124 due to some
+    registers having been moved.
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
@@ -45,18 +48,21 @@ Unspecified is represented as an absent property, and off/on are represented
 as integer values 0 and 1.
 
 Required properties:
-- nvidia,lanes: An array of strings. Each string is the name of a lane.
+- nvidia,lanes: An array of strings. Each string is the name of a lane (pad).
+  Valid values for lanes are listed below.
 
 Optional properties:
-- nvidia,function: A string that is the name of the function (pad) that the
-  pin or group should be assigned to. Valid values for function names are
-  listed below.
+- nvidia,function: A string that is the name of the function (IO controller)
+  that the pin or group should be assigned to. Valid values for function names
+  are  listed below.
 - nvidia,iddq: Enables IDDQ mode of the lane. (0: no, 1: yes)
 
 Note that not all of these properties are valid for all lanes. Lanes can be
 divided into three groups:
 
-  - otg-0, otg-1, otg-2:
+  - otg-0, otg-1, otg-2, otg-3, usb2-bias:
+
+    (otg-3, usb2-bias are valid on Tegra210 only.)
 
     Valid functions for this group are: "snps", "xusb", "uart", "rsvd".
 
@@ -64,13 +70,21 @@ divided into three groups:
 
   - ulpi-0, hsic-0, hsic-1:
 
+    (ulpi-0 is valid on Tegra124 and Tegra132 only.)
+
     Valid functions for this group are: "snps", "xusb".
 
     The nvidia,iddq property does not apply to this group.
 
-  - pcie-0, pcie-1, pcie-2, pcie-3, pcie-4, sata-0:
+  - pcie-0, pcie-1, pcie-2, pcie-3, pcie-4, pcie-5, pcie-6, sata-0:
+
+    (pcie-5, pcie-6 are valid on Tegra210 only.)
+
+    On Tegra124, Tegra132, valid functions for this group are: "pcie", "usb3",
+    "sata", "rsvd".
 
-    Valid functions for this group are: "pcie", "usb3", "sata", "rsvd".
+    On Tegra210, valid functions for this group are "pcie-x1", "usb3",
+    "sata", "pcie-x4".
 
 
 Example:
-- 
1.9.1
