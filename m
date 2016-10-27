From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Oct 2016 08:41:56 -0500
Subject: [RFC PATCH 0/5] Add an overlay manager to handle board capes
In-Reply-To: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
Message-ID: <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please Cc the maintainers of drivers/of/.

+ Frank R, Hans, Dmitry S

On Wed, Oct 26, 2016 at 9:57 AM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Hi all,
>
> Many boards now come with dips and compatible capes; among others the
> C.H.I.P, or Beaglebones. All these boards have a kernel implementing an
> out-of-tree "cape manager" which is used to detected capes, retrieve
> their description and apply a corresponding overlay. This series is an
> attempt to start a discussion, with an implementation of such a manager
> which is somehow generic (i.e. formats or cape detectors can be added).
> Other use cases could make use of this manager to dynamically load dt
> overlays based on some input / hw presence.

I'd like to see an input source be the kernel command line and/or a DT
chosen property. Another overlay manager was proposed not to long
ago[1] as well. There's also the Allwinner tablet use case from Hans
where i2c devices are probed and detected. That's not using overlays
currently, but maybe could.

Another thing to consider is different sources of overlays. Besides in
the filesystem, overlays could be built into the kernel (already
supported), embedded in the dtb (as the other overlay mgr did) or we
could extend FDT format to append them.

> The proposed design is a library which can be used by detector drivers
> to parse headers and load the corresponding overlay. Helpers are
> provided for this purpose. The whole thing is divided into 3 entities:
>
> - The parser which is project-specific (to allow supporting headers
>   already into the wild). It registers a function parsing an header's
>   data and filling one or more strings which will be used to find
>   matching dtbo on the fs.
>
> - The overlay manager helpers allowing to parse a header to retrieve
>   the previously mentioned strings and to load a compatible overlay.
>
> - The detectors which are used to detect capes and get their description
>   (to be parsed).

What about things like power has to be turned on first to detect
boards and read their ID? I think this needs to be tied into the
driver model. Though, don't go sticking cape mgr nodes into DT. Maybe
a driver gets bound to a connector node, but we've got to sort out
connector bindings first.

> An example of parser and detector is given, compatible with what's done
> for the C.H.I.P. As the w1 framework is really bad (and we should
> probably do something about that) the detector code is far from being
> perfect; but that's not related to what we try to achieve here.
>
> The actual implementation has a limitation: the detectors cannot be
> built-in the kernel image as they would likely detect capes at boot time
> but will fail to get their corresponding dt overlays as the fs isn't
> mounted yet. The only case this can work is when dt overlays are
> built-in firmwares. This isn't an issue for the C.H.I.P. use case right
> now. There was a discussion about making an helper to wait for the
> rootfs to be mount but the answer was "this is the driver's problem".

I thought there are firmware loading calls that will wait. I think
this all needs to work asynchronously both for firmware loading and
because w1 is really slow.

> I'd like to get comments, specifically from people using custom cape
> managers, to see if this could fill their needs (with I guess some
> modifications).

Having 2 would certainly give a better sense this is generic.

Rob

[1] https://patchwork.ozlabs.org/patch/667805/
