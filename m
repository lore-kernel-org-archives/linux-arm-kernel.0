From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Jun 2017 23:03:54 +0100
Subject: [PATCH] arm64/dma-mapping: Fix null-pointer check
In-Reply-To: <20170610194110.27712-1-ohaugan@codeaurora.org>
References: <20170610194110.27712-1-ohaugan@codeaurora.org>
Message-ID: <20170610220354.GY4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 10, 2017 at 12:41:10PM -0700, Olav Haugan wrote:
> @@ -149,6 +140,11 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  	bool coherent = is_device_dma_coherent(dev);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This re-introduces an instance that you say you're getting rid of...

>  	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
>  
> +	if (!dev) {
> +		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
> +		return NULL;
> +	}
> +
>  	size = PAGE_ALIGN(size);
>  
>  	if (!coherent && !gfpflags_allow_blocking(flags)) {

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
