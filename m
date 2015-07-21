From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 21 Jul 2015 17:30:04 +0100
Subject: [PATCH] dtb: Create a common home for cross-architecture dtsi files.
Message-ID: <1437496204-5438-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 on
LogicTile Express 20MG" added a new dts file to arch/arm64 which
included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
.dtsi supplied by arch/arm.

Unfortunately this causes some issues for the split device tree
repository[0], since things get moved around there. In that context
the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
while the include is at src/arm/vexpress-v2m-rs1.dtsi.

The sharing of the .dtsi is legitimate since the baseboard is the same
for various vexpress systems whatever processor they use.

Rather than using ../../ tricks to pickup .dtsi files from another
arch this patch creates a new directory include/dt-bindings/dtsi as a
home for such cross-arch .dtsi files, arranges for it to be in the
include path when the .dts files are processed by cpp and switches the
.dts files to use cpp #include instead of /include/.

[0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kbuild at vger.kernel.org
---
 Documentation/devicetree/bindings/arm/vexpress.txt                    | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts                           | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts                            | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts                               | 2 +-
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts                  | 2 +-
 {arch/arm/boot/dts => include/dt-bindings/dtsi}/vexpress-v2m-rs1.dtsi | 0
 scripts/Makefile.lib                                                  | 1 +
 7 files changed, 6 insertions(+), 5 deletions(-)
 rename {arch/arm/boot/dts => include/dt-bindings/dtsi}/vexpress-v2m-rs1.dtsi (100%)

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
index 39844cd..46c6b04 100644
--- a/Documentation/devicetree/bindings/arm/vexpress.txt
+++ b/Documentation/devicetree/bindings/arm/vexpress.txt
@@ -223,7 +223,7 @@ Example of a VE tile description (simplified)
 		/* Active high IRQ 0 is connected to GIC's SPI0 */
 		interrupt-map = <0 0 0 &gic 0 0 4>;
 
-		/include/ "vexpress-v2m-rs1.dtsi"
+		#include <vexpress-v2m-rs1.dtsi>
 	};
 };
 
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 9420053..85b201e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -278,6 +278,6 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 
-		/include/ "vexpress-v2m-rs1.dtsi"
+		#include <vexpress-v2m-rs1.dtsi>
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 17f63f7..fe5091d 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -636,6 +636,6 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 
-		/include/ "vexpress-v2m-rs1.dtsi"
+		#include <vexpress-v2m-rs1.dtsi>
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index d2709b7..a028d59 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -248,6 +248,6 @@
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
 
-		/include/ "vexpress-v2m-rs1.dtsi"
+		#include <vexpress-v2m-rs1.dtsi>
 	};
 };
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 5b1d018..b4257ee 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -186,6 +186,6 @@
 				<0 0 41 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 42 &gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 
-		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"
+		#include <vexpress-v2m-rs1.dtsi>
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/include/dt-bindings/dtsi/vexpress-v2m-rs1.dtsi
similarity index 100%
rename from arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
rename to include/dt-bindings/dtsi/vexpress-v2m-rs1.dtsi
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79e8661..bb10128 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -163,6 +163,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
 		 -I$(srctree)/drivers/of/testcase-data                   \
+		 -I$(srctree)/include/dt-bindings/dtsi                   \
 		 -undef -D__DTS__
 
 # Finds the multi-part object the current object will be linked into
-- 
2.1.4
