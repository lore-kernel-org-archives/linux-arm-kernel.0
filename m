From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 13:06:37 -0600
Subject: [RFC PATCH 2/3] ARM: use cmd_dtc_cpp for compilation of *.dts-cpp to
 *.dtb
In-Reply-To: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348599998-2729-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This allows DT source files to use the C pre-processor. A new file
extension is introduced for this purpose, since use of the pre-processor
must be optional; any property or node name that starts with "#" must be
escaped to prevent the pre-processor attempting to interpret it as a
directive. For this reason, skeleton.dtsi-cpp is introduced for *.dts-cpp
to include.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/Makefile              |    3 +++
 arch/arm/boot/dts/skeleton.dtsi-cpp |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/skeleton.dtsi-cpp

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 3fdab01..c5d7fca 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -65,6 +65,9 @@ targets += $(dtb-y)
 $(obj)/%.dtb: $(src)/dts/%.dts FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtb: $(src)/dts/%.dts-cpp FORCE
+	$(call if_changed_dep,dtc_cpp)
+
 $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
 
 clean-files := *.dtb
diff --git a/arch/arm/boot/dts/skeleton.dtsi-cpp b/arch/arm/boot/dts/skeleton.dtsi-cpp
new file mode 100644
index 0000000..8bf6729
--- /dev/null
+++ b/arch/arm/boot/dts/skeleton.dtsi-cpp
@@ -0,0 +1,13 @@
+/*
+ * Skeleton device tree; the bare minimum needed to boot; just include and
+ * add a compatible value.  The bootloader will typically populate the memory
+ * node.
+ */
+
+/ {
+	\#address-cells = <1>;
+	\#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0>; };
+};
-- 
1.7.0.4
