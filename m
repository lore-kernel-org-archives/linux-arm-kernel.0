From: hias@horus.com (Matthias Reichl)
Date: Mon, 27 Feb 2017 09:04:34 +0100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
Message-ID: <20170227080433.GA2718@delle.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 09:35:14AM +1100, Matt Flax wrote:
> 
> 
> On 27/02/17 09:16, Matthias Reichl wrote:
> >On Mon, Feb 27, 2017 at 07:21:13AM +1100, Matt Flax wrote:
> >>
> >>On 27/02/17 01:49, Matthias Reichl wrote:
> >>>On Sun, Feb 26, 2017 at 09:13:09AM +1100, Matt Flax wrote:
> >>>>On 26/02/17 00:39, Matthias Reichl wrote:
> >>>>>On Sat, Feb 25, 2017 at 04:03:11PM +1100, Matt Flax wrote:
> >>>>>>This patch set lets the ASoC system specify that an IC between the SoC and codec
> >>>>>>is master. This is intended to put both the SoC and Codec into slave modes.
> >>>>>>
> >>>>>>By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
> >>>>>>enabled and tested for this mode.
> >>>>>>
> >>>>>>soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
> >>>>>>#define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */
> >>>>>>
> >>>>>>The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
> >>>>>>SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
> >>>>>>where the IC is bit and frame master.
> >>>>>Model your IC as a codec. No need to add patches to random drivers
> >>>>>and add a flag with the rather meaningless semantics "someone else is
> >>>>>automagically setting up clocks for me".
> >>>>>
> >>>>>
> >>>>My last patch, used the two codec approach, however it was pointed out that
> >>>>the
> >>>>bcm2835 was run in DSP mode with a codec master (rather then IC master) and
> >>>>that
> >>>>the patch doesn't work. Which is clearly true and a problem, it can only
> >>>>work with an
> >>>>intermediate non-codec master.
> >>>>
> >>>>I think you summed it up well with your statement :
> >>>>
> >>>>On 25/02/17 Matthias Reichl wrote:
> >>>>If the clock timing adheres to DSP mode A timing and you add code
> >>>>to the the CPU DAI driver so it can operate in DSP mode A then
> >>>>that should also work. If not, it's broken.
> >>>Your bcm2835 patch doesn't configure the bcm2835 to DSP mode A,
> >>>it's still setup for I2S (slave) mode. You are just adding code
> >>>to pretend it's running in DSP mode A. Don't do that, it's wrong.
> >>All configuration is done in a machine driver, which I haven't submitted.
> >>The machine driver's dai_fmt is as follows :
> >>
> >>.dai_fmt = SND_SOC_DAIFMT_IBM_IFM|SND_SOC_DAIFMT_DSP_A|SND_SOC_DAIFMT_NB_NF,
> >>
> >>>>This patch set fixes the problem of a daisy chain of three possible masters
> >>>>(CPU <=> IC <=> codec) where only the IC can be master. In fact, when retro
> >>>>fitting DSP mode to old silicon, the CPU can specify which of the three can
> >>>>be masters
> >>>>and there is no chance that someone can fire the system up with the wrong
> >>>>master
> >>>>(which we know produces bit offset and random channel swapping when a codec
> >>>>is
> >>>>master).
> >>>Please follow the advice I gave you about 3 weeks ago and model your
> >>>setup properly.
> >>>
> >>>| So you have bcm2835 I2S <-> FPGA <-> codec - IOW a standard codec<->codec
> >>>| link.
> >>>|
> >>>| What you seem to be missing is just a method to transfer your 8-channel
> >>>| data via a 2-channel link - userspace want's to see an 8-channel PCM,
> >>>| but the hardware link (bcm2835-i2s) is only 2-channel.
> >>>|
> >>>| And that's where IMO as userspace plugin looks like a very good solution.
> >>>| It's basically the counterpart of your FPGA and contains the code that's
> >>>| neccessary to encapsulate/pack/whatever the 8-channel data into a 2-channel
> >>>| stream so it can then be unpacked to 8-channel by the FPGA.
> >>>|
> >>>| If you go this route your hardware and machine driver will work with
> >>>| other I2S codecs as well, and IMO that's a far better solution than
> >>>| adding very ugly hacks to a single I2S driver.
> >>>
> >>>If you add an active hardware component (your "IC"/FPGA) you also
> >>>have to model that in software.
> >>>
> >>>If that component is acting as a clock master it probably has some
> >>>method to setup clocks. Even if you don't have that, eg if you
> >>>are running at some fixed rate you'll have to store that information
> >>>somewhere.
> >>Clocks are set up in the machine driver as well.
> >>
> >>>The place to do that is in a codec driver. In your setup it'll look
> >>>like this:
> >>>
> >>>That "IC" codec has 2 DAIs and operates as a clock master on both.
> >>>You link one DAI in I2S mode to the bcm2835 and the other DAI
> >>>in DSP (or whatever mode you are using) to the cs42xx8.
> >>>
> >>>If you model it this way you no longer work against ALSA and
> >>>you can stop adding hacks to existing drivers.
> >>>
> >>>
> >>Thanks, this is actually very constructive advice. Let me try to understand
> >>what
> >>you are suggesting here... I am confused about how to set bit depth
> >>correctly for
> >>the codec when I play to the IC chip in this setup... lets walk me through
> >>this one...
> >>
> >>I implement a new codec which matches this IC. The IC can be setup to be
> >>master in
> >>its dai fmt. The sound card shows up with two devices, only the IC device
> >>can be used to play
> >>and record.
> >Actually you don't get 2 PCMs from that in userspace, you are only
> >telling ALSA that your stream is routed through another codec inbetween.
> >
> >>Say I use aplay to play to the first device (the IC chip) it does hw_params
> >>and clocks are set.
> >>But the second device (the codec) never gets hw_params executed ? If I
> >>select 16 or 24 bits,
> >>it never knows ... is that right ? If so, how do we solve this problem ?
> >Have a look at the end of Documentation/sound/alsa/soc/DPCM.txt
> >where codec<->codec links are explained.
> >
> >You can setup the stream parameters for the "IC"<->"real codec" link
> >with snd_soc_dai_link.params.
> >
> >You can do that for example in your machine driver in hwparams:
> >when hw_params is called eg with 2 channels 192kHz just set the
> >dai link parameters of the codec to 8 channels 48kHz.
> >
> >Maybe using dynamic pcm (which offers a be_hw_params_fixup hook)
> >is the more appropriate way to do that, but I can't tell for sure
> >as I never used it and am not familiar with it.
> >
> >
> 
> Thanks for this information, I will give this a go - seems a better way now
> then introducing an IC master into the mix !
> 
> Do you agree that we still need the BCM2835 SoC CPU driver to be expanded to
> handle DSP mode
> and multichannel setups ? I can't see any other way to enable the
> multichannel hardware setup without altering bcm2835_i2s.c to handle DSP
> mode and more then 2 channels in its _hw_params.

No, DSP mode and multichannel don't work on the BCM2835. Keep the driver
as it is.

Use the alsa plugin approach to tunnel multichannel data over a 2-channel
PCM and you don't need to modify existing drivers.

so long,

Hias
> 
> thanks
> Matt
