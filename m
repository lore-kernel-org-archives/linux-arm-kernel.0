From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 10:40:09 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <AANLkTinBbXN-fxppo1Pa33DxiS6QYSdwqFsadFDxmPPy@mail.gmail.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
	<20110131102726.GA8948@n2100.arm.linux.org.uk>
	<AANLkTinBbXN-fxppo1Pa33DxiS6QYSdwqFsadFDxmPPy@mail.gmail.com>
Message-ID: <20110131104009.GC8948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 11:31:11AM +0100, Linus Walleij wrote:
> 2011/1/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> > - ? ? ? if (status & MCI_DATAEND) {
> >> > + ? ? ? if (status & MCI_DATAEND || data->error) {
> >> > ? ? ? ? ? ? ? ?mmci_stop_data(host);
> >>
> >> The hardware always sets the MCI_DATAEND bit if there is
> >> some error, so these flags always appear simultaneously, but
> >> it doesn't hurt to take some extra precaution, so
> >
> > The hardware may do, but you won't see that here. ?When we setup a
> > transfer, we do this:
> >
> > ? ? ? ?writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
> 
> Ah! I get it.
> 
> We've actually played around with that, having MCI_DATAEND on all the
> time, it's not necessary any more since we're not using the blockend IRQ
> and they cannot race, so we can take a little bit of quirking out of it.
> But I'll get back on that issue.

Wrong issue.  What can happen is you receive the DATAEND interrupt,
which tears down the data side of the request, and starts the stop
command.  Meanwhile there's still data left in the FIFO for the CPU
to read.

I suspect there's a similar race between DMA and the host CPU too as
you leave the DATAEND interrupt on.  I suspect for reliability, we
need to have the DMA controller callback function in place to enable
the DATAEND interrupt.  Or something like that.
