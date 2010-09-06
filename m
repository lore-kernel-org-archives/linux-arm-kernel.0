From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Mon, 6 Sep 2010 12:02:44 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to,from}_user?
Message-ID: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I am trying to improve performance of a very basic framebuffer
device connected to a Marvell Kirkwood MV88F6281 via a PCIe->
PCI bridge (88SB2211). The kernel I am using is 2.6.32.

Mapping the PCI memory space via mmap() resulted in some
disappointing ~6.5 MBytes/second. I tried to modify page
protection to pgprot_writecombine or pgprot_cached, but while
this did reproducably change performance, it was only in
some sub-percentage range. I am not sure if I understand
correctly how other framebuffers handle this, but it seems
the "raw" mmapped write performance is not cared about too
much or maybe not that bad with most x86 chip sets?
However, the idea left over after some trying and looking
around is to use the DMA engine to speed up write() (and
also read(), but this is not so important) system calls
instead of using mmap.

Looking around for example code on how to set up the DMA engine
to perform transfers from user buffers, I found this Kconfig
seemingly showing exactly the feature I am looking for:
http://gpl.nas-central.org/SYNOLOGY/x07-series/514_UNTARED/source/linux-2.6.15/arch/arm/mach-mv88fxx81/LSP/Kconfig
(config MV_DMA_COPYUSER
	bool "Support DMA copy_to_user() and copy_from_user"
	depends on (ARCH_MV88f5181) && EXPERIMENTAL)

However, I could not find any patch or similar how this is
implemented. So here my questions:

- Is this feature available as an unofficial patch somewhere?
- Is the idea of directly setting up a transfer from user pages
  to PCI memory space possible at all?
- Why am I the only one who wants such a thing? ;-)

In case of coding stuff myself, I was thinking about something
like this for write():
- get list of page[s], first page offset, last page transfer size
  from user buffer + size
- set up DMA engine to transfer list of [partial] pages
- when done, return from write

Sounds easy, but I am still puzzled by all the different types
of memory in this case, and - much more worrying me - I would think
there should be many devices/drivers using such a thing, but
I did not find them yet.

Any hints are greatly appreciated!

Regards,
Wolfgang
