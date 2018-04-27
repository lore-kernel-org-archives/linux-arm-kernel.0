From: robh@kernel.org (Rob Herring)
Date: Thu, 26 Apr 2018 22:04:36 -0500
Subject: [PATCH v2 08/10] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
In-Reply-To: <5fa80b1e88ad2a215f51ea3a2b9b62274fa9b1ec.camel@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-4-paul.kocialkowski@bootlin.com>
 <1524153860.3416.9.camel@pengutronix.de>
 <CAAFQd5DT_xjUbZzFOoKk7_duiSZ8Awb1J=0dPEhVTBk0P3gppA@mail.gmail.com>
 <5fa80b1e88ad2a215f51ea3a2b9b62274fa9b1ec.camel@bootlin.com>
Message-ID: <20180427030436.3ptrb2ldhtnssipj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 09:22:20AM +0200, Paul Kocialkowski wrote:
> Hi and thanks for the review,
> 
> On Fri, 2018-04-20 at 01:31 +0000, Tomasz Figa wrote:
> > Hi Paul, Philipp,
> > 
> > On Fri, Apr 20, 2018 at 1:04 AM Philipp Zabel <p.zabel@pengutronix.de>
> > wrote:
> > 
> > > Hi Paul,
> > > On Thu, 2018-04-19 at 17:45 +0200, Paul Kocialkowski wrote:
> > > > This adds a device-tree binding document that specifies the
> > > > properties
> > > > used by the Sunxi-Cedurs VPU driver, as well as examples.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  .../devicetree/bindings/media/sunxi-cedrus.txt     | 50
> > 
> > ++++++++++++++++++++++
> > > >  1 file changed, 50 insertions(+)
> > > >  create mode 100644
> > 
> > Documentation/devicetree/bindings/media/sunxi-cedrus.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/sunxi-
> > > > cedrus.txt
> > 
> > b/Documentation/devicetree/bindings/media/sunxi-cedrus.txt
> > > > new file mode 100644
> > > > index 000000000000..71ad3f9c3352
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/sunxi-cedrus.txt
> > > > @@ -0,0 +1,50 @@
> > > > +Device-tree bindings for the VPU found in Allwinner SoCs,
> > > > referred to
> > 
> > as the
> > > > +Video Engine (VE) in Allwinner literature.
> > > > +
> > > > +The VPU can only access the first 256 MiB of DRAM, that are DMA-
> > > > mapped
> > 
> > starting
> > > > +from the DRAM base. This requires specific memory allocation and
> > 
> > handling.
> > 
> > And no IOMMU? Brings back memories.
> 
> Exactly, no IOMMU so we don't have much choice but cope with that
> hardware limitation...
> 
> > > > +
> > > > +Required properties:
> > > > +- compatible         : "allwinner,sun4i-a10-video-engine";
> > > > +- memory-region         : DMA pool for buffers allocation;
> > > > +- clocks             : list of clock specifiers, corresponding to
> > 
> > entries in
> > > > +                          the clock-names property;
> > > > +- clock-names                : should contain "ahb", "mod" and
> > > > "ram"
> > 
> > entries;
> > > > +- assigned-clocks       : list of clocks assigned to the VE;
> > > > +- assigned-clocks-rates : list of clock rates for the clocks
> > > > assigned
> > 
> > to the VE;
> > > > +- resets             : phandle for reset;
> > > > +- interrupts         : should contain VE interrupt number;
> > > > +- reg                        : should contain register base and
> > > > length
> > 
> > of VE.
> > > > +
> > > > +Example:
> > > > +
> > > > +reserved-memory {
> > > > +     #address-cells = <1>;
> > > > +     #size-cells = <1>;
> > > > +     ranges;
> > > > +
> > > > +     /* Address must be kept in the lower 256 MiBs of DRAM for
> > > > VE. */
> > > > +     ve_memory: cma at 4a000000 {
> > > > +             compatible = "shared-dma-pool";
> > > > +             reg = <0x4a000000 0x6000000>;
> > > > +             no-map;
> > > > +             linux,cma-default;
> > > > +     };
> > > > +};
> > > > +
> > > > +video-engine at 1c0e000 {
> > > This is not really required by any specification, and not as common
> > > as
> > > gpu at ..., but could this reasonably be called "vpu at 1c0e000" to follow
> > > somewhat-common practice?
> > 
> > AFAIR the name is supposed to be somewhat readable for someone that
> > doesn't know the hardware. To me, "video-engine" sounds more obvious
> > than "vpu", but we actually use "codec" already, in case of MFC and
> > JPEG codec on Exynos. If encode/decode is the only functionality of
> > this block, I'd personally go with "codec". If it can do other things,
> > e.g. scaling/rotation without encode/decode, I'd probably call it
> > "video-processor".
> 
> I agree that the term VPU is more commonly associated with video
> decoding, while video engine could mean a number of things.
> 
> The reason I went with "video-engine" here (while still presenting the
> driver as a VPU driver) is that Video Engine is the term used in
> Allwinner's litterature. Other nodes in Allwinner device-trees generally
> stick to these terms (for instance, we have "display-engine" nodes).
> This also makes it easier to find the matching parts in the
> documentation.

'video-codec' is what is defined in the DT spec.

Rob
