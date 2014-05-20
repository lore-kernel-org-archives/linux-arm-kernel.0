From: trini@ti.com (Tom Rini)
Date: Tue, 20 May 2014 10:12:19 -0400
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20140520141219.GB1752@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:50:38AM +0100, Mark Rutland wrote:

> Currently the kernel Image is stripped of everything past the initial
> stack, and at runtime the memory is initialised and used by the kernel.
> This makes the effective minimum memory footprint of the kernel larger
> than the size of the loaded binary, though bootloaders have no mechanism
> to identify how large this minimum memory footprint is. This makes it
> difficult to choose safe locations to place both the kernel and other
> binaries required at boot (DTB, initrd, etc), such that the kernel won't
> clobber said binaries or other reserved memory during initialisation.
> 
> Additionally when big endian support was added the image load offset was
> overlooked, and is currently of an arbitrary endianness, which makes it
> difficult for bootloaders to make use of it. It seems that bootloaders
> aren't respecting the image load offset at present anyway, and are
> assuming that offset 0x80000 will always be correct.
> 
> This patch adds an effective image size to the kernel header which
> describes the amount of memory from the start of the kernel Image binary
> which the kernel expects to use before detecting memory and handling any
> memory reservations. This can be used by bootloaders to choose suitable
> locations to load the kernel and/or other binaries such that the kernel
> will not clobber any memory unexpectedly. As before, memory reservations
> are required to prevent the kernel from clobbering these locations
> later.
> 
> Both the image load offset and the effective image size are forced to be
> little-endian regardless of the native endianness of the kernel to
> enable bootloaders to load a kernel of arbitrary endianness. Bootloaders
> which wish to make use of the load offset can inspect the effective
> image size field for a non-zero value to determine if the offset is of a
> known endianness.
> 
> The documentation is updated to clarify these details. To discourage
> future assumptions regarding the value of text_offset, the value at this
> point in time is removed from the main flow of the documentation (though
> kept as a compatibility note).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Putting on my U-Boot hat, this looks sensible and implementable so:
Acked-by: Tom Rini <trini@ti.com>

-- 
Tom
