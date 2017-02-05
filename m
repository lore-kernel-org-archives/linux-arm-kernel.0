From: broonie@kernel.org (Mark Brown)
Date: Sun, 5 Feb 2017 17:34:51 +0100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Increase channels_max to 8
In-Reply-To: <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
 <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
Message-ID: <20170205163451.4x3svwbqdqlfc7t4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2017 at 12:26:31PM +1100, Matt Flax wrote:
> On 05/02/17 02:49, Mark Brown wrote:
> > On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:

> > I can't understand how this works.  We're programming the hardware in an
> > identical fashion for both channel counts, that means that what we're

> I am not surprised it is confusing, to my knowledge this is the first time
> that someone has demonstrated this type of I2S signalling.

More than stereo I2S?  That is actually a thing, while most people use
DSP modes for higher channel counts it's fairly common to have the
support especially in CODECs that also support DSP mode since the
hardware implementation is fairly straightforward if you abstracted in
the bus interface.

> In this case BCM2835 is a clock slave and not concerned with generating the
> I2S clocks, only receiving - think of all clocks and synchrony being
> generated/managed in hardware on the sound card.

> In short the BCM2835 silicon is only concerned with shifting bits into two
> hardware registers which (after DMA) are interpreted by ALSA according to
> the specified channel count.

Sure, that's what all audio controllers do.  But there's a few problems.
One is that nothing in your code that prevents this running in master
mode.  Another is that if this *is* for I2S mode then when doing
multichannel I2S you usually still respect the left/right indication in
LRCLK so you will end up with the data in the in memory format:

  L1 R1 L2 R2 L3 R3 L4 R4

but multi channel I2S would usually be rendered with all the left
channels and all the right channels grouped together so you get:

  L1 L2 L3 L4 R1 R2 R3 R4

It'll also require exact clocking with no spare bits in order to sync
the right channels with the LRCLK switch but that's not so unusual.
Looking at the driver it may be possible for the hardware to do DSP
modes at which point this gets much easier but right now it only has I2S
support, I've got a feeling that the other end of the link may actually
be running in a DSP mode.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170205/5fc6f15d/attachment.sig>
