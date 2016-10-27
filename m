From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Oct 2016 16:25:03 +0200
Subject: [RFC PATCH 0/5] Add an overlay manager to handle board capes
In-Reply-To: <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
Message-ID: <20161027142503.qelefwobjl4nqn3r@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Oct 27, 2016 at 08:41:56AM -0500, Rob Herring wrote:
> Please Cc the maintainers of drivers/of/.
> 
> + Frank R, Hans, Dmitry S

Yes, sorry for that.

> On Wed, Oct 26, 2016 at 9:57 AM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> >
> > Many boards now come with dips and compatible capes; among others the
> > C.H.I.P, or Beaglebones. All these boards have a kernel implementing an
> > out-of-tree "cape manager" which is used to detected capes, retrieve
> > their description and apply a corresponding overlay. This series is an
> > attempt to start a discussion, with an implementation of such a manager
> > which is somehow generic (i.e. formats or cape detectors can be added).
> > Other use cases could make use of this manager to dynamically load dt
> > overlays based on some input / hw presence.
> 
> I'd like to see an input source be the kernel command line and/or a DT
> chosen property.

We now have overlay support in U-Boot so we could modify the device tree
from the bootloader and not use the command line. But you can argue the
boot loader can't always be upgraded (to support overlays, or to improve
it). So I guess we can think of using the command line as a input
source.

> Another overlay manager was proposed not to long ago[1] as well.

Thanks for the hint.

> Another thing to consider is different sources of overlays. Besides in
> the filesystem, overlays could be built into the kernel (already
> supported), embedded in the dtb (as the other overlay mgr did) or we
> could extend FDT format to append them.

Sure. Using this series it should be quite easy to support other
sources. We would need to improve the function loading the overlay, to
try other sources. This could even comes in following up patches.

> > The proposed design is a library which can be used by detector drivers
> > to parse headers and load the corresponding overlay. Helpers are
> > provided for this purpose. The whole thing is divided into 3 entities:
> >
> > - The parser which is project-specific (to allow supporting headers
> >   already into the wild). It registers a function parsing an header's
> >   data and filling one or more strings which will be used to find
> >   matching dtbo on the fs.
> >
> > - The overlay manager helpers allowing to parse a header to retrieve
> >   the previously mentioned strings and to load a compatible overlay.
> >
> > - The detectors which are used to detect capes and get their description
> >   (to be parsed).
> 
> What about things like power has to be turned on first to detect
> boards and read their ID? I think this needs to be tied into the
> driver model. Though, don't go sticking cape mgr nodes into DT. Maybe
> a driver gets bound to a connector node, but we've got to sort out
> connector bindings first.

Right. I don't know yet how to handle this. Do you have an existing
example in mind of such a power requirement?

> > An example of parser and detector is given, compatible with what's done
> > for the C.H.I.P. As the w1 framework is really bad (and we should
> > probably do something about that) the detector code is far from being
> > perfect; but that's not related to what we try to achieve here.
> >
> > The actual implementation has a limitation: the detectors cannot be
> > built-in the kernel image as they would likely detect capes at boot time
> > but will fail to get their corresponding dt overlays as the fs isn't
> > mounted yet. The only case this can work is when dt overlays are
> > built-in firmwares. This isn't an issue for the C.H.I.P. use case right
> > now. There was a discussion about making an helper to wait for the
> > rootfs to be mount but the answer was "this is the driver's problem".
> 
> I thought there are firmware loading calls that will wait. I think
> this all needs to work asynchronously both for firmware loading and
> because w1 is really slow.

There is an asynchronous one, but it will also fail if the rootfs isn't
mounted yet.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/30ab5fd8/attachment-0001.sig>
