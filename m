From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 2 Feb 2016 16:07:07 +0800
Subject: [PATCH v4 2/6] dt-bindings: ARM: Mediatek: Document bindings
 for MT2701
In-Reply-To: <CAL_JsqLJVLDbPqynmD9-Yc=JVGH4iLPfb2keA5G7c2fjitAsSQ@mail.gmail.com>
References: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453271747-57397-3-git-send-email-jamesjj.liao@mediatek.com>
 <20160120163236.GA21035@rob-hp-laptop>
 <1453353537.5384.33.camel@mtksdaap41>
 <CAL_JsqLJVLDbPqynmD9-Yc=JVGH4iLPfb2keA5G7c2fjitAsSQ@mail.gmail.com>
Message-ID: <1454400427.2847.41.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, 2016-02-01 at 09:55 -0600, Rob Herring wrote:
> On Wed, Jan 20, 2016 at 11:18 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > On Wed, 2016-01-20 at 10:32 -0600, Rob Herring wrote:
> >> On Wed, Jan 20, 2016 at 02:35:43PM +0800, James Liao wrote:
> >> > This patch adds the binding documentation for apmixedsys, bdpsys,
> >> > ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
> >> > vdecsys for Mediatek MT2701.
> >> >
> >> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> >> > Tested-by: John Crispin <blogic@openwrt.org>
> >> > ---
> >> >  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 22 ++++++++++++++++++++++
> >> >  .../bindings/arm/mediatek/mediatek,ethsys.txt      | 22 ++++++++++++++++++++++
> >> >  .../bindings/arm/mediatek/mediatek,hifsys.txt      | 22 ++++++++++++++++++++++
> >> >  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
> >> >  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
> >> >  10 files changed, 73 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> >> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> >> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> >> > index 936166f..a701e19 100644
> >> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> >> > @@ -6,6 +6,7 @@ The Mediatek apmixedsys controller provides the PLLs to the system.
> >> >  Required Properties:
> >> >
> >> >  - compatible: Should be:
> >> > +   - "mediatek,mt2701-apmixedsys"
> >> >     - "mediatek,mt8135-apmixedsys"
> >> >     - "mediatek,mt8173-apmixedsys"
> >> >  - #clock-cells: Must be 1
> >> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> >> > new file mode 100644
> >> > index 0000000..4137196
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> >> > @@ -0,0 +1,22 @@
> >> > +Mediatek bdpsys controller
> >> > +============================
> >> > +
> >> > +The Mediatek bdpsys controller provides various clocks to the system.
> >>
> >> As you clarified these blocks provide more that just clocks. Please list
> >> all the functions here and on the others.
> >
> > Some blocks may provide clock and reset controller at the same time. But
> 
> Then say the block provides clocks and resets is all I'm asking for.

infracfg and pericfg had mentioned they would provide clock and reset
controllers. I'll add the same description into hifsys.

> > most of them will not provide functions directly. Instead, some DT
> > blocks which provide specific functions may refer to these controller
> > nodes due to it need to access the same register space.
> >
> > For example, scpsys (the power domain provider) refers to infracfg
> > because it need to control infracfg registers when power on/off domains:
> >
> >         scpsys: scpsys at 10006000 {
> >                 compatible = "mediatek,mt2701-scpsys";
> >                 #power-domain-cells = <1>;
> >                 reg = <0 0x10006000 0 0x1000>;
> >                 infracfg = <&infracfg>;
> >         };
> >
> > So I think it should not need to list all functions for each blocks
> > here.
> 
> Sorry, but you do need to describe what functions the blocks provide.

infracfg for example, this DT node provides only clock and reset
controllers.

	infracfg: power-controller at 10001000 {
		compatible = "mediatek,mt2701-infracfg", "syscon";
		reg = <0 0x10001000 0 0x1000>;
		#clock-cells = <1>;
		#reset-cells = <1>;
	};

It mapped register space 0x10001000 ~ 0x10001fff. The clock and reset
controllers only use partial registers in this space. Some other
functions, such as bus protection and DCM, use registers in 0x10001000 ~
0x10001fff. But these functions are not provided by this node. Instead,
these function may be implemented by other nodes, such as scpsys. That's
why we only list clock and reset controllers in infracfg document.

> Also, if you are accessing the infracfg regs directly to modify clock
> registers outside of the clock driver, that is very bad design. The
> clock driver could assume that register values are not changing behind
> its back and it bypasses any locks around register accesses. I can see
> why it is needed though, but we really need a proper interface.

No, we won't modify clock registers directly outside of clock driver.
All drivers that need to control clocks must use standard CCF APIs to
lookup and operate clocks.

Scpsys for example, it need to enable/disable clocks and bus protections
when power domain on/off. Scpsys will control clocks through CCF, and
control bus protections through regmap to access infracfg's registers.
Of course, the registers of clocks and bus protection are different.

	scpsys: scpsys at 10006000 {
		compatible = "mediatek,mt8173-scpsys";
		#power-domain-cells = <1>;
		reg = <0 0x10006000 0 0x1000>;
		clocks = <&clk26m>,
			 <&topckgen CLK_TOP_MM_SEL>,
			 <&topckgen CLK_TOP_VENC_SEL>,
			 <&topckgen CLK_TOP_VENC_LT_SEL>;
		clock-names = "mfg", "mm", "venc", "venc_lt";
		infracfg = <&infracfg>;
	};

Here is MT8173's scpsys DT node. And you can see it refers clocks
provided by topckeng, and infracfg register space.


Best regards,

James
