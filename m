From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 24 Oct 2016 13:29:45 -0700
Subject: [PATCH] ahci: use pci_alloc_irq_vectors
In-Reply-To: <20161022141123.GA25500@lst.de>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
 <20161020154722.GH22012@rric.localdomain> <20161021125918.GA18082@lst.de>
 <20161021140106.GU25086@rric.localdomain> <20161022141123.GA25500@lst.de>
Message-ID: <580E6F39.5020207@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2016 07:11 AM, Christoph Hellwig wrote:
> Hi Robert,
>
> is this a controller that's using MSI-X?
>
> If so can you try the patch below?
>

After better understanding your request, I applied this against:

http://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes 
(commit a478b097474cd9f2268ab1beaca74ff09e652b9b)

This is now working on my ThunderX CRB-2S system.

You can add:

Tested-by: David Daney <david.daney@cavium.com>


Thanks for taking the time to work through this.



> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ba5f11c..5fe852d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1617,7 +1617,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		/* legacy intx interrupts */
>   		pci_intx(pdev, 1);
>   	}
> -	hpriv->irq = pdev->irq;
> +	hpriv->irq = pci_irq_vector(pdev, 0);
>
>   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
