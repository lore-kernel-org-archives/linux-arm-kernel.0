From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 6 Sep 2010 16:46:07 +0300
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
Message-ID: <AANLkTi=kSwGKZ8Hpcvmatj9j2h2JZAWMGR15hMOBOpTx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 1:02 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
> Hi list,
>
> I am trying to improve performance of a very basic framebuffer
> device connected to a Marvell Kirkwood MV88F6281 via a PCIe->
> PCI bridge (88SB2211). The kernel I am using is 2.6.32.
>
> Mapping the PCI memory space via mmap() resulted in some
> disappointing ~6.5 MBytes/second. I tried to modify page
> protection to pgprot_writecombine or pgprot_cached, but while
> this did reproducably change performance, it was only in
> some sub-percentage range.
weird, marking those pages as bufferable (none-cachable) should boost
the throughput.
you may also try to set the u-boot variable pcieTune to yes, make sure
to save the env. variables then reboot the system.
 I am not sure if I understand
> correctly how other framebuffers handle this, but it seems
> the "raw" mmapped write performance is not cared about too
> much or maybe not that bad with most x86 chip sets?
> However, the idea left over after some trying and looking
> around is to use the DMA engine to speed up write() (and
> also read(), but this is not so important) system calls
> instead of using mmap.
>
> Looking around for example code on how to set up the DMA engine
> to perform transfers from user buffers, I found this Kconfig
> seemingly showing exactly the feature I am looking for:
> http://gpl.nas-central.org/SYNOLOGY/x07-series/514_UNTARED/source/linux-2.6.15/arch/arm/mach-mv88fxx81/LSP/Kconfig
> (config MV_DMA_COPYUSER
> ? ? ? ?bool "Support DMA copy_to_user() and copy_from_user"
> ? ? ? ?depends on (ARCH_MV88f5181) && EXPERIMENTAL)
>
> However, I could not find any patch or similar how this is
> implemented. So here my questions:
>
> - Is this feature available as an unofficial patch somewhere?
yes, but the kernel has the drivers/dma/mv_xor that implements the DMA
Engine interface, you may use that driver for the DMA offloading.
> - Is the idea of directly setting up a transfer from user pages
> ?to PCI memory space possible at all?
you need to do some hacking for that, but I'm almost sure that it
won't help. using the cpu should be enough.
> - Why am I the only one who wants such a thing? ;-)
>
> In case of coding stuff myself, I was thinking about something
> like this for write():
> - get list of page[s], first page offset, last page transfer size
> ?from user buffer + size
> - set up DMA engine to transfer list of [partial] pages
> - when done, return from write
>
> Sounds easy, but I am still puzzled by all the different types
> of memory in this case, and - much more worrying me - I would think
> there should be many devices/drivers using such a thing, but
> I did not find them yet.
>
> Any hints are greatly appreciated!
>
> Regards,
> Wolfgang
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
