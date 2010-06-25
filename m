From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jun 2010 14:39:40 +0100
Subject: strange segfaults with CompactFlash in "true-ide" mode on PXA270
In-Reply-To: <201006250911.30277.schindele@nentec.de>
References: <201006231706.33182.schindele@nentec.de>
	<19490.10015.10027.750374@ipc1.ka-ro>
	<201006250911.30277.schindele@nentec.de>
Message-ID: <1277473180.13134.24.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-06-25 at 08:11 +0100, Juergen Schindele wrote:
> Am Mittwoch, 23. Juni 2010 schrieb Lothar Wa?mann:
> > Hi,
> >
> > > we have a strange problem when booting from a Compact Flash card
> > > as root-device. In one of 10 cases while booting an application from
> > > root-filesystem dies with "Segmentation fault" without a visible error.
> > > After booting the same application runs hundred times without error.
> > > (we're talking about standard appl. like chat, pppd, hwclock and so on)
> > >
> > > For debugging purposes we put printk's in kernels IDE driver
> > > and the problem disappeared. But replacing the printk by a usleep
> > > or so (which is not a solution !) brings the problem back.
> > > It seems that the application received faulty data from CF.
> > > But how and why ?????????????????????????????
> > >
> > > We tested with a custom PXA270 board with a CompactFlash in
> > > "true ide" on processor bus driven by "generic ide / pata_platform"
> > > driver from linux-2.6.27.x.
> > > (by the way linux-2.6.20.x showed the same problem).
> > >
> > > Any ideas, hints, experiences, patches are very welcome :-)
> > > --------------------------------------------------------------
> > I guess that is the old cache problem that apparently was never really
> > fixed:
> > http://marc.info/?t=108537828400002&r=1&w=2
> Hello
> this hint was very helpful for understanding the problem.
> In the mail from Russell King at
> <http://marc.info/?l=linux-arm-kernel&m=108611676807909&w=2>
> he said : .... the rule is if the CPU writes to a page cache page,
> it must call flush_dcache_page afterwards to ensure cache coherency with user space".
> 
> so i made the following patch in drivers/ide/ide-taskfile.c
> in the function ide_pio_sector() where blocks from disk are read
> into a cached page to apply the rule from Russell.

That rule has been discussed on several occasions on LKML. So rather
than changing all the faulty drivers, you can try this:

http://article.gmane.org/gmane.linux.ports.arm.kernel/83413

-- 
Catalin
