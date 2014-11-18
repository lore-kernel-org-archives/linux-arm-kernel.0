From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Nov 2014 18:00:37 +0000
Subject: [PATCH] drm/i2c: tda998x: Allow for different audio sample rates
In-Reply-To: <546B8452.6030701@arm.com>
References: <546B8452.6030701@arm.com>
Message-ID: <20141118180036.GC4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 05:39:30PM +0000, Andrew Jackson wrote:
> On HDMI, the audio data are carried across the HDMI link which is
> driven by the TDMS clock. The TDMS clock is dependent on the video pixel
> rate.
> 
> This patch sets the denominator (Cycle Time Stamp) appropriately
> allowing the driver to send audio to a wider range of HDMI sinks
> (i.e. monitors).

This is actually pointless, because we don't use "manual" CTS mode.

If the clocks for the video and audio are coherent, then you can program
both the N and CTS values to allow the sink to properly recover the
synchronous audio clock.

However, in most cases, the audio and video clocks are not coherent, and
since the recovered audio clock has to match the source audio clock, the
only way this can be done is by the TDA998x (or in fact other HDMI
encoder) to measure the audio clock rate and generate the CTS value
itself.

This is the mode we drive the TDA998x - so the programmed CTS value is
irrelevant.

See the HDMI spec, section 7.2 for a discussion about this, especially
non-coherent clocks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
