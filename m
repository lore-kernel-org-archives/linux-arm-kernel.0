From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2017 14:32:06 +0000
Subject: [PATCHv2 net-next 06/16] net: mvpp2: adjust the allocation/free
 of BM pools for PPv2.2
In-Reply-To: <1482943592-12556-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170106143206.GD14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 05:46:22PM +0100, Thomas Petazzoni wrote:
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +	if (priv->hw_version == MVPP22) {

Maybe
	if (sizeof(dma_addr_t) > sizeof(u32) && priv->hw_version == MVPP22) {

to get better compile coverage?

> +		u32 val;
> +		u32 paddr_highbits;
> +
> +		val = mvpp2_read(priv, MVPP2_BM_ADDR_HIGH_ALLOC);
> +		paddr_highbits = (val & MVPP2_BM_ADDR_HIGH_PHYS_MASK);
> +
> +		*paddr |= (dma_addr_t)paddr_highbits << 32;
> +		*vaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *paddr));
> +	}
> +#endif
> +}
> +
>  /* Free all buffers from the pool */
>  static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  			       struct mvpp2_bm_pool *bm_pool)
> @@ -3616,10 +3671,8 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  		dma_addr_t buf_phys_addr;
>  		unsigned long vaddr;
>  
> -		/* Get buffer virtual address (indirect access) */
> -		buf_phys_addr = mvpp2_read(priv,
> -					   MVPP2_BM_PHY_ALLOC_REG(bm_pool->id));
> -		vaddr = mvpp2_read(priv, MVPP2_BM_VIRT_ALLOC_REG);
> +		mvpp2_bm_bufs_get_addrs(dev, priv, bm_pool,
> +					&buf_phys_addr, &vaddr);
>  
>  		dma_unmap_single(dev, buf_phys_addr,
>  				 bm_pool->buf_size, DMA_FROM_DEVICE);
> @@ -3651,7 +3704,7 @@ static int mvpp2_bm_pool_destroy(struct platform_device *pdev,
>  	val |= MVPP2_BM_STOP_MASK;
>  	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(bm_pool->id), val);
>  
> -	dma_free_coherent(&pdev->dev, sizeof(u32) * bm_pool->size,
> +	dma_free_coherent(&pdev->dev, bm_pool->size_bytes,
>  			  bm_pool->virt_addr,
>  			  bm_pool->phys_addr);
>  	return 0;
> @@ -3787,8 +3840,19 @@ static inline void mvpp2_bm_pool_put(struct mvpp2_port *port, int pool,
>  				     dma_addr_t buf_phys_addr,
>  				     unsigned long buf_virt_addr)
>  {
> -	mvpp2_write(port->priv, MVPP2_BM_VIRT_RLS_REG, buf_virt_addr);
> -	mvpp2_write(port->priv, MVPP2_BM_PHY_RLS_REG(pool), buf_phys_addr);
> +#if defined(CONFIG_ARCH_DMA_ADDR_T_64BIT)
> +	u32 val;
> +
> +	val = upper_32_bits(buf_phys_addr) & MVPP22_BM_ADDR_HIGH_PHYS_RLS_MASK;
> +	val |= (upper_32_bits(buf_virt_addr) &
> +		MVPP22_BM_ADDR_HIGH_VIRT_RLS_MASK)
> +		<< MVPP22_BM_ADDR_HIGH_VIRT_RLS_SHIFT;
> +	mvpp2_write(port->priv, MVPP22_BM_ADDR_HIGH_RLS_REG, val);
> +#endif

Similar compile-time conditional?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
