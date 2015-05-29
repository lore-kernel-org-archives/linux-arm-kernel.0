From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 29 May 2015 10:47:29 +0800
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
In-Reply-To: <20150528132452.GI26575@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150528132452.GI26575@pengutronix.de>
Message-ID: <1432867649.15597.46.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, 2015-05-28 at 15:24 +0200, Sascha Hauer wrote:
> On Thu, May 21, 2015 at 03:12:51PM +0800, James Liao wrote:
> > This patchset contains subsystem clocks support for Mediatek MT8173.
> > It also contains some bug fixes before adds new clocks support.
> > 
> > James Liao (4):
> >   clk: mediatek: Fix apmixedsys clock registration
> >   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock
> >     controllers
> >   clk: mediatek: Add subsystem clocks of MT8173
> >   clk: mediatek: Add USB clock support in MT8173 APMIXEDSYS
> > 
> > Sascha Hauer (1):
> >   clk: mediatek: mt8173: Fix enabling of critical clocks
> > 
> >  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  22 +
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  22 +
> >  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  22 +
> >  .../bindings/arm/mediatek/mediatek,vencltsys.txt   |  22 +
> >  .../bindings/arm/mediatek/mediatek,vencsys.txt     |  22 +
> >  drivers/clk/mediatek/clk-mt8135.c                  |   2 +-
> >  drivers/clk/mediatek/clk-mt8173.c                  | 454 ++++++++++++++++++++-
> >  drivers/clk/mediatek/clk-pll.c                     |   7 +-
> >  include/dt-bindings/clock/mt8173-clk.h             |  94 ++++-
> >  9 files changed, 652 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
> 
> I have looked a bit closer at the vdec, venc, mmsys and other units. I
> have come to the conclusion that the units and subunits should be
> rearranged in the device tree. Currently we have a flat list of units,
> but really they are hierarchical with top devices and subdevices. Take
> vencsys as an example. Instead of:
> 
> 	vencsys: vencsys at 18000000 {
> 		compatible = "mediatek,mt8173-vencsys", "syscon";
> 		reg = <0 0x18000000 0 0x1000>;
> 		#clock-cells = <1>;
> 	};
> 
> 	larb3:larb at 18001000 {
> 		compatible = "mediatek,mt8173-smi-larb";
> 		reg = <0 0x18001000 0 0x1000>;
> 		clocks = <&mmsys MM_SMI_COMMON>,
> 			 <&vencsys VENC_CKE0>,
> 			 <&vencsys VENC_CKE1>;
> 		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> 	};
> 
> This should be:
> 
> 	vencsys: vencsys at 18000000 {
> 		compatible = "mediatek,mt8173-vencsys";
> 		reg = <0 0x18000000 0 0x01000000>;
> 		#clock-cells = <1>;
> 		ranges;
> 
> 		larb3:larb at 18001000 {
> 			compatible = "mediatek,mt8173-smi-larb";
> 			reg = <0 0x18001000 0 0x1000>;
> 			clocks = <&mmsys MM_SMI_COMMON>,
> 				 <&vencsys VENC_CKE0>,
> 				 <&vencsys VENC_CKE1>;
> 			clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> 		};
> 
> 		/* The actual video encoder */
> 		venc:video-encoder@?? {
> 			compatible = "mediatek,mtxxxx-videoenc";
> 		};
> 	};
> 
> And really the driver matching "mediatek,mt8173-vencsys" should register
> the necessary clocks and reset lines and call of_platform_populate on
> the subnodes. The driver should also be a real driver, not something
> matched by CLK_OF_DECLARE. The "mediatek,mt8173-vencsys" driver now has
> the possibility to manage the toplevel vencsys unit, do runtime pm, turn
> the whole thing off and on. Using CCF for abstracting these clocks may
> be the right thing, but I believe that we should keep the code for the
> toplevel vencsys register space together in a single file and not put
> the clk bits in drivers/clk/mediatek/mt8173.c, the reset bits in
> drivers/reset/ and the remaining misc stuff in drivers/soc/mediatek/.
> 
> So I think we should have a drivers/soc/mediatek/mtk-vencsys.c which
> is a regular driver, calls clk_register() for its clocks, calls
> reset_controller_register() for the reset bits, provides plain functions
> for the remaining bits which are not handled by any Linux framework.
> Finally of_platform_populate will register the child devices.
> 
> I showed this using the vencsys example, but it's the same for vdecsys,
> vencltsys, imgsys and mmsys.

So you agree to manage these subsystem clocks in CCF, but they should be
provided by their own (globalcon) drivers, right?

I have an implementation question. These subsystem clocks can't be
implemented in CCF default clock-gate. So in our previous patches, we
added a drivers/clk/mediate/clk-gate.c to implement new clock gate
operations. Is it a good way to export mediatek/clk-gate.h (put it in
include/linux/) for other drivers to implement their own clocks?


Best regards,

James
