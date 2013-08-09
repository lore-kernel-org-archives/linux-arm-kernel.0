From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 10:30:32 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem
In-Reply-To: <20130809110623.7bb3e7ad@armhf>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809110623.7bb3e7ad@armhf>
Message-ID: <20130809093032.GM23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 11:06:23AM +0200, Jean-Francois Moine wrote:
> On Fri, 09 Aug 2013 10:23:50 +0200
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> > we need at least two more compatibles for the audio controller found on
> > Dove and Kirkwood respectively. This is how we are going to distinguish
> > those two, e.g. Kirkwood has SPDIF in which Dove hasn't.
> 
> Sebastian,
> 
> s/has/hasn't & s/hasn't/has

No, you're both wrong.

Some Kirkwood has SPDIF recording and playback.  There are those audio
blocks which have just I2S capture and playback.  There are those which
have I2S capture and playback, and SPDIF playback.  There are those which
have both I2S and SPDIF for both capture and playback.  The only one I
haven't yet seen is SPDIF capture without playback.

> On Fri, 26 Jul 2013 10:21:56 +0100 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Fri, Jul 26, 2013 at 11:09:13AM +0200, Jean-Francois Moine wrote:
> > > The A510 documentation uses the names "DCO PLL" for the internal clock
> > > and "AU_EXTCLK" for the external clock. So, what about "dcopll" and
> > > "extclk"?
> > 
> > Stop naming them according to their source.  Their _consumer_ names
> > not _source_ names.
> 
> But Russell did not tell clearly which name could be the best.
> 
> BTW, as we are naming the clocks, the 'clk' in "xxxclk" seems redondant...

"extclk" follows what's in the data sheet - the exact name of it is
"AU_EXTCLK".  Since we already know that this is the audio unit from
the struct device, the "AU_" part is redundant.  The input name for
the internal clock is not given, instead they talk about where it
comes from (it's producer) so your choice of "internal" is fine.

Take a moment to think about it: if you call it "dcoclk" then what
happens on a future SoC if it's not connected to the dcoclk anymore?

> I don't think that we need any reference to the codec here. The glue is
> done by the audio device. For example, using the (soon?) extended
> simple audio card:
> 
> 	spdif: spdif {
> 		compatible = "linux,spdif-dit";
> 	};
> 	sound {
> 		compatible = "linux,simple-audio";
> 		audio-controller = <&i2s1>;
> 		audio-codec = <&spdif>;
> 		codec-dai-name = "dit-hifi";
> 	};

As I understand the way DPCM works, that isn't going to work for this
case.  For DPCM as per Liam's example, it's going to require the audio
controller to be bound to the dummy codec, and a dummy platform/dai
bound to the SPDIF codec.  You then use DAPM routing to connect the
SPDIF codec to the appropriate CPU DAI output stream.

So the above "simple" implementation won't do - it can't be used to
specify two DAI links, and it can't specify the DAPM routing between
them.

This will be another challenge to solve in DT!
