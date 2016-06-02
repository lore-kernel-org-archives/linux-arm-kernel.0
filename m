From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Fri, 03 Jun 2016 00:19:35 +0100
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?==?utf-8?q?_3=2F5=5D?=
 =?utf-8?q?_Documentation=2Fdevicetree=2Fbindings=3A?= Add
 =?utf-8?q?b850v3=5Flvds=5Fdp?=
In-Reply-To: <1464871741.3307.16.camel@pengutronix.de>
Message-ID: <7088-5750bf00-5-4a882000@180860528>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Philipp,

Thank you very much for the review! I'll send V2 soon, doing my best to avoid collisions with other patches that are under review.

On Thursday, June 2, 2016 14:49 CEST, Philipp Zabel <p.zabel@pengutronix.de> wrote: 
 
> Hi Peter,
> 
> Am Montag, den 30.05.2016, 18:39 +0200 schrieb Peter Senna Tschudin:

> > Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> > display bridge.
> > 
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > ---
> >  .../devicetree/bindings/ge/b850v3_lvds_dp.txt      | 38 ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> > new file mode 100644
> > index 0000000..32e123a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> > @@ -0,0 +1,38 @@
> > +Driver for GE B850v3 LVDS/DP++ display bridge
> > +
> > +Required properties:
> > +  - compatible : should be "ge,b850v3_lvds_dp".
> 
> In the cover mail you write that this is a combination of the STDP4028
> DP transmitter and STDP2690 DP/DP++ converter. So shouldn't this binding
> comprise two device tree nodes, one with compatible "st,stdp4028", one
> with "st,stdp2690", then?
> Is the stdp2690 connected to the stdp4028's i2c master?

The hardware and firmware made it complicated for this binding to comprise two device tree nodes. The hardware and firmware are designed to configure both bridges based on the LVDS signal. This part works very well, but it leave the driver powerless to control the video processing pipeline. The bridges sort of behave as a single bridge, the sort of part is the need of interacting with both bridges: EDID from the STDP2690 and HPD events from the STDP4028. So the driver is only needed for telling the host about EDID / HPD, and for giving the host powers to ack interrupts.

I would find it nicer to be author of two drivers instead of one, but as the behavior handled by the driver is specific of the B850v3, and do not reflect the standard behavior of each bridge, I find it unlikely that the driver could be useful to handle STDP4028 and STPD2690 with stock firmware, or in other designs. On the other hand, I made sure to use the chip name on the defines to maximize chances of reuse.

Peter
