From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 10:53:10 +0100
Subject: [PATCH 1/5] ARM: add EXPORT_SYMBOL of hook_fault_code for PCI
 host modularization
In-Reply-To: <1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <2567476.SknW0BEsQJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 February 2016 19:00:40 Paul Gortmaker wrote:
> In a discussion of a previous patch set[1], it was suggested that
> modularizing some of the PCI host support would be good to keep
> multi platform bzImage sizes smaller.
> 
> Two of the files that are candidates for conversion to tristate
> from bool are:
> 
> drivers/pci/host/pci-imx6.c
> drivers/pci/host/pci-keystone.c
> 
> However, doing the conversion reveals that they are going to fail
> at modpost time since hook_fault_code isn't currently exported.
> 
> Since we are now going to export it we also need to remove the
> __init tag, as the fcn needs to be present at insmod time.
> 
> [1] https://lkml.kernel.org/r/20160108203102.GH5354 at localhost
> 

If we want to make hook_fault_code() visible, we at least also need
an unhook_fault_code() function that removes the fault handler
when unloading the module, and preferably does so in a safe way.

The usage of hook_fault_code() at least in the imx driver is also
problematic, as it just ignores all "imprecise external abort"
faults, whether they come from PCI or not.

	Arnd
