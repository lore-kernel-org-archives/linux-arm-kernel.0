From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 24 Apr 2018 14:17:03 +0200
Subject: [PATCH 1/2 v3] drm/pl111: Support the Versatile Express
In-Reply-To: <CACRpkdaUBsOe3EYNU1x8eTnjeXQ3G_r8VZ+waJFad03MRVurtA@mail.gmail.com>
References: <20180418085242.19525-1-linus.walleij@linaro.org>
 <55427808-5ebc-e9b3-827a-b61622878a4e@arm.com>
 <CACRpkdaUBsOe3EYNU1x8eTnjeXQ3G_r8VZ+waJFad03MRVurtA@mail.gmail.com>
Message-ID: <20180424121703.GY31310@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 09:18:33AM +0200, Linus Walleij wrote:
> On Wed, Apr 18, 2018 at 2:48 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 18/04/18 09:52, Linus Walleij wrote:
> >>
> >> The Versatile Express uses a special configuration controller
> >> deeply embedded in the system motherboard FPGA to multiplex the
> >> two to three (!) display controller instances out to the single
> >> SiI9022 bridge.
> >>
> >> Set up an extra file with the logic to probe to the FPGA mux
> >> register on the system controller bus, then parse the device
> >> tree to see if there is a CLCD or HDLCD instance on the core
> >> tile (also known as the daughterboard) by looking in the
> >> root of the device tree for compatible nodes.
> >>
> >> - If there is a HDLCD on the core tile, and there is a driver
> >>    for it, we exit probe and deactivate the motherboard CLCD.
> >>    We do not touch the DVI mux in this case, to make sure we
> >>    don't break HDLCD.
> >>
> >> - If there is a CLCD on both the motherboard and the core tile
> >>    (only the CA9 has this) the core tile CLCD takes precedence
> >>    and get muxed to the DVI connector.
> >>
> >> - Only if there is no working graphics on the core tile, the
> >>    motherboard CLCD is probed and muxed to the DVI connector.
> >
> >
> > This approach seems reasonable (modulo a couple of nits below), and almost
> > certainly sufficient for most realistic uses, but I can't help wondering
> > whether it might be feasible to model the mux with its own separate
> > connector/bridge driver which could handle prioritisation of multiple inputs
> > itself (I'm pondering things like RK3288/RK3399 where the two VOPs feeding
> > into the single HDMI block looks a fair bit like the V2P-CA9 situation if
> > you squint at it).
> 
> I did look and make a brief attempt at that approach using a bridge
> device for the mux. The problem is that the scenario of daisy-chained
> brigdges isn't really there, I would have to invent the world for this,
> I added timings to the dumb VGA bridges and now what would be
> needed (as decribed by Laurent) is a timings daisy-chaining API
> so that the driver can ask the whole chain of bridges to accumulate
> timing effects and present the resulting timings.
> 
> It can be done, but it would sadly also break some implicit
> assumptions in the existing DT bindings.
> 
> I would say it is a separate task that can be looked into once we
> are migrated over to DRM.

The only thing we have for muxes is vga_switcheroo. It's most likely not
what you're looking for. drm_bridge itself is not designed for chaining
with multiple, selectable inputs. So also not what you're looking for.

What might work is if you model the mux as the drm_encoder (which can
select from which drm_crtc it gets its data), and then chain the SiI9022
as a normal drm_bridge from that. But that would tie the different
instances together rather closely. It would also move pl111 totally away
from the drm_simple_display_pipe helpers.

I didn't take any closer look at the code itself, so add lots of grainy
salt to my advice :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
