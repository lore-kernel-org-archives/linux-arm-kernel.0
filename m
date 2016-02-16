From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Tue, 16 Feb 2016 20:06:22 +0800
Subject: [RFC 1/3] dt-bindings: soc: Add documentation for the MediaTek
 GCE unit
In-Reply-To: <56B8D5A3.3000506@gmail.com>
References: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
 <1453266881-16849-2-git-send-email-hs.liao@mediatek.com>
 <20160120163826.GA23400@rob-hp-laptop>
 <1453433893.15298.13.camel@mtksdaap41> <56B8D5A3.3000506@gmail.com>
Message-ID: <1455624382.17318.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Mon, 2016-02-08 at 18:51 +0100, Matthias Brugger wrote:
> 
> On 22/01/16 04:38, Horng-Shyang Liao wrote:
> > Hi Rob,
> >
> > On Wed, 2016-01-20 at 10:38 -0600, Rob Herring wrote:
> >> On Wed, Jan 20, 2016 at 01:14:38PM +0800, hs.liao at mediatek.com wrote:
> >>> From: HS Liao <hs.liao@mediatek.com>
> >>>
> >>> This adds documentation for the MediaTek Global Command Engine (GCE) unit
> >>> found in MT8173 SoCs.
> >>>
> >>> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> >>> ---
> >>>   .../devicetree/bindings/soc/mediatek/gce.txt       |   33 ++++++++++++++++++++
> >>>   1 file changed, 33 insertions(+)
> >>>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/mediatek/gce.txt b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
> >>> new file mode 100644
> >>> index 0000000..878b11e
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
> >>> @@ -0,0 +1,33 @@
> >>> +MediaTek GCE
> >>> +===============
> >>> +
> >>> +The Global Command Engine (GCE) is used to help read/write registers with
> >>> +critical time limitation, such as updating display configuration during the
> >>> +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> >>> +Currently, the GCE only supports display related hardwares, but we expect
> >>> +it can be extended to other hardwares for future requirements.
> >>
> >> That's a hardware limitation or just s/w is only using it for display?
> >> If the latter, that's not really relevant to this binding and should be
> >> removed.
> >
> > Just s/w is only using it for display.
> > I will remove it from next patch.
> >
> >>> +
> >>> +Required properties:
> >>> +- compatible: Must be "mediatek,mt8173-gce"
> >>> +- reg: Address range of the GCE unit
> >>> +- interrupts: The interrupt signal from the GCE block
> >>> +- clock: Clocks according to the common clock binding
> >>> +- clock-names: Must be "gce" to stand for GCE clock
> >>> +
> >>> +Example:
> >>> +
> >>> +	gce: gce at 10212000 {
> >>> +		compatible = "mediatek,mt8173-gce";
> >>> +		reg = <0 0x10212000 0 0x1000>;
> >>> +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> >>> +		clocks = <&infracfg CLK_INFRA_GCE>;
> >>> +		clock-names = "gce";
> >>> +	};
> >>> +
> >>> +	mmsys: clock-controller at 14000000 {
> >>> +		compatible = "mediatek,mt8173-mmsys", "syscon";
> >>> +		reg = <0 0x14000000 0 0x1000>;
> >>> +		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> >>> +		#clock-cells = <1>;
> >>> +		mediatek,gce = <&gce>;
> >>
> >> Not documented.
> >
> > It's just an example about how gce is used by display mmsys.
> > After I discussed with Mediatek display owner,
> > we think this can be moved to display device tree document.
> > Do you agree with this suggestion?
> > If so, I will remove it from next patch, too.
> >
> 
> The problem is that mediatek,gce is not documented, but only 
> mediatek,mt8173-gce.

How about this?

Required properties for a client device:
- mediatek,gce: Should point to the respective GCE block

Example for a client device:

mmsys: clock-controller at 14000000 {
	compatible = "mediatek,mt8173-mmsys";
	mediatek,gce = <&gce>;
	...
};


> 
> Regards,
> Matthias

Thanks,
HS Liao
