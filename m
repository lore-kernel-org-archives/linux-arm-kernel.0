From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 13:36:50 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007140327.5bb4863b@armhf>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
 <20131007110902.GL12758@n2100.arm.linux.org.uk>
 <20131007140327.5bb4863b@armhf>
Message-ID: <20131007123650.GN12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 02:03:27PM +0200, Jean-Francois Moine wrote:
> On Mon, 7 Oct 2013 12:09:02 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > > Here is a small story about i2s/spdif: once, I set the tda998x to use
> > > the spdif input, and at this time, I was using the dummy codec.
> > > This codec accepts the format 32_LE, as does the audio device, but the
> > > output cannot go to spdif. Result: no hdmi sound.  
> > 
> > How ASoC works in this regard is that the capabilities are the _union_ of
> > the codec and the cpu DAIs.
> > 
> > The SPDIF transmitter codec supports 16, 20 and 24 bits per sample but not
> > 32.  Quite simply, that's because the SPDIF format does not allow 32-bits
> > per sample.  Therefore, 32_LE is not available for use with audio output,
> > and userspace must convert down to something which the hardware does
> > support.
> > 
> > "Because I2S can support 32-bit audio" is a poor reason, because you can't
> > pass 32-bit audio via HDMI due to a subframe being limited to 28 bits - up
> > to 24 bits for the sample and 4 bits of control/status information.
> 
> OK. So, to resume, if both i2s and spdif are furnished by the audio
> subsystem, the tda998x must use spdif only (with the spdif codec).

This is going off-topic because the TDA998x bindings are a subject for
the TDA998x driver, not the Armada driver.  This data structure merely
exists to provide the required data for the TDA998x in absence of DT
information.

To do the job properly - which is what should be done _whenever_ DT
bindings are being considered - you have to look at the hardware with
an overview of its capabilities, never at the implementation.

So, the TDA998x family needs to be looked at in isolation, and its DT
bindings need to be considered on its own merit.

The TDA998x can accept a SPDIF signal on a single pin (on AP6), with or
without a clock (on AP5), or it can accept I2S: I2S clock in APCLK, I2S
word select on AP0, and up to four I2S streams on AP1..4 and auxillary
("internal test") data in AP7.  AP7 should therefore not be used.

The TDA19988 is slightly different, because it doesn't have soo many
AP pins.  Here, SPDIF can be supplied on either AP1 or AP2 with the
optional clock on AP3.  I2S is similar to the above but only AP1 and
AP2 accept streams.

I think the I2S is a special case - I'm not aware of anything which
outputs _four_ synchronised I2S data streams with a common word select.
Nevertheless, it's something that needs to be considered when creating
DT bindings.

So, we have some quite different capabilities depending on the device.
For I2S, we can get away with this:

	tda998x {
		compatible = "nxp,tda19988", "nxp,tda998x";
		i2s-source = <&i2s_source N>;
	};

where N is the number of coherent I2S streams supplied.  For the TDA998x,
N can be 1 to 4.  For TDA19988, N can be 1 or 2 but no more.

For SPDIF, the situation is more complex.  The TDA19988 could in theory
have two streams connected, and one of those streams can be selected.
So, maybe:

	tda998x {
		compatible = "nxp,tda998x";
		spdif-source = <&spdif_source>;
		spdif-has-mclk;
	};

and for the 19988:

	tda19988 {
		compatible = "nxp,tda19988";
		spdif0-source = <&spdif_source0>;
		spdif0-has-mclk;
		spdif1-source = <&spdif_source1>;
		spdif1-has-mclk;
	};

> Also, from your video swap explanation, the DT will contain some video
> property(ies) TBD.

The TDA998x needs some properties to define how it is connected to the
rest of the hardware - which pins are connected to what in terms of the
colour channel information.  As I hope I've made clear to you, this has
no bearing on the settings in the Dove for the SWAPRB bits.  This is
purely only to do with the TDA998x.

So, this also needs to be presented as properties for the TDA998x driver.

> The remaining question is: do we need more audio parameters?
> 
> - the audio_cfg value is defined by i2s/spdif (3 or 4)

This should be discovered from the DT binding information, because which
AP pins get used depends on the signals being supplied to it.

> - the audio_frame[1] value is always 1 (2 channels)
> - audio_sample_rate is useless

audio_sample_rate comes in if we wish to use a fixed sample rate and
have coherent video and audio clocks derived from a common source.  That
allows fixed CTS and N values to be used based on the audio sample rate
being supplied as the clocks have a fixed known relationship (and aren't
going to drift.)

However, you are right that this should not be specified in DT - it
should come from the audio subsystem.  However, that's something which
is a very very long way away from being possible (if ever) with Linux
since I don't see the DPCM issues ever getting resolved.
