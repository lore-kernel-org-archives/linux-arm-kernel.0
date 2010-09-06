From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Mon, 6 Sep 2010 15:58:36 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to,from}_user?
In-Reply-To: <AANLkTi=kSwGKZ8Hpcvmatj9j2h2JZAWMGR15hMOBOpTx@mail.gmail.com>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<AANLkTi=kSwGKZ8Hpcvmatj9j2h2JZAWMGR15hMOBOpTx@mail.gmail.com>
Message-ID: <20100906135836.GB6897@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 04:46:07PM +0300, saeed bishara wrote:
> On Mon, Sep 6, 2010 at 1:02 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
> >
> > Mapping the PCI memory space via mmap() resulted in some
> > disappointing ~6.5 MBytes/second. I tried to modify page
> > protection to pgprot_writecombine or pgprot_cached, but while
> > this did reproducably change performance, it was only in
> > some sub-percentage range.
> weird, marking those pages as bufferable (none-cachable) should boost
> the throughput.

Maybe I have some misunderstanding here. My idea was that
I have to enable any sort of caching to get the writes combined
into a burst because else every single write causes a single PCI
transaction.
In my naive thought, writecombine was something like a write-only,
read transparent cache. Is there any thorough explanation of their
meaning somewhere?
Anyways, neither of pgprot_nocache, pgprot_cached or
pgprot_writecombine made a significant difference.

> you may also try to set the u-boot variable pcieTune to yes, make sure
> to save the env. variables then reboot the system.

I set "setenv pcieTune yes" and saved the environment, but it
did not change anything. Who would be responsible for caring
about this variable, U-Boot itself or the kernel? I am asking
because the variable was not present at all in my environment
until now.

[...]
> > - Is this feature available as an unofficial patch somewhere?
> yes, but the kernel has the drivers/dma/mv_xor that implements the DMA
> Engine interface, you may use that driver for the DMA offloading.

Yes, I found this interface, but was hoping there would be some
more framework that already does the copy_{to,from}_user handling
for me so I do not have to fiddle around with the user pages and
stuff. But while implementing I saw it is probably too device-
dependent to have such a thing around.

> > - Is the idea of directly setting up a transfer from user pages
> > ?to PCI memory space possible at all?
> you need to do some hacking for that, but I'm almost sure that it
> won't help. using the cpu should be enough.

Sounds bad. :-(

I will see if I can get my hacking to work, just to hopefully
prove you wrong here. ;-) Well, obviously the point is not to
prove somebody else wrong but to somehow get a reasonable speed...

Regards,
Wolfgang
