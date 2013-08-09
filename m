From: broonie@kernel.org (Mark Brown)
Date: Sat, 10 Aug 2013 00:42:09 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
In-Reply-To: <20130809203847.GU23006@n2100.arm.linux.org.uk>
References: <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com> <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
 <20130809180058.GM6427@sirena.org.uk>
 <20130809182516.GT23006@n2100.arm.linux.org.uk>
 <20130809194434.GP6427@sirena.org.uk>
 <20130809203847.GU23006@n2100.arm.linux.org.uk>
Message-ID: <20130809234209.GQ6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 09:38:47PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 09, 2013 at 08:44:34PM +0100, Mark Brown wrote:

> > If someone wants to it should also be possible to convert the existing
> > platforms without S/PDIF support over to DT, providing you don't mind
> > changing the code once the DPCM and S/PDIF support is added and a bit of
> > thought is put into where the S/PDIF output will fit into the bindings.

> Okay, so you're thinking that the I2S output will be enabled in the
> absence of DPCM?  If so, that tells me that you don't understand my

When I say that it should be possible to convert the existing machines
over to DT I'm talking about the machines that are supported with the
drivers currently in mainline.  These machines presumably work just fine
with the existing drivers which support the I2S only subset of the
possible functionality in the hardware without using DCPM.  These are
the the machines that could have DT added now without implementing the
driver improvements to enable the extra hardware functionality.

When I say that they will need changing once DPCM and S/PDIF support is
added what I mean is that those changes to the CPU side drivers should,
as you correctly say, require all Kirkwood machine drivers to use DPCM
even if only due to the handling of simultaneous startup of the S/PDIF
and I2S interfaces.

The "you" in the above quote was intended to refer to people working on
Kirkwood in general, not you personally unless you want to.

> What this means is that the conventional setup where you have _one_ DAI
> link connecting the codec DAI to the CPU DAI won't work on Kirkwood
> anymore, because there is no way to know which of the two outputs
> should be enabled.  I avoided that in my patches, but you've objected
> to that saying that it must use DPCM.  That makes the whole of kirkwood
> entirely DPCM only, whether or not you have a single codec to connect.

Right, that's where the drivers should end up.  In terms of the device
tree I would expect that it should be the case that there are distinct
I2S and S/PDIF interfaces visible, or at least that there's some way to
identify which interface on the SoC is being referred to - this is the
thought about where the S/PDIF output will fit into the bindings that I
mentioned being required.

So long as only I2S is used in the system (or at least any S/PDIF that
is present is ignored at runtime) it should be possible to continue
using the existing driver infrastructure until S/PDIF and DPCM support
is added and then transition the existing drivers (both non-DT and any
DT ones that get added or converted) over to that as part of the
conversion.

In other words I was talking about a possible intermediate state where
people are working with the DT bindings but the driver support for
systems with S/PDIF in use is not there yet.  That's not required but it
should be possible if there's interest in progressing the DT bindings
while the driver is as it stands.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130810/c481937b/attachment.sig>
