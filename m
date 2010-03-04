From: thomas@koeller.dyndns.org (Thomas Koeller)
Date: Thu, 4 Mar 2010 22:11:08 +0100
Subject: DMA using data buffer vmapped in kernel space
Message-ID: <201003042211.28569.thomas@koeller.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am writing a driver that loads a firmware blob into its device. The driver
calls request_firmware() and gets a struct firmware * that contains a
data buffer pointer in its 'data' member. The buffer is then passed to a
SPI driver to send it to the device.

The SPI driver uses DMA and, in preparation for that, eventually calls
dma_cache_maint() (contained in arch/arm/mm/dma-mapping.c). At this
point, the whole thing goes bad because there is a check:

	BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));

and the address obtained via request_firmware() fails this check.

The request_firmware() function creates the data buffer by allocating a
number of single pages in a loop, places them in an array, and finally
creates a kernel mapping by calling vmap(). The vmap() result is the
buffer address passed to the DMA.

I do not understand the purpose of the failing check. The virt_addr_valid()
macro checks whether its argument is below high_memory. But why would the
virtual address of a DMA data buffer matter at all? After all, the pages
are resident, so I cannot see any problem here. Can anybody explain?

Thomas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100304/11d54161/attachment.sig>
