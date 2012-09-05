From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 05 Sep 2012 13:08:53 +0300
Subject: Converting OMAP's custom vram allocator
Message-ID: <1346839733.32747.1.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

OMAP has a custom video ram allocator, which I'd like to remove and use
the standard dma allocation functions.

There are two problems for which I'd like to hear suggestions or
comments:

First one is that the dma_alloc_* functions map the allocated memory for
cpu use. In many cases with OMAP DSS (display subsystem) this is not
needed: the memory may be written only by the SGX or the DSP, and it's
only read by the DSS, so it's never touched by the CPU.

This is even more true when using VRFB on omap3 (and probably TILER on
omap4) for rotation, as VRFB hides the actual memory and offers rotated
views. In this case the backend memory is never accessed by anyone else
than VRFB.

Is there a way to allocate the memory without creating a mapping? While
it won't break anything as such, the allocated areas can be quite large
thus causing large areas of the kernel's memory space to be needlessly
reserved.

The second case is passing a framebuffer address from the bootloader to
the kernel. Often with mobile devices the bootloader will initialize the
display hardware, showing a company logo or such. To keep the image on
the screen when kernel starts we need to reserve the same physical
memory area early at boot, and use that for the framebuffer.

I'm not sure if there's any actual problem with this one, presuming
there is a solution for the first case. Somehow the memory is reserved
at early boot time, and this is passed to the fb driver. But can the
memory be managed the same way as in normal case (for example freeing
it), or does it need to be handled as a special case?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120905/583648a8/attachment.sig>
