From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 Oct 2014 10:25:52 -0600
Subject: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
In-Reply-To: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20141030162552.GC26820@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 11:44:46AM +0000, Lorenzo Pieralisi wrote:

> Code in drivers/pci/pci-mvebu.c has been changed to add a domain
> number to PCI resources by using the nr value coming from the setup
> pcibios32 callback, which may not be correct and should be considered
> a temporary solution waiting for review comments.

The intent of the string was to have the domain number so that
resources in /proc/iomem can be correlated with lspci.

This would be a 'best practice' - all PCI drivers need to request
resource, and the resource should be relatable back to the PCI
domain... So it would be best if the domain number was available at
this point in a driver's flow.

> -       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
> -                domain);
> +       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", nr);

I'm not sure what 'nr' is in this context, if it is not the domain
number then I'd just drop the 0x04x entirely rather than include
some nonsense number...

Jason
