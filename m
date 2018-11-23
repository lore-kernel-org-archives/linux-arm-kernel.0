From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Nov 2018 13:27:29 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a77990: Add I2C-DVFS device node
In-Reply-To: <CAMuHMdW1Kqmu3spuejDQH6Yv1CPTvmYjFQA8L1n3fHbECoYT9A@mail.gmail.com>
References: <20181121121139.25493-1-horms+renesas@verge.net.au>
 <CAMuHMdW1Kqmu3spuejDQH6Yv1CPTvmYjFQA8L1n3fHbECoYT9A@mail.gmail.com>
Message-ID: <20181123122728.klshbmzxqjzk6d5r@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:21:39AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Nov 21, 2018 at 1:12 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> >
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch adds I2C-DVFS device node for the R8A77990 SoC.
> >
> > v2
> > * Drop aliases update as in upstream it is not required to configure the
> >   BD9571 PMIC for DDR backup, nor is the use of i2c are aliases desired.
> > * Do not describe the device as compatible with "renesas,rcar-gen3-iic" or
> >   "renesas,rmobile-iic" fallback compat strings. The absence of automatic
> >   transmission registers leads us to declare the r8a77990 IIC controller as
> >   incompatible.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > [simon: drop aliases hunk and fallback compat string usage]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for the update!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> > @@ -357,6 +357,20 @@
> >                         reg = <0 0xe6060000 0 0x508>;
> >                 };
> >
> > +               i2c_dvfs: i2c at e60b0000 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       compatible = "renesas,iic-r8a77990";
> > +                       reg = <0 0xe60b0000 0 0x34>;
> 
> ... 0x15>;

Thanks, sorry for missing that.

> > +                       interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&cpg CPG_MOD 926>;
> > +                       power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
> > +                       resets = <&cpg 926>;
> > +                       dmas = <&dmac0 0x11>, <&dmac0 0x10>;
> > +                       dma-names = "tx", "rx";
> > +                       status = "disabled";
> > +               };
> 
> With thwe above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have applied the following for v4.21:

>From 0b80b6f4b26e3c6e5861234badc4b12ef2928cac Mon Sep 17 00:00:00 2001
From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Date: Wed, 21 Nov 2018 13:11:39 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add I2C-DVFS device node

This patch adds I2C-DVFS device node for the R8A77990 SoC.

v2
* Drop aliases update as in upstream it is not required to configure the
  BD9571 PMIC for DDR backup, nor is the use of i2c are aliases desired.
* Do not describe the device as compatible with "renesas,rcar-gen3-iic" or
  "renesas,rmobile-iic" fallback compat strings. The absence of automatic
  transmission registers leads us to declare the r8a77990 IIC controller as
  incompatible.

v2.1
* Reduced register range to reflect documentation

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index b0398e05e8ed..3b334be843f4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -357,6 +357,20 @@
 			reg = <0 0xe6060000 0 0x508>;
 		};
 
+		i2c_dvfs: i2c at e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a77990";
+			reg = <0 0xe60b0000 0 0x15>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77990-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.11.0
