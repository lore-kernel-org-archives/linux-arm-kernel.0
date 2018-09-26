From: ashok.raj@linux.intel.com (Raj, Ashok)
Date: Wed, 26 Sep 2018 09:22:35 -0700
Subject: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
In-Reply-To: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180926162235.GA30177@araj-mobl1.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan

+ IOMMU list.

On Sat, Jun 30, 2018 at 11:24:24AM -0400, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> An IOMMU takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> 
>   It is an error to receive a TLP with an End-End TLP Prefix by a
>   Receiver that does not support End-End TLP Prefixes. A TLP in
>   violation of this rule is handled as a Malformed TLP. This is a
>   reported error associated with the Receiving Port (see Section 6.2).
> 
> Prevent error condition by proactively requiring End-to-End TLP
> prefix to be supported on the entire data path between the endpoint and
> the root port before enabling PASID.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  
> +static void pci_configure_eetlp_prefix(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_PASID
> +	struct pci_dev *bridge;
> +	u32 cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +		return;

Forgot to notice this.. I'm not sure if the same enforcement is 
required for devices that are RCIEP. The spec isn't clear about calling
any excemption. Although it should be simple for devices to expose
e2etlp support, but if they don't that should be ok, since there are
nothing between itself and the root port.

We are seeking help from our SIG reps, but thought I'll ask here as well
if there are other opinions.

> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		dev->eetlp_prefix_path = 1;
> +	else {
> +		bridge = pci_upstream_bridge(dev);
> +		if (bridge && bridge->eetlp_prefix_path)
> +			dev->eetlp_prefix_path = 1;
> +	}
> +#endif
> +}

Cheers,
Ashok
