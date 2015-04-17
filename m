From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 10:49:32 +0200
Subject: [PATCH v3] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
In-Reply-To: <1429212673-22254-1-git-send-email-rsahu@apm.com>
References: <1429212673-22254-1-git-send-email-rsahu@apm.com>
Message-ID: <2380806.YAnOxsf686@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 01:01:13 Rameshwar Prasad Sahu wrote:
> v3 changes:
> 	* Minor changes in length setting in DMA descriptor
> 
> v2 changes:
> 	* Code cleanup
> 	* Changed way of setting DMA descriptors for big-endian
> 
> This patch fixes compilation sparse warnings like incorrect type in assignment
> (different base types), cast to restricted __le64, symbol
> '__UNIQUE_ID_author__COUNTER__' has multiple initializers etc and
> coccinelle warnings (No need to set .owner here. The core will do it.)
> 
> This patch is based on slave-dma / for-linus branch.
> (commit: 9f2fd0dfa594d857fbdaeda523ff7a46f16567f5 [26/28]
> 	dmaengine: Add support for APM X-Gene SoC DMA engine driver)
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

Looks good now,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

There is one small enhancement that you could still do and I'll shut up after
that ;-)

> 
> -static void *xgene_dma_lookup_ext8(u64 *desc, int idx)
> +static __le64 *xgene_dma_lookup_ext8(struct xgene_dma_desc_hw *desc, int idx)
>  {
> -	return (idx % 2) ? (desc + idx - 1) : (desc + idx + 1);
> +	switch (idx) {
> +	case 0:
> +		return &desc->m1;
> +	case 1:
> +		return &desc->m0;
> +	case 2:
> +		return &desc->m3;
> +	case 3:
> +		return &desc->m2;
> +	default:
> +		pr_err("Invalid dma descriptor index\n");
> +	}
> +
> +	return NULL;
>  }
> 
...

>  	/* Set 1st to 5th source addresses */
>  	for (i = 0; i < src_cnt; i++) {
>  		len = *nbytes;
> -		xgene_dma_set_src_buffer((i == 0) ? (desc1 + 8) :
> +		xgene_dma_set_src_buffer((i == 0) ? &desc1->m1 :
>  					 xgene_dma_lookup_ext8(desc2, i - 1),
>  					 &len, &src[i]);
> -		XGENE_DMA_DESC_MULTI_SET(desc1, scf[i], i);
> +		desc1->m2 |= cpu_to_le64((scf[i] << ((i + 1) * 8)));
>  	}

If you just unroll this loop, you get code that is smaller and easier to
understand:

	/* Set 1st to 5th source addresses */
	xgene_dma_set_src_buffer(&desc1->m1, &len, &src[0]);
	xgene_dma_set_src_buffer(&desc2->m0, &len, &src[1]);
	xgene_dma_set_src_buffer(&desc2->m3, &len, &src[2]);
	xgene_dma_set_src_buffer(&desc2->m2, &len, &src[3]);
	desc1->m2 |= cpu_to_le64(scf[0] | scf[1] << 8 | scf[2] << 16 | scf[3] << 24);

	Arnd
