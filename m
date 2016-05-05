From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 5 May 2016 18:39:32 +0800
Subject: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
In-Reply-To: <572B0511.80701@gmail.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
 <20160504164306.GA6292@sirena.org.uk>
 <1462416342.25179.36.camel@mtksdaap41> <572B0511.80701@gmail.com>
Message-ID: <1462444772.2873.70.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-05-05 at 10:32 +0200, Matthias Brugger wrote:
> 
> On 05/05/16 04:45, Garlic Tseng wrote:
> > On Wed, 2016-05-04 at 17:43 +0100, Mark Brown wrote:
> >> On Fri, Apr 29, 2016 at 09:00:42PM +0800, Garlic Tseng wrote:
> >>
> >>>   .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     | 488 ++++++++++-----------
> >>
> >> So there's going to be no code sharing at all between this and any other
> >> Mediatek chips?  That seems very surprising, it'd suggest that the
> >> hardware designers were creating a new design completely from scratch
> >> each time which doesn't seem all that likely.  This is an unusual way of
> >> organizing things and we need a much clearer explanation of what's going
> >> on here.
> >
> > MT8173 and MT2701 are from different product lines so the register
> > control sequences are very different. If another driver for 8173-like
> > (or 2701-like) chip go upstream it shall share some common code with the
> > relatively driver indeed. However I think MT8173 and MT2701 can't share
> > the platform driver or a lot of "if MT8173 else MT2701" will mess up the
> > code.
> >
> 
> What about the other SoCs we have some minimal support for: mt6589, 
> mt8135, mt6592, mt6580, mt7323, mt8127?
> 
> A quick glance at the datasheets showed me, that mt6589 and at least 
> mt8127 have quite similar register offsets. So I suppose there is some 
> common code actually.

Well, the last ASoC driver only support mt8173, and we try to add the
support for mt2701. As I mentioned, the ASoCs of the two chips have very
different control sequence, so make the platform driver common will mess
up the code. If there are some chips we want to support in the future
and the ASoC part is similar with mt8173 (or mt2701), then it shall
share some common code with the relative driver.

The ASoC hardwares has lots of differences between mt8173 and mt2701.

Mt8173 only support 2ch memory interface, whereas mt2701 has different
hardware to support four memory interface, which can group together as a
8-ch memory interface, separate as four 2-ch memory interfaces, or
function as one 4-ch memory interface and two 2-ch memory interfaces.
That makes the control sequence different and the FE dais can't share.

Mt8173 only support 2ch i2s playback/capture separately, but mt2701 has
different i2s hardware so that four i2s can sync together to preform 8ch
playback/capture. Same as the memory interface, the i2s can separate as
2ch i2s and works simultaneously. The i2s hardware has a limitation that
when i2s-in enable, i2s-out must be enable to function well. The i2s
hardware is so different that we can't share BE-dai code.

The connection between FE and BE also differ between the two chips.
Mt2701 has much more port then mt8173. However mt2701 can still fit in
DAPM structure (just control a register bit to connect/disconnect two
ports).

The irq and the clock are also different. Mt2701 support higher rate irq
than mt8173; mt2701 has too many memory interface so it needs to
dynamically request irq when needed; the clock structure also different
between them.

As mentioned above, the difference of the ASoCs between the two chips
are too large that we have a hard time sharing the driver code.

> Regards,
> Matthias
