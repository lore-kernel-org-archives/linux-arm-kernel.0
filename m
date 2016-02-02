From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue,  2 Feb 2016 17:59:11 +0800
Subject: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add device tree bindings document for reboot-mode driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
- descirbe all reboot mode as properity instead of subnode

Changes in v2: None
Changes in v1: None

 .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
 .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
new file mode 100644
index 0000000..517080f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
@@ -0,0 +1,26 @@
+Generic reboot mode core map driver
+
+This driver get reboot mode arguments and call the write
+interface to stores the magic value in special register
+or ram . Then the bootloader can read it and take different
+action according the argument stored.
+
+All mode properties are vendor specific, it is a indication to tell
+the bootloder what to do when the system reboot, and should be named
+as mode-xxx = <magic> (xxx is mode name).
+
+- mode-normal: Normal reboot mode, system reboot with command "reboot".
+- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
+- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.
+- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
+	       usually used in development.
+- mode-maskrom: It's a mode to download bootloader on Rockchip platform.
+
+Example:
+	reboot-mode {
+		mode-normal = <BOOT_NORMAL>;
+		mode-recovery = <BOOT_RECOVERY>;
+		mode-fastboot = <BOOT_FASTBOOT>;
+		mode-loader = <BOOT_LOADER>;
+		mode-maskrom = <BOOT_MASKROM>;
+	}
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
new file mode 100644
index 0000000..923c82b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
@@ -0,0 +1,36 @@
+SYSCON reboot mode driver
+
+This driver get reboot mode magic value form reboot-mode driver
+and stores it in a SYSCON mapped register. Then the bootloader
+can read it and take different action according to the magic
+value stored.
+
+This DT node should be represented as a sub-node of a "syscon", "simple-mfd"
+node.
+
+Required properties:
+- compatible: should be "syscon-reboot-mode"
+- offset: offset in the register map for the storage register (in bytes)
+
+Optional properity:
+- mask: the mask bits of the mode magic value, default set to 0xffffffff if missing.
+
+The rest of the properties should follow the generic reboot-mode discription
+found in reboot-mode.txt
+
+Example:
+	pmu: pmu at 20004000 {
+		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
+		reg = <0x20004000 0x100>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x40>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_LOADER>;
+			mode-maskrom = <BOOT_MASKROM>;
+
+		};
+	};
-- 
1.9.1
