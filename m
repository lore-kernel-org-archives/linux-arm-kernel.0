From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Sep 2018 00:10:51 +0100
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <87zhwm4kl6.fsf@tkos.co.il>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
Message-ID: <20180912231050.GX30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 09:49:41PM +0300, Baruch Siach wrote:
> I reproduced the same Oops on Clearfog Base without any taint:
> 
> [    1.476401] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
...
> [    1.855954] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)

That is a BUG().  Please turn on verbose bug reporting to get more
information about the cause.

There are two possibilities:

        BUG_ON(addr >= end);

and

                BUG_ON(!pte_none(*pte));

It's probably the latter - the region is probably already mapped, that
being the PCI IO region.

The original driver was setup to call pci_ioremap_io() as the very
last thing - and as the driver is non-removable, we were guaranteed
to never tear down this mapping (which is sensible, it's published
to userspace.)

However, the current code calls pci_ioremap_io() much earlier, in
a path where probe failures can occur.  This breaks pci_ioremap_io()'s
requirements - it must not be called more than once.  So:

ee1604381a37 ("PCI: mvebu: Only remap I/O space if configured")

is basically incorrect - pci_ioremap_io() needs to move back to a
place where it is only called in a path which will never fail.
However, looking at the generic host bits, I'm not sure such a place
exists in the new effort to make stuff more generic.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
