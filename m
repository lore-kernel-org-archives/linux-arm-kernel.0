From: hias@horus.com (Matthias Reichl)
Date: Sat, 25 Feb 2017 00:02:00 +0100
Subject: [alsa-devel] [PATCH v8] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
In-Reply-To: <501e4af5-51b7-c124-4a29-ef5804d8a03c@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
 <20170224121832.GA19227@camel2.lan>
 <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
 <20170224202553.GA28529@camel2.lan>
 <501e4af5-51b7-c124-4a29-ef5804d8a03c@flatmax.org>
Message-ID: <20170224230159.GA30456@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 08:30:03AM +1100, Matt Flax wrote:
> 
> 
> On 25/02/17 07:25, Matthias Reichl wrote:
> 
> >I'd put it in another way: it seems to me that the bcm2835 I2S
> >won't reliably sync in DSP mode A.
> >
> >
> 
> What you are explaining here is the nature of the BCM2835 responding to a
> codec master. The hardware setup you are describing is elegantly simple, but
> TOO simple.

Your patch only changes the CPU DAI driver. At this point it doesn't
matter if the codec or an external source is driving the clocks.

If the clock timing adheres to DSP mode A timing and you add code
to the the CPU DAI driver so it can operate in DSP mode A then
that should also work. If not, it's broken.

The (rather brief) publically available bcm2835 datasheet only
mentions I2S mode and my tests lead me to the conclusion that the
bcm2835 is actually expecting I2S timing, not DSP A - at least with
the current code.

> Measurements on a system which uses a codec master don't represent a robust
> implementation of multichannel with the BCM2835. My experiments (and now
> yours) have shown that the system has a bit shift and an uncontrollable
> channel drift.
> 
> Multichannel simply can't be done (on the BCM2835) without control at the
> hardware level - this requires an intermediate master control chip.
>
> The Audio Injector Octo machine driver, sets both the codec and the BCM2835
> as slaves - the FPGA is master because it has to control both the BCM2835
> and the codec's systems to get reliability. You can see the machine driver
> on github :
> https://github.com/flatmax/linux/blob/rpi-4.4.y/sound/soc/bcm/audioinjector-octo-soundcard.c
> 
> It has taken month to implement a robust solution to this problem using an
> FPGA and the result is a fantastic (Audio Injector Octo) sound card. I am
> almost certain this hardware technique can be used on all stereo I2S SoC
> chips.

Can you please provide details about the timing / protocol you are
actually using?

so long,

Hias

> 
> 
> Matt
> 
