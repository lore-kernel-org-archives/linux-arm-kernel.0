From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Feb 2018 10:12:23 +0100
Subject: [PATCH v2 4/5] arm64: dts: renesas: initial Condor board device
 tree
In-Reply-To: <da5c612d-d23d-be36-7dfe-e3e78cc2b086@cogentembedded.com>
References: <ae31804b-969b-9b20-16d0-50f5dea42f08@cogentembedded.com>
 <5cf82cb1-0278-010c-165d-07dbcbe0878d@cogentembedded.com>
 <CAMuHMdWwjXw0SwVK704_AtkDg3C-or5bUbXPwMEvTwU5eLGrpQ@mail.gmail.com>
 <da5c612d-d23d-be36-7dfe-e3e78cc2b086@cogentembedded.com>
Message-ID: <20180219091223.rvumtwr6t47szrwo@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 11:34:41AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 2/19/2018 11:30 AM, Geert Uytterhoeven wrote:
> 
> > > Add the initial device  tree for  the R8A77980 SoC based Condor board.
> > > The board has 1 debug serial port (SCIF0); include support for it, so
> > > that the serial console can work.
> > > 
> > > Based on the original (and large) patch by Vladimir Barinov.
> > > 
> > > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > ---
> > > Changes in version 2:
> > > - removed the useless "status" property from the SCIF_CLK node;
> > > - fixed the memory size;
> > > - added Geert's tag.
> > 
> > > --- /dev/null
> > > +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> > > @@ -0,0 +1,45 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device Tree Source for the Condor board
> > > + *
> > > + * Copyright (C) 2018 Renesas Electronics Corp.
> > > + * Copyright (C) 2018 Cogent Embedded, Inc.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "r8a77980.dtsi"
> > > +
> > > +/ {
> > > +       model = "Renesas Condor board based on r8a77980";
> > > +       compatible = "renesas,condor", "renesas,r8a77980";
> > > +
> > > +       aliases {
> > > +               serial0 = &scif0;
> > > +       };
> > > +
> > > +       chosen {
> > > +               stdout-path = "serial0:115200n8";
> > > +       };
> > > +
> > > +       memory at 48000000 {
> > > +               device_type = "memory";
> > > +               /* first 128MB is reserved for secure area. */
> > > +               reg = <0 0x48000000 0 0xb8000000>;
> > 
> > Shouldn't the size be 0x78000000, or is there really 3 GiB of RAM?
> 
>    Ugh, so I finally mixed up limit and size... :-/

Thanks, I will apply the following, with the memory corrected to 2 GiB.

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] arm64: dts: renesas: initial Condor board device tree

Add the initial device  tree for  the R8A77980 SoC based Condor board.
The board has 1 debug serial port (SCIF0); include support for it, so
that the serial console can work.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: correct memory size to 0x78000000 (2GiB)]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile            |  1 +
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 45 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-condor.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 2186d0193b73..c885eef4e660 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -8,4 +8,5 @@ dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
+dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
new file mode 100644
index 000000000000..daf2957d3504
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Condor board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+
+/dts-v1/;
+#include "r8a77980.dtsi"
+
+/ {
+	model = "Renesas Condor board based on r8a77980";
+	compatible = "renesas,condor", "renesas,r8a77980";
+
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0 0x48000000 0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&scif0 {
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <14745600>;
+};
-- 
2.11.0
