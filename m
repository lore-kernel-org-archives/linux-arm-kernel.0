From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 20:44:56 +0000
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305174232.GA3852@pengutronix.de>
 <CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
Message-ID: <20120305204456.GC3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 12:09:13PM -0600, Matt Sealey wrote:
> There is in the BSP but the BSP driver is trying to be way too fancy
> with I2S settings on the imx-ssi driver you wrote (it works well for
> AC97, but for SSI in I2S slave mode there are so many hacks upon hacks
> "they" have presented, it'd never mainline)

I'm really having a very hard time comprehending this paragraph, and
indeed much of the rest of your mail.  The lack of any context isn't
helping here...  There is what exactly in the BSP?

> codec config. In theory the playback and capture should be serialized
> by the driver, though, right? It wouldn't be possible to be a slave to

That would be *really* bad, simultaneous playback and record is very
widely used.

> the codec if it had to run the clock two different rates at the same
> time.. app1 sends a sample buffer, codec does dma, app2 requests
> capture buffer, codec does dma, they can't happen at the same time,
> maybe we are missing an important mutex or spinlock here that would
> enforce this and stop the configuration changing mid-stream.. I'm far
> from the ALSA expert though)

If the hardware has constraints on the sample rates the driver should be
telling the application about this.  For the very common case where you
need the same rate for playback and record there's framework support for
doing this, the relevant driver just needs to set the symmetric_rates
flag and the core will do everything.  Note that the ALSA APIs are racy
here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/54eaf94a/attachment.sig>
