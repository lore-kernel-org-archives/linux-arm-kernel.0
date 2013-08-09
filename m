From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 21:38:47 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem
In-Reply-To: <20130809194434.GP6427@sirena.org.uk>
References: <5204A716.6070507@gmail.com> <20130809091953.GO6427@sirena.org.uk>
 <5204B7A6.9050907@gmail.com> <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com> <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
 <20130809180058.GM6427@sirena.org.uk>
 <20130809182516.GT23006@n2100.arm.linux.org.uk>
 <20130809194434.GP6427@sirena.org.uk>
Message-ID: <20130809203847.GU23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 08:44:34PM +0100, Mark Brown wrote:
> If someone wants to it should also be possible to convert the existing
> platforms without S/PDIF support over to DT, providing you don't mind
> changing the code once the DPCM and S/PDIF support is added and a bit of
> thought is put into where the S/PDIF output will fit into the bindings.

Okay, so you're thinking that the I2S output will be enabled in the
absence of DPCM?  If so, that tells me that you don't understand my
patches, and this is getting *really* tiresome.

One more time:
- There are two outputs from the FIFO.
- There is an I2S output, and there is a SPDIF output.
- All hardware has an I2S output.
- Some hardware also has the SPDIF output.
- Each output is individually enable-able via separate bits.
- When both outputs are used, both must be enabled simultaneously.
- Otherwise, only one output must be enabled at any one time.
- At least one output must be enabled for there to be any activity
  from the unit at all (that's obvious!)

So, what I'm doing is providing _two_ AIF connection points, one for I2S
and one for SPDIF.  The appropriate AIF connection point must be attached
to for the appropriate output to be enabled.

That means that if you want to use the SPDIF output, the SPDIF AIF must
be linked to the codec.  If you want to use the I2S output, the I2S AIF
must be linked to the codec.

Without this, there's no way for the CPU DAI to know which output(s) are
in use, and therefore which should be enabled.

What this means is that the conventional setup where you have _one_ DAI
link connecting the codec DAI to the CPU DAI won't work on Kirkwood
anymore, because there is no way to know which of the two outputs
should be enabled.  I avoided that in my patches, but you've objected
to that saying that it must use DPCM.  That makes the whole of kirkwood
entirely DPCM only, whether or not you have a single codec to connect.

Surely you realise this, because you must have read the patches properly
before you commented on them, and realised that one of spdifdo or i2sdo
must be powered up to set either enable bit?
