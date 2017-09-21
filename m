From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 21 Sep 2017 17:50:24 +0800
Subject: [PATCH v1 3/4] arm: dts: mt7623: add display related nodes
In-Reply-To: <1505834813.16414.5.camel@mtksdaap41>
References: <cover.1505801355.git.ryder.lee@mediatek.com>
 <0eb19ae1a4717d316cdaec44f6c20bfa8aa24ddc.1505801355.git.ryder.lee@mediatek.com>
 <1505834813.16414.5.camel@mtksdaap41>
Message-ID: <1505987424.3084.8.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-09-19 at 23:26 +0800, CK Hu wrote:
> Hi, Ryder:
> 
> Some comment inline.
> 
> On Tue, 2017-09-19 at 14:27 +0800, Ryder Lee wrote:
> > This patch adds the device nodes for the display function block.
> > Also, we add some missing pin macros in mt7623-pinfunc.h.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > CC: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi                 | 210 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  41 ++++-
> >  include/dt-bindings/pinctrl/mt7623-pinfunc.h  |  12 ++
> >  3 files changed, 261 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> > index 9ec3767..e11e5e7 100644
> > --- a/arch/arm/boot/dts/mt7623.dtsi
> > +++ b/arch/arm/boot/dts/mt7623.dtsi
> > @@ -20,6 +20,7 @@
> >  #include <dt-bindings/power/mt2701-power.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/phy/phy.h>
> > +#include <dt-bindings/memory/mt2701-larb-port.h>
> >  #include <dt-bindings/reset/mt2701-resets.h>
> >  #include <dt-bindings/thermal/thermal.h>
> >  #include "skeleton64.dtsi"
> > @@ -28,6 +29,11 @@
> >  	compatible = "mediatek,mt7623";
> >  	interrupt-parent = <&sysirq>;
> >  
> > +	aliases {
> > +		rdma0 = &rdma0;
> > +		rdma1 = &rdma1;
> 
> For display, are these two aliases enough?

Yes, this part is the same as mt2701.

https://patchwork.kernel.org/patch/9803813/

> > +	};
> > +

...
> > +	wdma at 14009000 {
> > +		compatible = "mediatek,mt7623-disp-wdma",
> > +			     "mediatek,mt2701-disp-wdma";
> 
> There is neither "mediatek,mt7623-disp-wdma" nor
> "mediatek,mt2701-disp-wdma" in driver, do you really need this device
> node?

Okay, I will remove it.

> > +		reg = <0 0x14009000 0 0x1000>;
> > +		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&mmsys CLK_MM_DISP_WDMA>;
> > +		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> > +		mediatek,larb = <&larb0>;
> > +	};
> > +
> > +	bls: bls at 1400a000 {
> > +		compatible = "mediatek,mt7623-disp-pwm",
> > +			     "mediatek,mt2701-disp-pwm";
> > +		reg = <0 0x1400a000 0 0x1000>;
> > +		#pwm-cells = <2>;
> > +		clocks = <&mmsys CLK_MM_MDP_BLS_26M>,
> > +			 <&mmsys CLK_MM_DISP_BLS>;
> > +		clock-names = "main", "mm";
> > +		status = "disabled";
> > +	};
> > +
> > +	color at 1400b000 {
> 
> color: color at 1400b000 {

Okay.
> > +		compatible = "mediatek,mt7623-disp-color",
> > +			     "mediatek,mt2701-disp-color";
> > +		reg = <0 0x1400b000 0 0x1000>;
> > +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&mmsys CLK_MM_DISP_COLOR>;
> > +	};
> > +
