From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 8 Feb 2016 11:39:13 -0500
Subject: [PATCH 1/5] ARM: add EXPORT_SYMBOL of hook_fault_code for PCI
 host modularization
In-Reply-To: <2567476.SknW0BEsQJ@wuerfel>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com>
 <2567476.SknW0BEsQJ@wuerfel>
Message-ID: <20160208163913.GX23093@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 1/5] ARM: add EXPORT_SYMBOL of hook_fault_code for PCI host modularization] On 08/02/2016 (Mon 10:53) Arnd Bergmann wrote:

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

If it is straight forward by doing an unwind of the existing hook, then
I can look at having a go at implementing it, but again per the 0/N the
original goal here was the "step one" of making it at least buildable,
and then moving on from there, preferably by people with the platforms
and deeper knowledge of the runtime requirements and issues.

> 
> The usage of hook_fault_code() at least in the imx driver is also
> problematic, as it just ignores all "imprecise external abort"
> faults, whether they come from PCI or not.

That is definitely beyond anything I'm suitably armed to fix within the
scope of this series, and will have to be from the imx people or similar.

Paul.
--


> 
> 	Arnd
