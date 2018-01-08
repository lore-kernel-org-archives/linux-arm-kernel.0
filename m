From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 8 Jan 2018 11:01:48 +0800
Subject: [PATCH v1 4/6] dt-bindings: clock: mediatek: add "simple-mfd"
 in audsys documentation
In-Reply-To: <20180105190236.bapetnwxd6dii7re@rob-hp-laptop>
References: <cover.1515038387.git.ryder.lee@mediatek.com>
 <bd1cb0aeaf07b4bf2cedbf00ef8fedc6ba01f9cb.1515038387.git.ryder.lee@mediatek.com>
 <20180105190236.bapetnwxd6dii7re@rob-hp-laptop>
Message-ID: <1515380508.2984.31.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-05 at 13:02 -0600, Rob Herring wrote:
> On Thu, Jan 04, 2018 at 03:44:20PM +0800, Ryder Lee wrote:
> > Add "simple-mfd" to support MFD device and add a compatible string for MT2701.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,audsys.txt       | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > index 9b8f578..6e97552 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > @@ -6,17 +6,25 @@ The MediaTek AUDSYS controller provides various clocks to the system.
> >  Required Properties:
> >  
> >  - compatible: Should be one of:
> > -	- "mediatek,mt7622-audsys", "syscon"
> > +	- "mediatek,mt2701-audsys", "syscon", "simple-mfd"
> > +	- "mediatek,mt7622-audsys", "syscon", "simple-mfd"
> >  - #clock-cells: Must be 1
> 
> I don't think this is a simple-mfd. The AFE uses clocks created by its 
> parent, right? So the parent should be probed first. You should have 
> the parent instantiate the child nodes.

The reason I add simple-mfd here is to make sure all drivers are probed.
We don't need to know the probing sequence but let *deferred probing* to
handle that. Otherwise, I think there is no difference between audsys
and other clock nodes (the only difference is audsys shares its register
regions with AFE).

But yes, parent should be probed first in general. How about this:

audio-subsystem at 11220000 {
		compatible = "syscon", "simple-mfd";
		reg = <0 0x11220000 0 0x2000>;

		audsys: clock-controller {
			compatible = "mediatek,mt2701-audsys";
			#clock-cells = <1>;
		};
	
		afe: audio-controller {
			compatible = "mediatek,mt2701-audio";
			.....
			<&topckgen CLK_TOP_AUD_I2S4_MCLK>,
			<&audsys CLK_AUD_I2SO1>,
			....
		};
	};


I prefer to separate these nodes as we could see them as unrelated
functions. Or, alternatively, I could add a MFD driver to instantiate
both audsys and AFE driver.

The similar discussion thread could be found in other subsystem:
http://lists.infradead.org/pipermail/linux-mediatek/2017-October/011035.html

I want to come up with a consistent approach to handle this kind of
situation.

> >  The AUDSYS controller uses the common clk binding from
> >  Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> >  
> > +See ../sound/mt2701-afe-pcm.txt for details about required subnode.
> > +
> >  Example:
> >  
> > -audsys: audsys at 11220000 {
> > -	compatible = "mediatek,mt7622-audsys", "syscon";
> > -	reg = <0 0x11220000 0 0x1000>;
> > -	#clock-cells = <1>;
> > -};
> > +	audsys: audio-subsystem at 11220000 {
> > +		compatible = "mediatek,mt2701-audsys", "syscon", "simple-mfd";
> > +		reg = <0 0x11220000 0 0x1000>;
> > +		#clock-cells = <1>;
> > +
> > +		afe: audio-controller {
> > +			compatible = "mediatek,mt2701-audio";
> > +			...
> > +		};
> > +	};
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
