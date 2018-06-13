From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 13 Jun 2018 18:03:21 +0200
Subject: [linux-sunxi] Re: [PATCH v2 04/27] dt-bindings: display:
 sunxi-drm: Add TCON TOP description
In-Reply-To: <20180613073456.jk72zw4rt4ysjco7@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-5-jernej.skrabec@siol.net>
 <20180613073456.jk72zw4rt4ysjco7@flea>
Message-ID: <2481282.yoIGH2ksVh@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne sreda, 13. junij 2018 ob 09:34:56 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> Thanks for working on this!
> 
> On Tue, Jun 12, 2018 at 10:00:13PM +0200, Jernej Skrabec wrote:
> > TCON TOP main purpose is to configure whole display pipeline. It
> > determines relationships between mixers and TCONs, selects source TCON
> > for HDMI, muxes LCD and TV encoder GPIO output, selects TV encoder
> > clock source and contains additional TV TCON and DSI gates.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  .../bindings/display/sunxi/sun4i-drm.txt      | 45 +++++++++++++++++++
> >  include/dt-bindings/clock/sun8i-tcon-top.h    | 11 +++++
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> > 3346c1e2a7a0..ef64c589a4b3 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > 
> > @@ -187,6 +187,51 @@ And on the A23, A31, A31s and A33, you need one more 
clock line:
> >     - 'lvds-alt': An alternative clock source, separate from the TCON
> >     channel 0
> >     
> >                   clock, that can be used to drive the LVDS clock
> > 
> > +TCON TOP
> > +--------
> > +
> > +TCON TOPs main purpose is to configure whole display pipeline. It
> > determines +relationships between mixers and TCONs, selects source TCON
> > for HDMI, muxes +LCD and TV encoder GPIO output, selects TV encoder clock
> > source and contains +additional TV TCON and DSI gates.
> > +
> > +It allows display pipeline to be configured in very different ways:
> > +
> > +                             / LCD0/LVDS0
> > +                 / TCON-LCD0
> > +                 |           \ MIPI DSI
> > + mixer0          |
> > +        \        / TCON-LCD1 - LCD1/LVDS1
> > +         TCON-TOP
> > +        /        \ TCON-TV0 - TVE0/RGB
> > + mixer1          |          \
> > +                 |           TCON-TOP - HDMI
> > +                 |          /
> > +                 \ TCON-TV1 - TVE1/RGB
> > +
> > +Note that both TCON TOP references same physical unit.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun8i-r40-tcon-top
> > +  - reg: base address and size of the memory-mapped region.
> > +  - clocks: phandle to the clocks feeding the TCON TOP
> > +    * bus: TCON TOP interface clock
> > +  - clock-names: clock name mentioned above
> > +  - resets: phandle to the reset line driving the DRC
> 
> s/DRC/TCON TOP/ ?

Yes, copy & paste issue

> 
> > +    * rst: TCON TOP reset line
> 
> Remaining consistent with the clock name would be great

You mean "ahb"? I noticed that most other nodes with reset lines don't have a 
name associated. Maybe I could just drop it and use first specified reset?

> 
> > +  - reset-names: reset name mentioned above
> > +  - #clock-cells : must contain 1
> 
> An example would be nice here

You mean node example? with ports? In the past, Rob was against examples 
unless really necessary. Node from R40 DTSI can serve as an example.

> 
> > +- ports: A ports node with endpoint definitions as defined in
> > +    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > first port +    should be the input for mixer0 mux. The second should be
> > the output for that +    mux. Third port should be input for mixer1 mux.
> > Fourth port should be output +    for mixer1 mux. Fifth port should be
> > input for HDMI mux. Sixth port should +    be output for it. All output
> > endpoints should have reg property with the id +    of the target TCON.
> > All ports should have only one enpoint connected to
>                                                           ^ endpoint
> 
> I guess it would me more readable if you were to make it a bullet
> list, but this works for me otherwise.

Since I have to fix this patch anyway, I can refactor this text.

Best regards,
Jernej
