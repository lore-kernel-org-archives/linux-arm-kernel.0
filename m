From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:00 +0100
Subject: [PATCH 1/6] mtd: augment the "arm,versatile-flash" bindings
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for the "arm,versatile-flash" device was merged in
commit 3ba7222ac992d24d09ccd0b55940b54849eef752
"arm/versatile: Add device tree support" but was never used
for anything.

Versatile flash chips are actually just standard CFI chips,
but they have one or two bits in a system controller to control
VPP and write protection. Let's use this compatible string in
conjunction with "cfi-flash" to indicate that we have a
normal CFI flash with some extra Versatile-specific protection.

Cc: devicetree at vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mtd/arm-versatile.txt        | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/arm-versatile.txt b/Documentation/devicetree/bindings/mtd/arm-versatile.txt
index beace4b89daa..4ec28796a3c0 100644
--- a/Documentation/devicetree/bindings/mtd/arm-versatile.txt
+++ b/Documentation/devicetree/bindings/mtd/arm-versatile.txt
@@ -1,8 +1,26 @@
 Flash device on ARM Versatile board
 
+These flash chips are found in the ARM reference designs like Integrator,
+Versatile, RealView, Versatile Express etc.
+
+They are regular CFI compatible (Intel or AMD extended) flash chips with
+some special write protect/VPP bits that can be controlled by the machine's
+system controller.
+
 Required properties:
-- compatible : must be "arm,versatile-flash";
+- compatible : must be "arm,versatile-flash", "cfi-flash";
+- reg : memory address for the flash chip
 - bank-width : width in bytes of flash interface.
 
+For the rest of the properties, see mtd-physmap.txt.
+
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
+
+Example:
+
+flash at 34000000 {
+	compatible = "arm,versatile-flash", "cfi-flash";
+	reg = <0x34000000 0x4000000>;
+	bank-width = <4>;
+};
-- 
2.4.3
