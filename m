From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Aug 2017 12:51:56 +0200
Subject: [PATCH net] PCI: fix the return value for the
 pci_find_pcie_root_port()
In-Reply-To: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
References: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <20170817105156.GA18789@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 10:25:30AM +0800, Ding Tianhong wrote:
> The pci_find_pcie_root_port() would return NULL if the given
> dev is already a Root Port, it looks like unfriendly to the
> PCIe Root Port device, Thierry and Bjorn suggest to let this
> function return the given dev under this circumstances.
> 
> Fixes: 0e405232871d6 ("PCI: fix oops when try to find Root Port for a PCI device")
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7e2022f..352bb53 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -514,7 +514,7 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
>   */
>  struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
>  {
> -	struct pci_dev *bridge, *highest_pcie_bridge = NULL;
> +	struct pci_dev *bridge, *highest_pcie_bridge = dev;
>  
>  	bridge = pci_upstream_bridge(dev);
>  	while (bridge && pci_is_pcie(bridge)) {

I think this should actually be this change on top of a revert of commit
0e405232871d6 ("PCI: fix oops when try to find Root Port for a PCI
device"). After the above change, the previous fix will have a redundant
check because highest_pcie_bridge will never be NULL.

Let me send out that version to clarify what I mean.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/f8503237/attachment.sig>
