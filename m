From: dja@axtens.net (Daniel Axtens)
Date: Wed, 25 Mar 2015 10:58:43 +1100
Subject: [PATCH v8 19/30] powerpc/pci: Use pci_scan_host_bridge() for
 simplicity
In-Reply-To: <1427168064-8657-20-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
 <1427168064-8657-20-git-send-email-wangyijing@huawei.com>
Message-ID: <1427241523.2685.18.camel@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-03-24 at 11:34 +0800, Yijing Wang wrote:
> Now we could use pci_scan_host_bridge() to scan
> pci buses, provide powerpc specific pci_host_bridge_ops.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev at lists.ozlabs.org
> ---
>  arch/powerpc/kernel/pci-common.c |   60 +++++++++++++++++++++++--------------
>  1 files changed, 37 insertions(+), 23 deletions(-)

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 2c58200..e2b50a2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -773,6 +773,29 @@ void pcibios_set_root_bus_speed(struct pci_host_bridge *bridge)
>  		return ppc_md.pcibios_set_root_bus_speed(bridge);
>  }
>  
> +static int pci_host_scan_bus(struct pci_host_bridge *host)
> +{
> +	int mode = PCI_PROBE_NORMAL;
> +	struct pci_bus *bus = host->bus;
> +	struct pci_controller *hose = dev_get_drvdata(&host->dev);
Is there any reason this isn't *hose = pci_bus_to_host(bus)?
> +
> +	/* Get probe mode and perform scan */
> +	if (hose->dn && ppc_md.pci_probe_mode)
> +		mode = ppc_md.pci_probe_mode(bus);
> +
> +	pr_debug("    probe mode: %d\n", mode);
> +	if (mode == PCI_PROBE_DEVTREE)
> +		of_scan_bus(hose->dn, bus);
> +
> +	if (mode == PCI_PROBE_NORMAL) {
> +		pci_bus_update_busn_res_end(bus, 255);
> +		hose->last_busno = pci_scan_child_bus(bus);
> +		pci_bus_update_busn_res_end(bus, hose->last_busno);
> +	}
> +
> +	return pci_bus_child_max_busnr(bus);
> +}
> +
I'm having trouble convincing myself that this patch covers every
variation within our PCI implementations. In particular, there's a
stanza in of_scan_pci_bridge in kernel/pci_of_scan.c that's almost
identical to this function. Does that implementation need to be cleaned
up and replaced with this function too?


> @@ -1641,9 +1655,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
>  		ppc_md.pcibios_fixup_phb(hose);
>  
>  	/* Configure PCI Express settings */
> -	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> +	if (host->bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>  		struct pci_bus *child;
> -		list_for_each_entry(child, &bus->children, node)
> +		list_for_each_entry(child, &host->bus->children, node)
>  			pcie_bus_configure_settings(child);
>  	}
>  }
Two things: Firstly, the function uses hose throughout, not host.
Secondly, you're not deleting the bus variable: what's the purpose of
this change?

Regards,
Daniel

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 860 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/3fafd5a7/attachment.sig>
