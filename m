From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 17 Apr 2015 13:23:50 +0200
Subject: [PATCHv2 2/3] bus: mvebu-mbus: use automatic I/O
 synchronization barriers
In-Reply-To: <5530E44E.8070105@freebox.fr>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1421424689-5971-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5530E44E.8070105@freebox.fr>
Message-ID: <20150417132350.329bcace@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Schichan,

On Fri, 17 Apr 2015 12:45:34 +0200, Nicolas Schichan wrote:

> I'm affraid this patche causes issue on mv88f6282 (and most probably on
> mv88f6281 as well): see below.
> 
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

Ah, thanks a lot for the bug report. I'll cook a fix for this problem,
and Cc: you when submitting.

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
