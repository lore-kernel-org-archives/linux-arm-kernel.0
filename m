From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 May 2012 12:41:22 +0100
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
In-Reply-To: <20120502105024.GC2982@b20223-02.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
 <20120501134446.GK2194@S2101-09.ap.freescale.net>
 <20120502105024.GC2982@b20223-02.ap.freescale.net>
Message-ID: <20120502114121.GB5722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 06:50:24PM +0800, Richard Zhao wrote:
> On Tue, May 01, 2012 at 09:44:48PM +0800, Shawn Guo wrote:

> > > +	data->codec_clk = clk_get(&codec_dev->dev, NULL);

> > It's a clock of sgtl5000 codec.  I feel it makes more sense to have
> > sgtl5000 device driver than machine driver to manage this clock.

> The ASoC machine driver handled the clock settings, I just followed the
> same way, using snd_soc_dai_set_sysclk to set codec clk. But what you
> said  is reasonable. I also find it's impossible to use devm_get_clk.

> Mark, do you suggest get clk in ASoC machine driver or in codec driver?

We generally try to keep the clock API out of CODEC drivers due to the
issues with the clock API that the generic implementation is intended to
help us solve.

The major problem here is that we can't rely on having the clock API
present at all on most platforms so as soon as we start adding clock
support into things we have to do a performance with HAVE_CLK which is
at best annoying.

There's also the fact that even if the clock API is available we've no
way to register a clock consistently and since the audio clock tree
often needs management off-SoC for at least some components when the
clock API is in use you end up having to handle clock trees that go into
and out of the clock API.

The upshot of this is that while we really should be using the clock API
for clocks the API as it stands is somewhat difficult to deploy in cross
platform code.  What I'd suggest is connecting the clock to the CODEC in
the device tree but actually doing the clk_get() in the machine driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120502/82d6f6ac/attachment.sig>
