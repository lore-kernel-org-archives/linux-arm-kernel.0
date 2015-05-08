From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 May 2015 14:27:01 +0100
Subject: [alsa-devel] [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <34627ba55428fd0dd821d99a5326e451@kapsi.fi>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <34627ba55428fd0dd821d99a5326e451@kapsi.fi>
Message-ID: <20150508132701.GJ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 04:16:08PM +0300, Jyri Sarha wrote:
> On 2015-04-02 12:22, Russell King wrote:
> >+static const unsigned int eld_rates[] = {
> >+	32000,
> >+	44100,
> >+	48000,
> >+	88200,
> >+	96000,
> >+	176400,
> >+	192000,
> >+};
> >+
> 
> For what I can see, you are setting the cross dependency between
> the sample rate and channels incorrectly.

There is a dependency between sample rate and channels.

> You should look for the
> currently tested channel count directly from hw params.

I'm not so sure that's right after looking at snd_ac97_pcm_double_rate_rules().
That's pretty much the same problem - AC'97 codecs can operate at a
sample rate of either the bus frame frequency or twice the bus frame
frequency.

They achieve twice the bus frame frequency by reallocating a couple
of the PCM data slots which would otherwise be used for >2 channels
to the first two channels, thus allowing two front channel samples
per frame.

AC'97 limits the number of channels to two if:

        if (rate->min > 48000) {

and limits the sample rate to 1-48kHz if:

        if (channels->min > 2) {

> From this side the dependency is missing all together.

Yes, it I initially couldn't work out how to do that bit... but I have
a solution now which seems to sort-of work.

Testing with aplay, I find that it seems to mostly work, and I guess
that:

	aplay -D hw:0,0 -v -f S24_LE -c 6 -r 192000 /dev/zero

resulting in:

Playing raw data '/dev/zero' : Signed 24 bit Little Endian, Rate 192000 Hz, Channels 6
Warning: rate is not accurate (requested = 192000Hz, got = 48000Hz)
         please, try the plug plugin
Hardware PCM card 0 'DW-HDMI' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S24_LE
  subformat    : STD
  channels     : 6
  rate         : 48000
  exact rate   : 48000 (48000/1)

is acceptable.

Also looking at AC'97, I don't need to list the same parameter as a
dependent of the rule... something I'll try when I'm back from the
hospital later this afternoon...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
