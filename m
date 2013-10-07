From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 14:03:27 +0200
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007110902.GL12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
Message-ID: <20131007140327.5bb4863b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013 12:09:02 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > Here is a small story about i2s/spdif: once, I set the tda998x to use
> > the spdif input, and at this time, I was using the dummy codec.
> > This codec accepts the format 32_LE, as does the audio device, but the
> > output cannot go to spdif. Result: no hdmi sound.  
> 
> How ASoC works in this regard is that the capabilities are the _union_ of
> the codec and the cpu DAIs.
> 
> The SPDIF transmitter codec supports 16, 20 and 24 bits per sample but not
> 32.  Quite simply, that's because the SPDIF format does not allow 32-bits
> per sample.  Therefore, 32_LE is not available for use with audio output,
> and userspace must convert down to something which the hardware does
> support.
> 
> "Because I2S can support 32-bit audio" is a poor reason, because you can't
> pass 32-bit audio via HDMI due to a subframe being limited to 28 bits - up
> to 24 bits for the sample and 4 bits of control/status information.

OK. So, to resume, if both i2s and spdif are furnished by the audio
subsystem, the tda998x must use spdif only (with the spdif codec).

Then, the declaration of the tda998x in the DT will include an
optional audio property, say 'audio-input' with the values "i2s" or
"spdif" which corresponds to your parameter 'audio_format'.

Also, from your video swap explanation, the DT will contain some video
property(ies) TBD.

The remaining question is: do we need more audio parameters?

- the audio_cfg value is defined by i2s/spdif (3 or 4)
- the audio_frame[1] value is always 1 (2 channels)
- audio_sample_rate is useless

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
