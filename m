From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 23 May 2017 12:57:15 +0200
Subject: [PATCH] ARM64: PCI: Fix struct acpi_pci_root_ops allocation
 failure path
In-Reply-To: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
References: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
Message-ID: <6cf59b3d-0450-eac9-9597-0e42080820b7@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.05.2017 17:48, Lorenzo Pieralisi wrote:
> From: Timmy Li <lixiaoping3@huawei.com>
>
> Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
> per-controller basis") added code to allocate ACPI PCI root_ops
> dynamically on a per host bridge basis but failed to update the
> corresponding memory allocation failure path in pci_acpi_scan_root()
> leading to a potential memory leakage.
>
> Fix it by adding the required kfree call.
>
> Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-controller basis")
> Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
> [lorenzo.pieralisi at arm.com: refactored code, rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  arch/arm64/kernel/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4f0e3eb..c7e3e63 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -191,8 +191,10 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  		return NULL;
>
>  	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> -	if (!root_ops)
> +	if (!root_ops) {
> +		kfree(ri);
>  		return NULL;
> +	}
>
>  	ri->cfg = pci_acpi_setup_ecam_mapping(root);
>  	if (!ri->cfg) {
>

Reviewed-by: Tomasz Nowicki <tn@semihalf.com>

Thanks for fixing this.
Tomasz
