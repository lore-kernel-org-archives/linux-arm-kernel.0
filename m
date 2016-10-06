From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 07 Oct 2016 00:04:13 +0300
Subject: [PATCH v5 2/5] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <CAOw6vbLC=HnnpuaxFf8EzSTmuYoZd-r1aqx-ixja97Ht_U6S6Q@mail.gmail.com>
References: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
 <5319260.UeCnJXKVPe@avalon>
 <CAOw6vbLC=HnnpuaxFf8EzSTmuYoZd-r1aqx-ixja97Ht_U6S6Q@mail.gmail.com>
Message-ID: <1757833.hOePAQC2sg@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Thursday 06 Oct 2016 15:53:28 Sean Paul wrote:
> On Thu, Oct 6, 2016 at 1:27 PM, Laurent Pinchart wrote:
> > On Thursday 06 Oct 2016 17:09:57 Archit Taneja wrote:
> >> On 10/06/2016 12:51 PM, Maxime Ripard wrote:
> >>> On Mon, Oct 03, 2016 at 04:40:57PM +0530, Archit Taneja wrote:
> >>>> On 09/30/2016 08:07 PM, Maxime Ripard wrote:
> >>>>> Some boards have an entirely passive RGB to VGA bridge, based on
> >>>>> either DACs or resistor ladders.
> >>>>> 
> >>>>> Those might or might not have an i2c bus routed to the VGA connector
> >>>>> in order to access the screen EDIDs.
> >>>>> 
> >>>>> Add a bridge that doesn't do anything but expose the modes available
> >>>>> on the screen, either based on the EDIDs if available, or based on
> >>>>> the XGA standards.
> >>>>> 
> >>>>> Acked-by: Rob Herring <robh@kernel.org>
> >>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>>>> ---
> >>>>> .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  48 +++++
> >>>>> drivers/gpu/drm/bridge/Kconfig                     |   7 +
> >>>>> drivers/gpu/drm/bridge/Makefile                    |   1 +
> >>>>> drivers/gpu/drm/bridge/rgb-to-vga.c                | 229 +++++++++++++
> >>>>> 4 files changed, 285 insertions(+)
> >>>>> create mode 100644
> >>>>> Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.tx
> >>>>> t
> >>>>> create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c
> >>>>> 
> >>>>> diff --git
> >>>>> a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.
> >>>>> txt
> >>>>> b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.
> >>>>> txt
> >>>>> new file mode 100644
> >>>>> index 000000000000..a8375bc1f9cb
> >>>>> --- /dev/null
> >>>>> +++
> >>>>> b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.
> >>>>> tx
> >>>>> t @@ -0,0 +1,48 @@
> >>>>> +Dumb RGB to VGA bridge
> >>>>> +----------------------
> >>>>> +
> >>>>> +This binding is aimed for dumb RGB to VGA bridges that do not
> >>>>> require
> >>>>> +any configuration.
> >>>>> +
> >>>>> +Required properties:
> >>>>> +
> >>>>> +- compatible: Must be "rgb-to-vga-bridge"
> >>>> 
> >>>> I'd talked to Laurent on IRC if he's okay with this. And I guess you
> >>>> to had discussed it during XDC too. He's suggested that it'd be better
> >>>> to have the compatible string as "simple-vga-dac".
> >>> 
> >>> I just wished this bikeshedding had taken place publicly and be
> >>> actually part of that discussion, but yeah, ok.
> >> 
> >> Sorry about that. I'd pinged him for an Ack, the discussion went
> >> more than that :)
> >> 
> >>>> Some of the reasons behind having this:
> >>>> 
> >>>> - We don't need to specify "rgb" in the compatible string since most
> >>>> simple VGA DACs can only work with an RGB input.
> >>> 
> >>> Ok.
> >>> 
> >>>> - Also, with "dac" specified in the string, we don't need to
> >>>> specifically mention "bridge" in the string. Also, bridge is a drm
> >>>> specific term.
> >>>> 
> >>>> - "simple" is considered because it's an unconfigurable bridge, and it
> >>>> might be misleading for other VGA DACs to not use "vga-dac".
> >>> 
> >>> All those "simple" bindings are just the biggest lie we ever
> >>> told. It's simple when you introduce it, and then grows into something
> >>> much more complicated than a non-simple implementation.
> >> 
> >> "simple" here is supposed to mean that it's an unconfigurable RGB to
> >> VGA DAC. This isn't supposed to follow the simple-panel model, where
> >> you add the "simple-panel" string in the compatible node, along with
> >> you chip specific compatible string.
> > 
> > I agree with Maxime, I don't like the word "simple". My preference would
> > be "vga-dac" for a lack of a better qualifier than "simple" to describe
> > the fact that the device requires no configuration. My only concern with
> > "vga-dac" is that we would restrict usage of that compatible string for a
> > subset of VGA DACs, with more complex devices not being compatible with
> > "vga-dac" even though they are VGA DACs. That's a problem I can live with
> > though.
>
> While we're bikeshedding (feel free to ignore my input on this), I
> think Maxime's initial "dumb" qualifier was better than "simple".

I think I agree.

> I think "passive" also gets the point across better than "simple", which
> we've already established as something else in drm.

To my electrical engineer's ear, passive refers to a component or combination 
of components that is not capable of power gain. The resistors ladder VGA DAC 
that Maxime is trying to support is a passive system, but the ADV7123 VGA DAC 
that equally requires no configuration is an active component.

> Now that I've gotten that out of the way, this patch looks good to me
> regardless of the name.
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> 
> Sean
> 
> >> In other words, this driver shouldn't be touched again in the future :)
> >> If someone wants to write a RGB to VGA driver which is even
> >> slightly configurable, they'll need to write a new bridge driver.
> > 
> > I'm sure that won't be true. I can certainly foresee the addition of
> > regulators support for instance. It's unfortunately never black and white.
> > 
> >>>> What do you think about this? If you think it's good, would it be
> >>>> possible for you to change this? I guess it's okay for the rest of
> >>>> the patch to stay the same.
> >>> 
> >>> I'll update and respin the serie.

-- 
Regards,

Laurent Pinchart
