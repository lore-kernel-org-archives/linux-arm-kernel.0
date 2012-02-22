From: hs@denx.de (Heiko Schocher)
Date: Wed, 22 Feb 2012 07:50:05 +0100
Subject: [PATCH v2 2/7] ARM: davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <1329893410-24413-1-git-send-email-hs@denx.de>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
Message-ID: <1329893410-24413-3-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for configuring the aemif timing registers
through device tree. Introduce new compatible property
"ti,davinci-cs", see full description in
Documentation/devicetree/bindings/arm/davinci/aemif.txt

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>

---
- changes for v2
  - add comment from Sergei Shtylyov:
    - use of_property_read_u32()
    - Conding Style changes
  - add comment from Sekhar Nori:
    - add patch description
    - use davinci_aemif_setup_timing
    - change compatible node to "ti,davinci-aemif"

  - not moved to mfd, as mentioned in this discussion:
    http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-arm-davinci-configure-davinci-aemif-chipselects-through-OF-td7059739.html
    instead use a phandle in the DTS, so drivers which
    uses the davinci aemif, can call davinci_aemif_setup_timing_of()

    This is just thought as an RFC ... The enbw_cmc board
    support not really need to setup this bus timings, as
    they are setup in U-Boot ... but I want to post this,
    as I think, it is a nice to have ... as an example used
    in the davinci nand controller OF support patch, in this
    patchserie.

 .../devicetree/bindings/arm/davinci/aemif.txt      |  119 ++++++++++++++++++++
 arch/arm/mach-davinci/aemif.c                      |   86 ++++++++++++++-
 arch/arm/mach-davinci/include/mach/aemif.h         |    1 +
 3 files changed, 205 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/davinci/aemif.txt

diff --git a/Documentation/devicetree/bindings/arm/davinci/aemif.txt b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
new file mode 100644
index 0000000..0dbb842
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
@@ -0,0 +1,119 @@
+* Texas Instruments Davinci AEMIF
+
+This file provides information, what the device node for the
+davinci aemif interface contain.
+
+Required properties:
+- compatible: "ti,davinci-aemif";
+- #address-cells : Should be either two or three.  The first cell is the
+                   chipselect number, and the remaining cells are the
+                   offset into the chipselect.
+- #size-cells : Either one or two, depending on how large each chipselect
+                can be.
+- ranges : Each range corresponds to a single chipselect, and cover
+           the entire access window as configured.
+
+Optional properties:
+- none
+
+Optional subnodes:
+- Chipselect setup:
+	- compatible: "ti,davinci-cs";
+	- #address-cells = <1>;
+	- #size-cells = <1>;
+
+    Timing setup, all timings in nanoseconds
+	- cs:		chipselect (value 2,3,4 or 5)
+	- asize:	Asynchronous Data Bus Width.
+			value:
+			0: 8 bit
+			1: 16 bit
+	- ta:		Minimum Turn-Around time.
+	- rhold:	Read hold width
+	- rstrobe:	Read strobe width
+	- rsetup:	Read setup width
+	- whold:	Write hold width
+	- wstrobe:	Write strobe width
+	- wsetup:	Write setup width
+	- ew:		Extend Wait bit
+			value:
+			0: Extended wait cycles disabled.
+			1: Extended wait cycles enabled.
+	- ss:		Select Strobe bit.
+			value:
+			0: Normal Mode enabled.
+			1: Select Strobe Mode enabled.
+- CFI driver:
+  see: Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+
+Example (enbw_cmc board):
+	aemif at 60000000 {
+		compatible = "ti,davinci-aemif";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x68000000 0x80000>;
+		ranges = <2 0 0x60000000 0x02000000
+			  3 0 0x62000000 0x02000000
+			  4 0 0x64000000 0x02000000
+			  5 0 0x66000000 0x02000000
+			  6 0 0x68000000 0x02000000>;
+		cs2 at 68000000 {
+			compatible = "ti,davinci-cs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* all timings in nanoseconds */
+			cs = <2>;
+			asize = <1>;
+			ta = <0>;
+			rhold = <7>;
+			rstrobe = <42>;
+			rsetup = <14>;
+			whold = <7>;
+			wstrobe = <42>;
+			wsetup = <14>;
+			ew = <0>;
+			ss = <0>;
+		};
+		flash at 2,0 {
+			compatible = "cfi-flash";
+			reg = <2 0x0 0x400000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <2>;
+			device-width = <2>;
+		};
+		nand_cs: cs3 at 68000000 {
+			compatible = "ti,davinci-cs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* all timings in nanoseconds */
+			cs = <3>;
+			asize = <0>;
+			ta = <0>;
+			rhold = <7>;
+			rstrobe = <42>;
+			rsetup = <7>;
+			whold = <7>;
+			wstrobe = <14>;
+			wsetup = <7>;
+			ew = <0>;
+			ss = <0>;
+		};
+		nandflash at 3,0 {
+			compatible = "ti,davinci-nand";
+			reg = <3 0x0 0x807ff
+				6 0x0 0x8000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			mask_ale = <0>;
+			mask_cle = <0>;
+			mask_chipsel = <0>;
+			ecc_mode = <2>;
+			ecc_bits = <4>;
+			options = <0>;
+			bbt_options = <0x20000>;
+			pinmux-handle = <&nand_pins>;
+			timing-handle = <&nand_cs>;
+		};
+
+	};
diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
index 1ce70a9..e3d94a5 100644
--- a/arch/arm/mach-davinci/aemif.c
+++ b/arch/arm/mach-davinci/aemif.c
@@ -13,12 +13,14 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/time.h>
 
 #include <mach/aemif.h>
 
 /* Timing value configuration */
-
+#define ASIZE(x)	(x)
 #define TA(x)		((x) << 2)
 #define RHOLD(x)	((x) << 4)
 #define RSTROBE(x)	((x) << 7)
@@ -26,7 +28,10 @@
 #define WHOLD(x)	((x) << 17)
 #define WSTROBE(x)	((x) << 20)
 #define WSETUP(x)	((x) << 26)
+#define EW(x)		((x) << 30)
+#define SS(x)		((x) << 31)
 
+#define ASIZE_MAX	0x1
 #define TA_MAX		0x3
 #define RHOLD_MAX	0x7
 #define RSTROBE_MAX	0x3f
@@ -34,6 +39,8 @@
 #define WHOLD_MAX	0x7
 #define WSTROBE_MAX	0x3f
 #define WSETUP_MAX	0xf
+#define EW_MAX		0x1
+#define SS_MAX		0x1
 
 #define TIMING_MASK	(TA(TA_MAX) | \
 				RHOLD(RHOLD_MAX) | \
@@ -131,3 +138,80 @@ int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
 	return 0;
 }
 EXPORT_SYMBOL(davinci_aemif_setup_timing);
+
+#if defined(CONFIG_OF)
+static int dv_get_value(struct device_node *np, const char *name)
+{
+	u32 data;
+	int ret;
+
+	ret = of_property_read_u32(np, name, &data);
+	if (ret != 0)
+		return ret;
+
+	return data;
+}
+
+int davinci_aemif_setup_timing_of(struct device_node *np)
+{
+	struct device_node *parent;
+	struct davinci_aemif_timing t;
+	void __iomem *base;
+	unsigned val;
+	int asize, ew, ss;
+	int cs;
+	unsigned offset;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	parent = np->parent;
+	if (!np)
+		return -ENODEV;
+
+	base = of_iomap(parent, 0);
+	if (!base)
+		return -EINVAL;
+
+	cs = dv_get_value(np, "cs");
+	if (cs < 2)
+		return -EINVAL;
+
+	t.ta		= dv_get_value(np, "ta");
+	t.rhold		= dv_get_value(np, "rhold");
+	t.rstrobe	= dv_get_value(np, "rstrobe");
+	t.rsetup	= dv_get_value(np, "rsetup");
+	t.whold		= dv_get_value(np, "whold");
+	t.wstrobe	= dv_get_value(np, "wstrobe");
+	t.wsetup	= dv_get_value(np, "wsetup");
+
+	ret = davinci_aemif_setup_timing(&t, base, cs);
+	if (ret != 0)
+		return ret;
+
+	/* setup none timing paramters */
+	offset = A1CR_OFFSET + cs * 4;
+	asize = dv_get_value(np, "asize");
+	ew = dv_get_value(np, "ew");
+	ss = dv_get_value(np, "ss");
+	val = __raw_readl(base + offset);
+	val &= TIMING_MASK;
+	val |= (asize & ACR_ASIZE_MASK);
+	if (ew)
+		val |= ACR_EW_MASK;
+	if (ss)
+		val |= ACR_SS_MASK;
+
+	__raw_writel(val, base + offset);
+
+	iounmap(base);
+	return 0;
+}
+#else
+int davinci_aemif_setup_timing_of(struct device_node *np)
+{
+	return 0;
+}
+#endif
+EXPORT_SYMBOL(davinci_aemif_setup_timing_of);
diff --git a/arch/arm/mach-davinci/include/mach/aemif.h b/arch/arm/mach-davinci/include/mach/aemif.h
index 05b2934..f3bbec6 100644
--- a/arch/arm/mach-davinci/include/mach/aemif.h
+++ b/arch/arm/mach-davinci/include/mach/aemif.h
@@ -33,4 +33,5 @@ struct davinci_aemif_timing {
 
 int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
 					void __iomem *base, unsigned cs);
+int davinci_aemif_setup_timing_of(struct device_node *np);
 #endif
-- 
1.7.7.6
