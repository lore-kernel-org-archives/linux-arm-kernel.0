From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 28 Feb 2018 15:24:17 -0600
Subject: [PATCH V2] PCI/ASPM: Suppress common clock mode setting failure
In-Reply-To: <1516651924-21820-1-git-send-email-okaya@codeaurora.org>
References: <1516651924-21820-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180228212417.GM127842@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 03:12:01PM -0500, Sinan Kaya wrote:
> Code is emitting warnings when it tries to set the common clock mode for
> ASPM and ASPM is already configured to common clock mode by the UEFI BIOS.
> Let's bail out silently in such a case.
> 
> pci 0004:00:00.0: ASPM: Could not configure common clock
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/aspm for v4.17, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 9783e10..913b90d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -240,6 +240,24 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
>  		same_clock = 0;
>  
> +	/* Port might be already in common clock mode */
> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> +	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
> +		bool consistent = true;
> +
> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
> +			pcie_capability_read_word(child, PCI_EXP_LNKCTL,
> +						  &reg16);
> +			if (!(reg16 & PCI_EXP_LNKCTL_CCC)) {
> +				consistent = false;
> +				break;
> +			}
> +		}
> +		if (consistent)
> +			return;
> +		dev_warn(&parent->dev, "ASPM: current common clock configuration is broken, reconfiguring\n");
> +	}
> +
>  	/* Configure downstream component, all functions */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
