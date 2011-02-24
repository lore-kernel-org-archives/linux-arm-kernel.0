From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 24 Feb 2011 15:28:02 +0100 (CET)
Subject: [PATCH v4 1/2] PRUSS UIO driver support
In-Reply-To: <1298556402-26456-2-git-send-email-pratheesh@ti.com>
References: <1298556402-26456-1-git-send-email-pratheesh@ti.com>
	<1298556402-26456-2-git-send-email-pratheesh@ti.com>
Message-ID: <alpine.LFD.2.00.1102241510450.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Feb 2011, Pratheesh Gangadhar wrote:

A few nits.

> +static void pruss_cleanup(struct platform_device *dev, struct uio_info *info)
> +{
> +	struct uio_info *p = info;
> +	int cnt;
> +
> +	for (cnt = 0; cnt < MAX_PRUSS_EVT; cnt++, p++) {
> +		uio_unregister_device(p);
> +		kfree(p->name);
> +	}
> +	iounmap(prussio_vaddr);
> +	if (ddr_vaddr) 
> +		dma_free_coherent(&dev->dev, info->mem[2].size,
> +			info->mem[2].internal_addr, info->mem[2].addr);

That is easier to read with curly braces even if they are strictly not
necessary

	if (ddr_vaddr) {
		dma_free_coherent(&dev->dev, info->mem[2].size,
			info->mem[2].internal_addr, info->mem[2].addr);
	}


> +	kfree(info);
> +	clk_put(pruss_clk);
> +}
> +	len = resource_size(regs_ddr);
> +	ddr_vaddr =
> +	dma_alloc_coherent(&dev->dev, len, &ddr_paddr, GFP_KERNEL | GFP_DMA);

That wants to be:
     
	ddr_vaddr = dma_alloc_coherent(&dev->dev, len, &ddr_paddr,
					GFP_KERNEL | GFP_DMA);

Otherwise this looks very clean and readable now and I can't spot any
technical problems with it anymore.

Please fixup the nits and feel free to add

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for following up on all this!

       tglx
