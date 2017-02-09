From: hias@horus.com (Matthias Reichl)
Date: Thu, 9 Feb 2017 10:29:11 +0100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
In-Reply-To: <16046371-915e-6faa-0829-b0a9a07756a2@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
 <20170208185359.GA11314@camel2.lan>
 <0f96dd5e-f35b-26f5-fead-98796d11ba89@flatmax.org>
 <16046371-915e-6faa-0829-b0a9a07756a2@flatmax.org>
Message-ID: <20170209092910.GA2985@delle.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 09:48:04AM +1100, Matt Flax wrote:
> 
> On 09/02/17 08:13, Matt Flax wrote:
> >
> >
> >On 09/02/17 05:54, Matthias Reichl wrote:
> >>On Wed, Feb 08, 2017 at 06:28:35PM +0000, Mark Brown wrote:
> >>>On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:
> >>>
> >>>>      case SND_SOC_DAIFMT_CBS_CFM:
> >>>>          clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
> >>>>+    case SND_SOC_DAIFMT_CBM_CFS:
> >>>Is this fall through deliberate?
> >>>
> >>>>+    /* Default data delay to 1 bit.
> >>>>+       In I2S mode, we must have 2 channels */
> >>>>      switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> >>>>      case SND_SOC_DAIFMT_I2S:
> >>>>+        if (params_channels(params) != 2)
> >>>>+            return -EINVAL;
> >>>>+    case SND_SOC_DAIFMT_DSP_A:
> >>>>+    case SND_SOC_DAIFMT_DSP_B:
> >>>>          data_delay = 1;
> >>>>          break;
> >>>>      default:
> >>Matt, could you please include linux-rpi-kernel at lists.infradead.org
> >>in your emails?
> >I have joined that list now. It was included originally, but wasn't
> >accepting my posts.
> >>I fail to see the part where DSP modes are actually set up in
> >>the hardware. bcm2835 still seems to be operating in 2-channel
> >>stereo I2S mode, i.e. no real frame sync information at the
> >>hardware level.
> >From the SoC's perspective I agree with you. There is frame
> >synchronisation at the hardware level, implemented in an master FPGA. This
> >starts to hit at a lack of functionality in ALSA ... I will discuss more
> >below.
> >>If all you do is adding code to pretend the bcm2835 could do
> >>multichannel modes wouldn't it be easier to implement that as
> >>a userspace alsa plugin?
> >>
> >>
> >I am not familiar with how to implement all of this with a plugin ? Could
> >you give me a little hand in describing that further ? That would mean
> >that an asoundrc needs to be used to defined to make the system usable ?
> >Is it something which does the unpacking for us in user space ? If this
> >happens in user space is there extra cost/latency ?

I haven't written a plugin myself, but there are plenty of examples out
there. Maybe there's already one that does what you need.

Have a look at the code in alsa-lib
http://git.alsa-project.org/?p=alsa-lib.git;a=tree;f=src/pcm

Also have a look at how iec958 is handled in most setups (pcm_iec958
plugin, integration via /usr/share/alsa/cards/*.conf

Plugins don't necessarily add a latency overhead, I've got the impression
all you need to do is to hook into hw_params and setup the slave hw
to 2 channels and 4 times the requested samplerate.

eg when 8-channel 48kHz is requested configure the hardware to
2-channel 192kHz.

You can pass additional information to the machine driver via controls,
eg to signal that you are transmitting 8-channel PCM encapsulated in
a 2-channel stream. Again a good example is iec958, the AES channel
status bits are transferred to the card via the IEC958 Playback Default
control in the card .conf via a hook plug.

> You know, I am genuinely interested in your concept and still invite an
> example of your creativity, however ...
> The more I think about this approach, the concept of pushing the support of
> hardware into user space the more I disagree with it. My understanding is
> that the Linux Kernel is there to support hardware. The concept of pushing
> hardware support into user space doesn't seem right.
> 
> As I have pointed out below, there are missing things in ALSA and as Mark
> previously pointed out "this is a thing". What I understand is that this
> hardware is a thing and has been thought of before - this happens to be a
> hardware implementation of this "thing" which ALSA doesn't currently have
> the capacity to support (e.g. an ASIC/FPGA which is mater, not the SoC nor
> the Codec).

>From what you describe it looks to me the FPGA is just acting as a codec,
converting between 2-channel I2S and 8-channel (DSP?) at 1/4 of the I2S rate.

So you have bcm2835 I2S <-> FPGA <-> codec - IOW a standard codec<->codec
link.

What you seem to be missing is just a method to transfer your 8-channel
data via a 2-channel link - userspace want's to see an 8-channel PCM,
but the hardware link (bcm2835-i2s) is only 2-channel.

And that's where IMO as userspace plugin looks like a very good solution.
It's basically the counterpart of your FPGA and contains the code that's
neccessary to encapsulate/pack/whatever the 8-channel data into a 2-channel
stream so it can then be unpacked to 8-channel by the FPGA.

If you go this route your hardware and machine driver will work with
other I2S codecs as well, and IMO that's a far better solution than
adding very ugly hacks to a single I2S driver.

so long,

Hias

> 
> I remember back in the '90s when ALSA was started - I witnessed its birth.
> ALSA was started because of inadequacies of OSS. I truly don't believe that
> we need a new sound system for Linux as of yet. I also don't believe that
> because ALSA has these inadequacies (which I mention below) that we need to
> start afresh. I would personally put effort into this part of ALSA if I had
> the money to support myself whilst I did it - but I don't. So for now, I am
> trying to make do with ALSA as best I can. I am trying to put the necessary
> support for existing hardware into ALSA in its current state and form - in
> the best possible manner. So please lets continue with support for this
> hardware in the kernel.
> 
> >I would like to bring up another topic here.
> >
> >In my opinion some of these changes we are making in this general thread
> >are only really window dressing.
> >
> >We have 4 ways of setting up master, however all of them assume that
> >either the codec or the SoC is master. None of them allow for intermediate
> >digital logic between the two.
> >
> >In this case there is a FPGA which is matching the system differences
> >between the Codec and the SoC. In actual fact, the FPGA needs to be master
> >- a fifth mode.
> >
> >A similar problem exists when you are using a sample rate converter chip.
> >For example, the DAC and ADC are running at different sample rates. In
> >this case ALSA can't represent both of the sample rates. For that reason,
> >the ADCs and the DACs have to be hard coded - it is nasty.
> >
> >The only solution for me is to use snd_soc_dai_set_fmt in the machine
> >driver to instruct both to enter slave mode. For what it is worth, I can
> >also
> >
> >In my opinion there is nothing wrong with making hardware level
> >introductions, such as an ASIC/FPGA to implement the hardware. I accept
> >the inflexibility of ALSA w.r.t. this type of situation, however the real
> >fix is to adjust the core of ALSA. Hardware ASICS and FPGAs which are
> >intermediatries between codecs and SoCs exist and are used in industry.
> >
> >This happens to be one of those cases.
> >
> >thanks
> >Matt
> >
> >_______________________________________________
> >Alsa-devel mailing list
> >Alsa-devel at alsa-project.org
> >http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
