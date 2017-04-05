From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 5 Apr 2017 09:55:53 -0400
Subject: [RFC] [media] imx: assume MEDIA_ENT_F_ATV_DECODER entities output
 video on pad 1
In-Reply-To: <1491384859.2381.51.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1490894749.2404.33.camel@pengutronix.de>
 <20170404231053.GE7909@n2100.armlinux.org.uk>
 <19f0ce92-cad6-8950-8018-e3224e2bf266@gmail.com>
 <7235285c-f39a-64bc-195a-11cfde9e67c5@gmail.com>
 <20170405082134.GF7909@n2100.armlinux.org.uk>
 <1491384859.2381.51.camel@pengutronix.de>
Message-ID: <CABxcv=kaLgk7BoqPoU=yhzMWsuXmRZQVF6oa2EdandX6UmZ0hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

On Wed, Apr 5, 2017 at 5:34 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Wed, 2017-04-05 at 09:21 +0100, Russell King - ARM Linux wrote:

[snip]

> I think the output part is accurate, as the audio pad is an artifact of
> an unrelated change. I'm not so sure about the VBI pad, but I think that
> shouldn't exist either. The input pad, on the other hand, not having any
> of graph representation in the device tree seems a bit strange. There

Agreed, there should be a OF graph representation (and also a MC
representation) of the input PADs.

The tvp5150 driver currently has hardcoded as input TVP5150_COMPOSITE1
(AIP1B), so it won't work for a board that has the composite connector
wired to TVP5150_COMPOSITE0 (AIP1A) neither will work for S-Video
(AIP1A + AIP1B).

> was a custom binding for the inputs, that got quickly reverted:
> https://patchwork.kernel.org/patch/8395521/
>

Yes, that was my first attempt to have input connector support for
tvp5150. The patches were merged without a detailed review of the DT
bindings and latter were found to be wrong. Instead of having a driver
specific DT binding, a generic binding that could be used by any
device should be defined.

The latest proposal was [0] but that was also found to be inadequate.
After a lot of discussion on #v4l, the best approach we could come
with was something like like [1]. But I was busy with other stuff and
never found time to do the driver changes.

By the way, only the DT bindings portion from the first approach got
reverted but the patch reverting the driver changes never made to
mainline. Could you please test if [2] doesn't cause any issues to you
so the left over can be finally removed?

> regards
> Philipp
>

[0]: https://lkml.org/lkml/2016/4/12/983
[1]: https://hastebin.com/kadagidino.diff
[2]: https://patchwork.kernel.org/patch/9472623/

Best regards,
Javier
