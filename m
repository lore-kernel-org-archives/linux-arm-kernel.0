From: broonie@kernel.org (Mark Brown)
Date: Thu, 07 Jul 2016 12:01:40 +0200
Subject: Applied "spi: add binding for clps711x SPI" to the spi tree
In-Reply-To: <20160706145326.2658600-2-arnd@arndb.de>
Message-ID: <E1bL67o-0000sU-5Y@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: add binding for clps711x SPI

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ea2ff61ba3f8239483f5cd823ac0113d194b469f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Jul 2016 16:53:13 +0200
Subject: [PATCH] spi: add binding for clps711x SPI

This documents the binding used by Alexander Shiyan's DT support for
the clps711x SPI controller.

I've left the file name to match the ARM platform port name "clps711x"
for consistency with the other bindings, even though the compatible
string refers to the later ep7309 chip.

Linux no longer supports the old clps711x and ep72xx product lines,
but we still use the name. The entire family is now discontinued
by the manufacturer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-clps711x.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-clps711x.txt b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
new file mode 100644
index 000000000000..4c3ec13f423f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
@@ -0,0 +1,33 @@
+Serial Peripheral Interface on Cirrus Logic CL-PS71xx, EP72xx, EP73xx
+
+Required properties
+- #address-cells: must be <1>
+- #size-cells: must be <0>
+- compatible: should include "cirrus,ep7209-spi"
+- reg: Address and length of one register range
+- interrupts: one interrupt line
+- clocks: One entry, refers to the SPI bus clock
+- cs-gpios: Specifies the gpio pins to be used for chipselects.
+	    See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+An additional register is present in the system controller,
+which is assumed to be in the same device tree, with and marked
+as compatible with "cirrus,ep7209-syscon3".
+
+Example:
+
+spi at 80000500 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "cirrus,ep7209-spi";
+	reg = <0x80000500 0x4>;
+	interrupts = <15>;
+	clocks = <&clks CLPS711X_CLK_SPI>;
+	status = "disabled";
+};
+
+syscon3: syscon at 80002200 {
+	compatible = "cirrus,ep7209-syscon3", "syscon";
+	reg = <0x80002200 0x40>;
+};
+
-- 
2.8.1
