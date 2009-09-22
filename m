From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 23 Sep 2009 01:42:31 +0200
Subject: ixp4xx dmabounce
In-Reply-To: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
Message-ID: <19129.24807.954274.688709@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Walsh writes:
 > I am running into an issue with high speed USB devices running on an ixp4xx
 > processor.  It looks like a dmabounce related problem.  I am running on an
 > ixp425 with 128 MB of RAM.  I am attaching a Sierra Wireless USB phone module
 > which attaches as a high speed USB ethernet device.  I am running the 2.6.31
 > kernel version.
 > 
 > I found a patch which seems to be trying to address the same issue I am
 > having but it left the USB device unable to attach.
 > 
 > http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-ixp4xx-disable-dmabounce-2.6.30-rc2
 > 
 > The relevant kernel messages with and without the patch applied are below.
 > The warning stack dump continues to stream out leaving the system basically
 > unresponsive until the data transfer completes.  Removing that stack dump
 > warning from dma-mapping.c the device is usable but operates with transfer
 > rates below that when it is attached to the full speed controller.
 > 
 > Any ideas or suggestions?

I strongly suspect that something on the USB or networking side
is allocating I/O buffers without observing the correct DMA APIs.
In particular, DMA buffers for a PCI device must respect that
device's dma_mask.

In my case I tested a libata-driven PCI ATA controller, and such
devices work because:
(a) they allocate buffers via the proper DMA APIs, and
(b) the block layer takes care of bouncing when necessary.

I'd add debugging code to trace what I/O buffers are being used,
and if they are invalid (above the 64MB limit), more code to see
who allocated them.

I think Krzysztof Halasa mentioned running ixp4xx devices with 128MB
RAM and a kernel hacked so kernel-private allocations would always be
served from memory below 64MB. I think he mentioned doing that because
of networking components that would ignore PCI DMA mask constraints.
