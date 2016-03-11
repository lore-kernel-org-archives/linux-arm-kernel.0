From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 11 Mar 2016 15:58:19 -0600
Subject: [PATCH v12] [PATCH] PCI: Xilinx-NWL-PCIe: Adding support for
 Xilinx NWL PCIe Host Controller
In-Reply-To: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
References: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
Message-ID: <20160311215819.GB16257@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

I forgot I still have one question here:

On Sun, Mar 06, 2016 at 10:02:14PM +0530, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.

> +static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct nwl_pcie *pcie = bus->sysdata;
> +
> +	/* Check link,before accessing downstream ports */
> +	if (bus->number != pcie->root_busno) {
> +		if (!nwl_pcie_link_up(pcie))
> +			return false;
> +	}

This seems racy.  What if we check, and the link is up, but the link
goes down before we actually complete the config access?

I'm suggesting that this check for the link being up might be
superfluous.

The hardware should do something reasonable with the config access if
it can't send it down the link.

> +
> +	/* Only one device down on each root port */
> +	if (bus->number == pcie->root_busno && devfn > 0)
> +		return false;
> +
> +	return true;
> +}
