From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 19:18:07 +0100
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
Message-ID: <20151006181806.GS21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 03:07:40PM -0300, Fabio Estevam wrote:
> On Sat, Aug 8, 2015 at 1:10 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Add ALSA based HDMI AHB audio driver for dw_hdmi.  The only buffer
> > format supported by the hardware is its own special IEC958 based format,
> > which is not compatible with any ALSA format.  To avoid doing too much
> > data manipulation within the driver, we support only ALSAs IEC958 LE and
> > 24-bit PCM formats for 2 to 6 channels, which we convert to its hardware
> > format.
> >
> > A more desirable solution would be to have this conversion in userspace,
> > but ALSA does not appear to allow such transformations outside of
> > libasound itself.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I applied this series, but the HDMI audio card is not registered. I
> guess I missed the dts pieces. Are the dts patches available?

Sorry, I've been out for most of the day.  There's no DT patches required.

The dw_hdmi bridge driver creates its own platform device for the audio,
which should then bind to the dw_hdmi-ahb-audio driver using normal Linux
methods.

I don't know what's wrong with your setup, for me, it just works:

[    1.358829] dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[    1.377173] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
...
[    2.851343] ALSA device list:
[    2.857364]   #0: DW-HDMI rev 0x0a, irq 21

as it always has done for me.  There's nothing special about it.

There's nothing special about it - it's a standard ALSA PCM audio driver,
it doesn't have any requirements over and above having ALSA and ALSA's PCM
support enabled.  If you didn't have those enabled, but somehow had the
dw_hdmi-ahb-audio set as built-in, you'd get a link time error, so it's
not a configuration issue.

It works for me on all iMX6 platforms (solo, dual-lite, dual and quad).

As it's a straight ALSA device, it doesn't need any codec or any of the
ASoC infrastructure either.

I guess the thing to start looking at is whether the device and driver
appear in /sys/bus/platform/{devices,drivers}/.  You should have:

/sys/bus/platform/devices/dw-hdmi-ahb-audio.0.auto 
/sys/bus/platform/drivers/dw-hdmi-ahb-audio

and obviously the latter should contain the symlink to the device.  If
that is present, then the driver has bound, and it should appear in
/proc/asound/cards.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
