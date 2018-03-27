From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Mar 2018 14:53:10 -0500
Subject: [PATCH v3 1/6] PCI: aardvark: introduce an
 advk_pcie_valid_device() helper
In-Reply-To: <20180327140819.23501-9-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
 <20180327140819.23501-9-thomas.petazzoni@bootlin.com>
Message-ID: <20180327195310.GF7759@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 04:08:14PM +0200, Thomas Petazzoni wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> In other to mimic other PCIe host controller drivers, introduce an
> advk_pcie_valid_device() helper, used in the configuration read/write
> functions.
> 
> This patch by itself is not a fix, but it is required for a follow-up
> patch that is a fix, hence the Fixes tag and the Cc to stable.
> 
> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes since v2:
>  - New patch
> ---
>  drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index b04d37b3c5de..ccd0304a0c21 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -430,6 +430,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static int advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> +				  int devfn)
> +{
> +	if (PCI_SLOT(devfn) != 0)
> +		return false;
> +
> +	return true;
> +}

Thanks for following the style of the other drivers.

Some of them return int, some return bool.  I don't really care which
you use , but you should probably use one consistently, e.g., declare
this as a bool function, or declare it as int and return 0/1.
