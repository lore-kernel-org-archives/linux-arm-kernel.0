From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 28 Feb 2017 10:10:10 +0000
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
Message-ID: <20170228101010.GI2742@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 07:21:13AM +1100, Matt Flax wrote:
> On 27/02/17 01:49, Matthias Reichl wrote:
> >On Sun, Feb 26, 2017 at 09:13:09AM +1100, Matt Flax wrote:
> >>On 26/02/17 00:39, Matthias Reichl wrote:
> >>>On Sat, Feb 25, 2017 at 04:03:11PM +1100, Matt Flax wrote:
> >The place to do that is in a codec driver. In your setup it'll look
> >like this:
> >
> >That "IC" codec has 2 DAIs and operates as a clock master on both.
> >You link one DAI in I2S mode to the bcm2835 and the other DAI
> >in DSP (or whatever mode you are using) to the cs42xx8.
> >
> >If you model it this way you no longer work against ALSA and
> >you can stop adding hacks to existing drivers.
> >
> >
> Thanks, this is actually very constructive advice. Let me try to understand
> what
> you are suggesting here... I am confused about how to set bit depth
> correctly for
> the codec when I play to the IC chip in this setup... lets walk me through
> this one...
> 
> I implement a new codec which matches this IC. The IC can be setup to be
> master in
> its dai fmt. The sound card shows up with two devices, only the IC device
> can be used to play
> and record.
> 
> Say I use aplay to play to the first device (the IC chip) it does hw_params
> and clocks are set.
> But the second device (the codec) never gets hw_params executed ? If I
> select 16 or 24 bits,
> it never knows ... is that right ? If so, how do we solve this problem ?

Yeah I think there are basically two ways you could model this
sort of setup, either with a CODEC to CODEC link as suggested
here or a DPCM setup.

The CODEC to CODEC link is probably the better model for the
system as that is really the direction people are trying to
take things within ASoC, however at the moment being a CODEC to
CODEC link does impose some restrictions, you have to basically
specify fixed parameters for the link in the machine driver. You
can specify multiple parameters and an ALSA control will be
created to switch between them, however this does require user
involvement.

I am interested you mention the bit depth but not the sample rate
which is often the bigger problem? Probably the easiest solution
here assuming you don't have sample rate issues, is just to have
the link between your FPGA and the CODEC always be 24bit and just
have the FPGA insert padding if the link on the other side is
16bit.

Alternatively you could look at implementing this as DPCM,
although I am not the greatest fan of it. That would let you
fix up the settings before they are passed to the CODEC, but
leaves the FPGA part relatively unmodelled and would likely be
implicitly supported in the machine driver.  Really DPCM is more
normally used to model hardware that is an actual part of the SoC
so this case does feel slightly abusive.

Thanks,
Charles
