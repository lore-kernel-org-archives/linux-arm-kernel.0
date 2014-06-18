From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Jun 2014 17:49:27 +0100
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1402950432.3708.22.camel@smoke>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke>
Message-ID: <20140618164927.GA9612@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 09:27:12PM +0100, Geoff Levand wrote:
> Hi Mark,

Hi Geoff,

> Sorry for such a delay in my reply.
> 
> On Fri, 2014-05-16 at 10:50 +0100, Mark Rutland wrote:
> > Both the image load offset and the effective image size are forced to be
> > little-endian regardless of the native endianness of the kernel to
> > enable bootloaders to load a kernel of arbitrary endianness. Bootloaders
> > which wish to make use of the load offset can inspect the effective
> > image size field for a non-zero value to determine if the offset is of a
> > known endianness.
> 
> Doing this conversion in the linker script seems complicated.  My
> thought was to just have an image header field that specifies the
> byte order, in the same way that the EI_DATA part of the ELF
> e_ident field does.

While the conversion in the linker script is a little ugly, it does
work, and that complexity is hidden behind the macro I added.

While I initially considered having a field to specify byte order, it's
incredibly likely that bootloaders will not use it. Maintaining a fixed
endianness everywhere makes it simpler for bootloaders to do the right
thing, and matches what existing bootloaders are already doing. That's
less pain for loaders and less pain for the kernel, as things are less
likely to go wrong.

To me it makes more sense to ensure these fields have a consistent
endianness, rather than adding more room for possible mistakes.

> Another advantage of having the byte order in the header is that
> tools other than a boot loader that need to know the byte order
> can get that info from the header, otherwise they would need to
> guess the order with some kind of inspection.

What kind of tools do you envision which would need to know the
endianness of the kernel but would be looking at the Image rather than
the vmlinux?

Mark.
