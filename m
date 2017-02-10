From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 10 Feb 2017 16:16:17 -0600
Subject: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
In-Reply-To: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
Message-ID: <20170210221617.GT29169@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 10:15:04AM +0800, Dennis Chen wrote:
> The __pci_enable_msi_range() should return -ENOSPC instead of -EINVAL
> when the device doesn't have enough vectors as required, just as the 
> MSI-X vector allocator does in __pci_enable_msix_range(). Otherwise, 
> some drivers depending on that return value will probably fallback to
> the legacy interrupt directly, for example, in commit 17a51f12cfbd2814
> ("ahci: only try to use multi-MSI mode if there is more than 1 port"), the
> ahci driver will fallback to single MSI mode only when the return value
> is -ENOSPC in case of required vectors is not enough, else the driver will
> use legacy interrupt which has been observed on a x86 box with 6-port SATA
> controller.
> 
> With this patch, when a MSI-capable device doesn't have enough MSI
> vectors as requested, it will fallback to single MSI mode while not
> legacy interrupt.
> 
> Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: linux-ide at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Applied to pci/msi for v4.11, thanks, Dennis!

> ---
>  drivers/pci/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ad70507..da37113 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1084,7 +1084,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (nvec < 0)
>  		return nvec;
>  	if (nvec < minvec)
> -		return -EINVAL;
> +		return -ENOSPC;
>  
>  	if (nvec > maxvec)
>  		nvec = maxvec;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
