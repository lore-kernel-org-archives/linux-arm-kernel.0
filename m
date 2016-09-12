From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 12 Sep 2016 16:44:32 -0500
Subject: [PATCH v1] iov: add return failure condition for pci_setup_device
In-Reply-To: <1472455681-18827-1-git-send-email-po.liu@nxp.com>
References: <1472455681-18827-1-git-send-email-po.liu@nxp.com>
Message-ID: <20160912214432.GD23532@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 03:28:01PM +0800, Po Liu wrote:
> If pci_setup_device() return failure, return failure directly in the
> pci_iov_add_virtfn().
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>

Applied to pci/virtualization for v4.9, thanks!

> ---
>  drivers/pci/iov.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 2194b44..e30f05c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -136,7 +136,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
>  	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>  	virtfn->vendor = dev->vendor;
>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
> -	pci_setup_device(virtfn);
> +	rc = pci_setup_device(virtfn);
> +	if (rc)
> +		goto failed0;
> +
>  	virtfn->dev.parent = dev->dev.parent;
>  	virtfn->physfn = pci_dev_get(dev);
>  	virtfn->is_virtfn = 1;
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
