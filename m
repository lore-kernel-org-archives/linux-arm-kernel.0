From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 21 May 2012 19:29:37 +0200
Subject: [PATCH 1/8] ARM: PCI: remove unused sys->hw
In-Reply-To: <20120521145711.GB24270@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
 <E1SNLkt-00080g-R0@rmk-PC.arm.linux.org.uk>
 <20120521143504.GD21513@avionic-0098.mockup.avionic-design.de>
 <20120521145711.GB24270@n2100.arm.linux.org.uk>
Message-ID: <20120521172937.GA11824@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux wrote:
> On Mon, May 21, 2012 at 04:35:04PM +0200, Thierry Reding wrote:
> > I have some patches which convert the Tegra PCIe code to a platform driver. I
> > used to use the sys->hw field to obtain a pointer to my driver-private struct
> > which had the struct hw_pci embedded.
> > 
> > Something like this:
> > 
> > 	struct tegra_pcie_info {
> > 		...
> > 		struct hw_pci hw;
> > 		...
> > 	};
> 
> The hw_pci struct is not supposed to be embedded into anything - it's
> supposed to be a short-term struct used just to initialize things -
> it's certainly not required after pci_common_init() returns.

Okay, understood.

> > From ed0421bb87e3fa1484fd54fa504e828e017c3221 Mon Sep 17 00:00:00 2001
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> > Date: Mon, 21 May 2012 16:25:58 +0200
> > Subject: [PATCH] HACK: ARM: PCI: Allow passing driver-private data
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  arch/arm/include/asm/mach/pci.h |    2 +-
> >  arch/arm/kernel/bios32.c        |   16 +++++++++-------
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index 26c511f..5508dc8 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -52,7 +52,7 @@ struct pci_sys_data {
> >  /*
> >   * Call this with your hw_pci struct to initialise the PCI system.
> >   */
> > -void pci_common_init(struct hw_pci *);
> > +void pci_common_init(struct hw_pci *, void *);
> >  
> >  /*
> >   * PCI controllers
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index 9c0c9a0..45d8171 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -423,7 +423,8 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >  	return irq;
> >  }
> >  
> > -static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> > +static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head,
> > +			    void *private)
> >  {
> >  	struct pci_sys_data *sys = NULL;
> >  	int ret;
> > @@ -435,11 +436,12 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> >  			panic("PCI: unable to allocate sys data!");
> >  
> >  #ifdef CONFIG_PCI_DOMAINS
> > -		sys->domain  = hw->domain;
> > +		sys->domain       = hw->domain;
> >  #endif
> > -		sys->busnr   = busnr;
> > -		sys->swizzle = hw->swizzle;
> > -		sys->map_irq = hw->map_irq;
> > +		sys->busnr        = busnr;
> > +		sys->swizzle      = hw->swizzle;
> > +		sys->map_irq      = hw->map_irq;
> > +		sys->private_data = private;
> 
> This is inappropriate, because if you look at pcibios_init_hw() you'll
> notice that it loops over N buses, and they typically want differing
> private data.

In this particular case, each bus gets the same struct tegra_pcie_info.

> If we want to do this, we need to restructure this code.  However...

Maybe an array of pointers for each controller can be added to hw_pci
instead. I'd rather not add a global variable to store this information (like
other PCIe controller drivers do) because it goes completely against the
concept of rewriting this code as a platform driver.

I know that there will likely only ever be a single instance of the driver,
but that doesn't mean it shouldn't be done properly.

> I'm not sure coupling a platform driver into this code is the best
> approach - the platform driver will have to live outside of arch/arm,
> yet would depend totally on code within arch/arm.  That sounds like the
> wrong approach.  What if some other arch wants to reuse your platform
> driver?

The driver isn't used by any other platform. It is a driver for the Tegra
PCIe controller. When I posted it the first time there was some discussion
that it should move out of arch/arm, but it was argued that it won't be
usable on anything else but Tegra anyway and therefore would better be
located in arch/arm/mach-tegra.

One of the reasons for rewriting the code as a platform driver is so that it
can be probed via DT. It's in fact one of the remaining issues to fix before
board files can be removed for Tegra (along with clock tables I think).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/8c5dbad6/attachment-0001.sig>
