From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 05 Jan 2018 07:20:46 +0100
Subject: [linux-sunxi] Re: [PATCH 06/11] dt-bindings: display: sun4i-drm:
 Add A83T HDMI pipeline
In-Reply-To: <4B652FB5-08B2-416B-ABA9-08E12112087D@aosc.io>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20180104185210.afsvsofq7q35psa6@flea.lan>
 <4B652FB5-08B2-416B-ABA9-08E12112087D@aosc.io>
Message-ID: <2801449.XnWJ1iOJse@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne petek, 05. januar 2018 ob 03:49:09 CET je Icenowy Zheng napisal(a):
> ? 2018?1?5? GMT+08:00 ??2:52:10, Maxime Ripard <maxime.ripard@free-
electrons.com> ??:
> >On Wed, Jan 03, 2018 at 10:32:26PM +0100, Jernej ?krabec wrote:
> >> Hi Rob,
> >> 
> >> Dne sreda, 03. januar 2018 ob 21:21:54 CET je Rob Herring napisal(a):
> >> > On Sat, Dec 30, 2017 at 10:01:58PM +0100, Jernej Skrabec wrote:
> >> > > This commit adds all necessary compatibles and descriptions
> >
> >needed to
> >
> >> > > implement A83T HDMI pipeline.
> >> > > 
> >> > > Mixer is already properly described, so only compatible is added.
> >> > > 
> >> > > However, A83T TCON1, which is connected to HDMI, doesn't have
> >
> >channel 0,
> >
> >> > > contrary to all TCONs currently described. Because of that, TCON
> >> > > documentation is extended.
> >> > > 
> >> > > A83T features Synopsys DW HDMI controller with a custom PHY which
> >
> >looks
> >
> >> > > like Synopsys Gen2 PHY with few additions. Since there is no
> >> > > documentation, needed properties were found out through
> >
> >experimentation
> >
> >> > > and reading BSP code.
> >> > > 
> >> > > At the end, example is added for newer SoCs, which features DE2
> >
> >and DW
> >
> >> > > HDMI.
> >> > > 
> >> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > > ---
> >> > > 
> >> > >  .../bindings/display/sunxi/sun4i-drm.txt           | 188
> >> > >  ++++++++++++++++++++- 1 file changed, 181 insertions(+), 7
> >
> >deletions(-)
> >
> >> > > diff --git
> >
> >a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >
> >> > > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >
> >index
> >
> >> > > 9f073af4c711..3eca258096a5 100644
> >> > > ---
> >
> >a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >
> >> > > +++
> >
> >b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> >
> >> > > @@ -64,6 +64,40 @@ Required properties:
> >> > >      first port should be the input endpoint. The second should
> >
> >be the
> >
> >> > >      output, usually to an HDMI connector.
> >> > > 
> >> > > +DWC HDMI TX Encoder
> >> > > +-----------------------------
> >> > > +
> >> > > +The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX
> >
> >controller IP
> >
> >> > > +with Allwinner's own PHY IP. It supports audio and video outputs
> >
> >and CEC.
> >
> >> > > +
> >> > > +These DT bindings follow the Synopsys DWC HDMI TX bindings
> >
> >defined in
> >
> >> > > +Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
> >
> >with the
> >
> >> > > +following device-specific properties.
> >> > > +
> >> > > +Required properties:
> >> > > +
> >> > > +  - compatible: value must be one of:
> >> > > +    * "allwinner,sun8i-a83t-dw-hdmi"
> >> > > +  - reg: two pairs of base address and size of memory-mapped
> >
> >region,
> >
> >> > > first
> >> > > +    for controller and second for PHY
> >> > > +    registers.
> >> > 
> >> > Seems like the phy should be a separate node and use the phy
> >
> >binding.
> >
> >> > You can use the phy binding even if you don't use the kernel phy
> >> > framework...
> >> 
> >> Unfortunately, it's not so straighforward. Phy is actually accessed
> >
> >through
> >
> >> I2C implemented in HDMI controller. Second memory region in this case
> >
> >has
> >
> >> small influence on phy. However, it has big influence on controller.
> >
> >For
> >
> >> example, magic number has to be written in one register in second
> >
> >memory
> >
> >> region in order to unlock read access to any register from first
> >
> >memory region
> >
> >> (controller). However, they shouldn't be merged to one region,
> >
> >because first
> >
> >> memory region requires byte access while second memory region can be
> >
> >accessed
> >
> >> per byte or word.
> >> 
> >> To complicate things more, later I want to add support for another
> >
> >SoC which
> >
> >> has same glue layer (unlocking read access, etc.) and uses memory
> >
> >mapped phy
> >
> >> registers in second memory region.
> >> 
> >> I think current binding is the least complicated way to represent
> >
> >this.
> >
> >I agree with Rob here. I did a similar thing for the DSI patches I've
> >sent a few monthes ago and it turned out to not be that difficult, so
> >I'm sure you can come up with something :)
> 
> In A83T/H3/A64/H5/R40 this part is not purely a PHY.
> It controls the access of main controller's register (e.g. read/write
> lock and register obfuscation). So it should be called a "glue"
> with PHY part (and on A83T seems a pure glue) but not a simple
>  PHY.

It's not so simple. Actually it has PHY settings also on A83T. For example, 
value at 0x01EF0001 depends on polarity. Value at 0x01EF0002 sets PHY I2C 
address. Bit 7 at 0x01EF0007 enables/disables external resistor. That is info 
I discovered/received after I sent patches, so it's not cleary marked.

Proper memory map (starts at 0x01EE0000):
0x00000 - 0x10000 -> DW HDMI controller
0x10000 - 0x10010 -> (almost?) Common PHY settings
0x10010 - 0x10020 -> Allwinner proprietary glue layer
0x10020 - 0x10040 -> Allwinner proprietary PHY (not present on A83T)

In preliminary PHY doc AW released, there are additional regs at 0x01EF0FF8 
and 0x01EF0FFC for controller ID and phy ID, but it was always 0 at A83T and 
H3.

So splitting memory in so many regions just to satisfy clean division it 
doesn't seem sane to me. Now that I checked how Maxime did it with MIPI DSI 
driver, I'm good with dividing it into two parts.

Best regards,
Jernej


> 
> >Maxime
> >
> >--
> >Maxime Ripard, Free Electrons
> >Embedded Linux and Kernel engineering
> >http://free-electrons.com
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel at lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
