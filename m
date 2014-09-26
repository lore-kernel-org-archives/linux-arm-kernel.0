From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Sep 2014 10:43:06 -0500
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <3346642.tZaefcZubX@wuerfel>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140926003750.GA12770@saruman> <20140926003934.GD12770@saruman>
 <3346642.tZaefcZubX@wuerfel>
Message-ID: <20140926154306.GE26227@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 26, 2014 at 09:20:54AM +0200, Arnd Bergmann wrote:
> On Thursday 25 September 2014 19:39:34 Felipe Balbi wrote:
> > > 
> > > why would a glue layer need to access registers from the core ? That
> > > sounds very odd. I haven't seen that and will, definitely, NACK such a
> > > patch 
> > > 
> > > can you further describe why you think a glue layer might need to access
> > > core IP's registers ?
> > 
> > I just realised we're talking about chipidea here... in any case, it's
> > still valid to ask why would glue need to fiddle with core IP's
> > registers.
> 
> Generally, the glue driver wouldn't access the registers, but I don't
> think it's important to prevent it from doing that. In some cases, 

sure it is. Have already gone through debugging sessions just because
someone fiddled with registers they shouldn't. Also RMK's L2 rework
patchset is another example of why it's important to prevent other
layers from messing with registers they don't really own.

> a glue driver needs to override a function of the core driver, e.g.
> to work around an errata. We have a lot of those quirks in ATA drivers,

pass a quirk flag and let core driver handle it.

> one example from ahci_mvebu.c is
> 
> static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
> {
>         /*
>          * Enable the regret bit to allow the SATA unit to regret a
>          * request that didn't receive an acknowlegde and avoid a
>          * deadlock
>          */
>         writel(0x4, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_ADDR);
>         writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);

I would rather see:

	if (this_is_one_of_the_broken_mvebu_versions(hpriv))
		quirks |= AHCI_NEEDS_REGRET_BIT;

then let core handle the rest. If other glue has the same bug and needs
the workaround, we don't duplicate code.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/7952a3e1/attachment.sig>
