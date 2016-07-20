From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jul 2016 11:09:28 +0200 (CEST)
Subject: [PATCH v11 10/10] genirq/msi: use the MSI doorbell's IOVA when
 requested
In-Reply-To: <1468933367-23159-11-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-11-git-send-email-eric.auger@redhat.com>
Message-ID: <alpine.DEB.2.11.1607201105310.3564@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, Eric Auger wrote:

First of all - valid for all patches:

Subject: sys/subsys: Sentence starts with an uppercase letter

Now for this particular one:

genirq/msi: use the MSI doorbell's IOVA when requested

> On MSI message composition we now use the MSI doorbell's IOVA in
> place of the doorbell's PA in case the device is upstream to an
> IOMMU that requires MSI addresses to be mapped. The doorbell's
> allocation and mapping happened on an early stage (pci_enable_msi).

This changelog is completely useless. At least I cannot figure out what that
patch actually does. And the implementation is not self explaining either.
 
> @@ -63,10 +63,18 @@ static int msi_compose(struct irq_data *irq_data,
>  {
>  	int ret = 0;
>  
> -	if (erase)
> +	if (erase) {
>  		memset(msg, 0, sizeof(*msg));
> -	else
> +	} else {
> +		struct device *dev;
> +
>  		ret = irq_chip_compose_msi_msg(irq_data, msg);
> +		if (ret)
> +			return ret;
> +
> +		dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
> +		WARN_ON(iommu_msi_msg_pa_to_va(dev, msg));

What the heck is this call doing? And why is there only a WARN_ON and not a
proper error return code handling?

Thanks,

	tglx
