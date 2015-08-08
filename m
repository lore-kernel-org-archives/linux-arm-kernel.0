From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 10:22:52 +0100
Subject: [PATCH v5 1/2] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <74fe0b014334a5ac1db90dec46bdbf6c30c07895.1439002338.git.dhdang@apm.com>
References: <CADaLNDkU14GCPZE_zNt_9kMSsUdywyNp1QCiWpokXQgbfRS0qw@mail.gmail.com>
 <74fe0b014334a5ac1db90dec46bdbf6c30c07895.1439002338.git.dhdang@apm.com>
Message-ID: <20150808092252.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 08:18:48PM -0700, Duc Dang wrote:
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 890ad9d..5d03f8b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -93,14 +93,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return -ENODEV;
>  
> -	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
> -	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		return ret;
> -	if (!pdev->dev.dma_mask)
> -		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> -	else
> -		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	/* Try setting the coherent_dma_mask to 64 bits, then try 32 bits */
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +	}

Note that dma_set_mask_and_coherent() and the original code are not
equivalent because of this:

	if (!pdev->dev.dma_mask)
		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;

If we know that pdev->dev.dma_mask will always be initialised at this
point, then the above change is fine.  If not, it's introducing a
regression - dma_set_mask_and_coherent() will fail if pdev->dev.dma_mask
is NULL (depending on the architectures implementation of dma_set_mask()).

Prefixing the above change with the two lines I mention above would
ensure equivalent behaviour.  Even if we do want to get rid of this,
I'd advise to do it as a separate patch after this change, which can
be independently reverted if there's problems with its removal.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
