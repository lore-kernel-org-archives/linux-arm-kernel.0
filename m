From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Mar 2015 17:02:13 +0000
Subject: [PATCH] arm64: dts: kill skeleton.dtsi
Message-ID: <1426870933-23126-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While skeleton.dtsi was initially conceived as a simple way to bootstrap
writing a dts, it has proven to be problematic:

* The #address-cells and #size-cells values used in skeleton.dtsi may
  not match what a user wants (e.g. when they need to describe a range
  larger than 4GB).

* For dts files where memory nodes have unit-addresses, it adds a
  redundant /memory node, for which the reg entry may not be
  appropriately sized (e.g. where #size-cells has been overridden).

* For dts files which assume that a bootloader will fill in the memory
  node(s), no node is present in the dts (and hence there is no attached
  comment), making it hard to distinguish these cases from bad dts
  files, and masking any warnings dtc may produce w.r.t. missing nodes.

* The default empty /chosen and /aliases are somewhat useless, and it
  would be preferable for dts to fill these in (e.g. for
  /aliases/serial0 and /chosen/stdout-path).

This patch removes skeleton.dtsi from arm64. There are currently no
users, so we can remove it before any appear.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/boot/dts/skeleton.dtsi | 13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/skeleton.dtsi

Recent comments reminded me to send this.

I've taken a look in mainline and linux-next and I see no skeleton.dtsi users
in arch/arm64/boot/dts/.

Mark.

diff --git a/arch/arm64/boot/dts/skeleton.dtsi b/arch/arm64/boot/dts/skeleton.dtsi
deleted file mode 100644
index 38ead82..0000000
--- a/arch/arm64/boot/dts/skeleton.dtsi
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Skeleton device tree; the bare minimum needed to boot; just include and
- * add a compatible value.  The bootloader will typically populate the memory
- * node.
- */
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <1>;
-	chosen { };
-	aliases { };
-	memory { device_type = "memory"; reg = <0 0 0>; };
-};
-- 
1.9.1
