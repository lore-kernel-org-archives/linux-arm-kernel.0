From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 28 May 2015 22:43:33 +0300
Subject: [PATCHv2 2/3] bus: mvebu-mbus: use automatic I/O synchronization
 barriers
In-Reply-To: <5530E44E.8070105@freebox.fr>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421424689-5971-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5530E44E.8070105@freebox.fr>
Message-ID: <20150528194333.GA1468@aspire-one.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 17, 2015 at 12:45:34PM +0200, Nicolas Schichan wrote:
> On 01/16/2015 05:11 PM, Thomas Petazzoni wrote:
> > Instead of using explicit I/O synchronization barriers shoehorned
> > inside the streaming DMA mappings API (in
> > arch/arm/mach-mvebu/coherency.c), we are switching to use automatic
> > I/O synchronization barrier.
> 
> Hello Thomas,
> 
> I'm affraid this patche causes issue on mv88f6282 (and most probably on
> mv88f6281 as well): see below.

Is this issue already fixed in 4.1-rc5?

I just noticed that on mvebu/openrd-client the built-in PCI XGI framebuffer
stopped working somewhere between 3.19 and 4.0, and I bisected it to this
commit. The issue is also present in 4.1-rc5 and reverting this commit
makes the display to work again.

A.

> [...]
> 
> > diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> > index eb7682d..398f0ee 100644
> > --- a/drivers/bus/mvebu-mbus.c
> > +++ b/drivers/bus/mvebu-mbus.c
> > @@ -69,6 +69,7 @@
> >   */
> >  #define WIN_CTRL_OFF		0x0000
> >  #define   WIN_CTRL_ENABLE       BIT(0)
> > +#define   WIN_CTRL_SYNCBARRIER  BIT(1)
> 
> In the 88f6282 datasheet this bit in the "WindowX Control Register" is
> documented as reserved on all windows but window 6 and 7.
> 
> For windows 6 and 7 this bit is documented to write protect the window when set.
> 
> In our configuration, this window gets chosen for the PCI memory accesses
> (target 0x4, attribute 0xe8) and we effectively end up only being able to read
> from the PCI devices (mwl8k fails to load the firmware and sky2 timeouts on
> MDIO accesses). Write accesses are silently discarded (no external aborts of
> any kind), but that's probably expected as the AHB error propagation is disabled.
> 
> Reverting this patch made all the PCI device work correctly.
> 
> Regards,
> 
> -- 
> Nicolas Schichan
> Freebox SAS
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
