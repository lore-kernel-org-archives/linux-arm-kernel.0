From: tpiepho@gmail.com (Trent Piepho)
Date: Fri, 16 Mar 2012 17:28:54 -0400
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <20120316192110.GH3158@opensource.wolfsonmicro.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
 <20120316111814.GA7860@S2101-09.ap.freescale.net>
 <20120316192110.GH3158@opensource.wolfsonmicro.com>
Message-ID: <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 3:21 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 16, 2012 at 07:18:18PM +0800, Shawn Guo wrote:
>
>> Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
>> and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?

It seems non-orthogonal to me that ESAI has esai in the name but SSI
does not have ssi.

> Alternatively if the SSI and ESAI devices are compatible enough at the
> ASoC API level (or can be identified by the driver just by looking at
> the DAI that's referenced without too much pain) the CPU DAI could just
> be linked to either type of DAI (probably with a more generic name for
> the property).
>
> But either way works fine, and obviously you're going to end up with
> more complex systems which use a completely custom binding anyway.

The ESAI and SSI hardware are totally different.  SSI gives you a
playback and a record stream in an I2S, or I2S like, interface.  A
stream is mono or stereo. ESAI has IIRC up to six output and four
inputs streams.  Each stream is in parallel on the same clock, and can
have one or more channels.  So it's sort of like six SSI devices
combined into one.  Except all the streams share a single FIFO and DMA
channel, so you can not independently turn the streams on and off in
ALSA like you could with six distinct SSI devices.  The hardware does
have the ability to turn streams on and off on the fly, but ALSA
models the device as something like a 12 channel PCM stream and
doesn't provide a way to change the hw_params on the fly between
periods.  Hence why we have a custom driver that does ugly things so
we can do this.
