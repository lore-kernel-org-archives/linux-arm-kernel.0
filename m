From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 23 Aug 2011 20:48:41 +0530
Subject: Fwd: [RFC/PATCH v2 09/13] dt: omap4: add soc file for handling
	i2c controllers
In-Reply-To: <4E53AF9F.8070607@ti.com>
References: <1314074021-25186-10-git-send-email-manjugk@ti.com>
	<4E537FA7.3050609@ti.com> <4E53AF9F.8070607@ti.com>
Message-ID: <20110823151841.GB32698@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 03:48:15PM +0200, Cousson, Benoit wrote:
> From: G, Manjunath Kondaiah<manjugk@ti.com>
> >To: devicetree-discuss at lists.ozlabs.org
> >CC: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
> >
> >
> >Add omap4 soc dts file for handling omap4 soc i2c
> >controllers existing on l4-core bus.
> 
> The subject and changelog is not accurate. You are doing at least 3 things:
> Moving the OMAP4 SoC data from panda board file to a SoC specific
> omap4.dtsi file.
> Including the omap4.dtsi into panda.
> Adding some i2c nodes.
> 
> You should use at least two or three separated patches to avoid
> in-accurate subject.

As these changes are straight forward, I can update patch description with
the required information instead of create too many patches.

If you are too specific on splitting the patches, I am ok with that too.

> 
> Benoit
> 
> 
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >---
> >   arch/arm/boot/dts/omap4-panda.dts |    7 +---
> >   arch/arm/boot/dts/omap4.dtsi      |   68
> >+++++++++++++++++++++++++++++++++++++
> >   2 files changed, 69 insertions(+), 6 deletions(-)
> >   create mode 100644 arch/arm/boot/dts/omap4.dtsi
> >
> >diff --git a/arch/arm/boot/dts/omap4-panda.dts
> >b/arch/arm/boot/dts/omap4-panda.dts
> >index 58909e9..c28aa95 100644
> >--- a/arch/arm/boot/dts/omap4-panda.dts
> >+++ b/arch/arm/boot/dts/omap4-panda.dts
> >@@ -1,9 +1,4 @@
> >-/dts-v1/;
> >-
> >-/memreserve/ 0x9D000000 0x03000000; /* Frame buffer */
> >-/memreserve/ 0xB0000000 0x10000000; /* Top 256MB is unaccessable */
> >-
> >-/include/ "skeleton.dtsi"
> >+/include/ "omap4.dtsi"
> >
> >   / {
> >   	model = "TI OMAP4 PandaBoard";
> >diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> >new file mode 100644
> >index 0000000..cb055f5
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/omap4.dtsi
> >@@ -0,0 +1,68 @@
> >+/*
> >+ * Device Tree Source for OMAP4 SoC
> >+ *
> >+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >+ *
> >+ * This file is licensed under the terms of the GNU General Public License
> >+ * version 2.  This program is licensed "as is" without any warranty of any
> >+ * kind, whether express or implied.
> >+ */
> >+
> >+/dts-v1/;
> >+
> >+/memreserve/ 0x9D000000 0x03000000; /* Frame buffer */
> >+/memreserve/ 0xB0000000 0x10000000; /* Top 256MB is unaccessable */
> 
> That information was already there previously but where does it come from?
> 48 MB is clearly not for the FB, and the top 256 MB should be
> accessible with highmem.
This was originally introduced by Grant and he can provide more info on this
change.

39881c4e (Grant Likely 2011-07-05 23:42:31 -0600  4)

-M

> 
> Benoit
> 
> >+
> >+/include/ "skeleton.dtsi"
> >+
> >+/ {
> >+	#address-cells =<1>;
> >+	#size-cells =<1>;
> >+	model = "ti,omap4";
> >+
> >+	aliases {
> >+		i2c1 =&i2c1;
> >+		i2c2 =&i2c2;
> >+		i2c3 =&i2c3;
> >+		i2c4 =&i2c4;
> >+	};
> >+
> >+	l4-core {
> >+		compatible = "ti,omap4-l4-core", "sonics,s3220";
> >+		#address-cells =<1>;
> >+		#size-cells =<1>;
> >+		ranges =<0 0x48000000 0x1000000>;
> >+
> >+		i2c1: i2c at 70000 {
> >+			#address-cells =<1>;
> >+			#size-cells =<0>;
> >+			compatible = "ti,omap-i2c", "ti,omap-device";
> >+			reg =<0x70000 0x100>;
> >+			interrupts =<  88>;
> >+		};
> >+
> >+		i2c2: i2c at 72000 {
> >+			#address-cells =<1>;
> >+			#size-cells =<0>;
> >+			compatible = "ti,omap-i2c", "ti,omap-device";
> >+			reg =<0x72000 0x100>;
> >+			interrupts =<  89>;
> >+		};
> >+
> >+		i2c3: i2c at 60000 {
> >+			#address-cells =<1>;
> >+			#size-cells =<0>;
> >+			compatible = "ti,omap-i2c", "ti,omap-device";
> >+			reg =<0x60000 0x100>;
> >+			interrupts =<  93>;
> >+		};
> >+
> >+		i2c4: i2c at 350000 {
> >+			#address-cells =<1>;
> >+			#size-cells =<0>;
> >+			compatible = "ti,omap-i2c", "ti,omap-device";
> >+			reg =<0x350000 0x100>;
> >+			interrupts =<  94>;
> >+		};
> >+	};
> >+};
> 
