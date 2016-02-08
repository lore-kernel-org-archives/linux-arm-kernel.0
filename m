From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 17:27:00 +0000
Subject: [PATCH 1/5] ARM: add EXPORT_SYMBOL of hook_fault_code for PCI
 host modularization
In-Reply-To: <2567476.SknW0BEsQJ@wuerfel>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com>
 <2567476.SknW0BEsQJ@wuerfel>
Message-ID: <20160208172700.GR10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 10:53:10AM +0100, Arnd Bergmann wrote:
> On Sunday 07 February 2016 19:00:40 Paul Gortmaker wrote:
> > In a discussion of a previous patch set[1], it was suggested that
> > modularizing some of the PCI host support would be good to keep
> > multi platform bzImage sizes smaller.
> > 
> > Two of the files that are candidates for conversion to tristate
> > from bool are:
> > 
> > drivers/pci/host/pci-imx6.c
> > drivers/pci/host/pci-keystone.c
> > 
> > However, doing the conversion reveals that they are going to fail
> > at modpost time since hook_fault_code isn't currently exported.
> > 
> > Since we are now going to export it we also need to remove the
> > __init tag, as the fcn needs to be present at insmod time.
> > 
> > [1] https://lkml.kernel.org/r/20160108203102.GH5354 at localhost
> > 
> 
> If we want to make hook_fault_code() visible, we at least also need
> an unhook_fault_code() function that removes the fault handler
> when unloading the module, and preferably does so in a safe way.
> 
> The usage of hook_fault_code() at least in the imx driver is also
> problematic, as it just ignores all "imprecise external abort"
> faults, whether they come from PCI or not.

And that gets a NAK from me.  We can't take locks around this code
(to do so would be deadlocky due to imprecise aborts), so we can't
ever safely remove any function that has been hooked into the fault
processing.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
