From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 21 Jan 2016 14:24:07 +0000
Subject: Problem with commit 924eb47512 ("ASoC: dwc: fix dma stop
 transferring issue")
Message-ID: <1453386247.2858.58.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

In trying to work out why audio stopped working on ARM's Juno board I
bisected the problem to $subject commit and reverting this fixed things.
The symptoms of broken audio was that alsa-utils' speaker-test produced
very short duration 'churps' rather than the voice sample naming each
speaker channel. (Additional note, audio on Juno is routed through a
HDMI transmitter and the patches to support that aren't in the mainline
kernel tree.)

Now, I don't have any documentation for the Designware I2S device so the
following is my speculation from looking at the code and guessing what's
going on...

1. $subject patch makes i2s_start() unmask interrupts for all four
hardware channels. 

2. i2s_stop masks interrupts for all four channels.

3. dw_i2s_hw_params unmasks interrupts for only the number of hardware
channels as required for the specified audio stream format.

So, playing stereo sound (one hardware channel) on my Juno board is
going wrong because i2s_start() now unmasks interrupts for the other 3
unused hardware channels and these are immediately generating
interrupts, making the code think the buffer has finished transmission
(or underflowed, or something like that, remember I'm speculating here).

Now, if audio playback/capture is always achieved by using this sequence
of calls:

dw_i2s_hw_params
i2s_start
i2s_stop

then it seems to me that $subject patch is redundant and should be
reverted. However, if this is allowed (possibly is, depends on how
dw_i2s_trigger can be called) ...

dw_i2s_hw_params
i2s_start
i2s_stop
i2s_start
i2s_stop

then we need to change i2s_start to unmask interrupts for just the
hardware channels being used. I can have a go at producing a patch for
that if that's deemed the correct solution. (Looks like we'd need to
stash the number of used hardware channels in struct dw_i2s_dev).

-- 
Tixy
