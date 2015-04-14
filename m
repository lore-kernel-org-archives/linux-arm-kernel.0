From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 10:43:03 +0200
Subject: [PATCH] dmaengine: xgene-dma: Fix sparse wannings and coccinelle
 warnings
In-Reply-To: <1428995040-11815-1-git-send-email-rsahu@apm.com>
References: <1428995040-11815-1-git-send-email-rsahu@apm.com>
Message-ID: <4208569.BKk8XynHVe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 12:34:00 Rameshwar Prasad Sahu wrote:
> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> index aa61935..59f95db 100755
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -238,10 +238,10 @@
>         dev_err(chan->dev, "%s: " fmt, chan->name, ##arg)
> 
>  struct xgene_dma_desc_hw {
> -       u64 m0;
> -       u64 m1;
> -       u64 m2;
> -       u64 m3;
> +       __le64 m0;
> +       __le64 m1;
> +       __le64 m2;
> +       __le64 m3;
>  };

This part looks good.

>  enum xgene_dma_ring_cfgsize {
> @@ -388,12 +388,12 @@ static bool is_pq_enabled(struct xgene_dma *pdma)
>         return !(val & XGENE_DMA_PQ_DISABLE_MASK);
>  }
> 
> -static void xgene_dma_cpu_to_le64(u64 *desc, int count)
> +static void xgene_dma_cpu_to_le64(struct xgene_dma_desc_hw *desc)
>  {
> -       int i;
> -
> -       for (i = 0; i < count; i++)
> -               desc[i] = cpu_to_le64(desc[i]);
> +       desc->m0 = cpu_to_le64(((u64 *)desc)[0]);
> +       desc->m1 = cpu_to_le64(((u64 *)desc)[1]);
> +       desc->m2 = cpu_to_le64(((u64 *)desc)[2]);
> +       desc->m3 = cpu_to_le64(((u64 *)desc)[3]);
>  }

This part does not: you are circumventing the checks that are supposed
to help you here, and make things harder to read in the process.

>  static u16 xgene_dma_encode_len(u32 len)
> @@ -499,9 +499,9 @@ static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,
> 
>  skip_additional_src:
>         /* Hardware stores descriptor in little endian format */
> -       xgene_dma_cpu_to_le64(desc1, 4);
> +       xgene_dma_cpu_to_le64(desc1);
>         if (desc2)
> -               xgene_dma_cpu_to_le64(desc2, 4);
> +               xgene_dma_cpu_to_le64(desc2);
>  }
> 
>  static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
> @@ -540,8 +540,8 @@ static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
>         }
> 
>         /* Hardware stores descriptor in little endian format */
> -       xgene_dma_cpu_to_le64(desc1, 4);
> -       xgene_dma_cpu_to_le64(desc2, 4);
> +       xgene_dma_cpu_to_le64(desc1);
> +       xgene_dma_cpu_to_le64(desc2);
> 
>         /* Update meta data */
>         *nbytes = len;

All these calls should just be removed, and the accesses to the descriptor
get changed to be little-endian. You can use the opportunity to remove
a lot of the macros that make the code harder to understand, and open-code
them like this:

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index aa61935ee706..3e3854559ecc 100755
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -446,12 +446,12 @@ static void *xgene_dma_lookup_ext8(u64 *desc, int idx)
 	return (idx % 2) ? (desc + idx - 1) : (desc + idx + 1);
 }
 
-static void xgene_dma_init_desc(void *desc, u16 dst_ring_num)
+static void xgene_dma_init_desc(struct xgene_dma_desc_hw *desc, u16 dst_ring_num)
 {
-	XGENE_DMA_DESC_C_SET(desc); /* Coherent IO */
-	XGENE_DMA_DESC_IN_SET(desc);
-	XGENE_DMA_DESC_H0ENQ_NUM_SET(desc, dst_ring_num);
-	XGENE_DMA_DESC_RTYPE_SET(desc, XGENE_DMA_RING_OWNER_DMA);
+	desc->m1 |= cpu_to_le64(XGENE_DMA_DESC_C_BIT);
+	desc->m0 |= cpu_to_le64(XGENE_DMA_DESC_IN_BIT);
+	desc->m3 |= cpu_to_le64(dst_ring_num << XGENE_DMA_DESC_HOENQ_NUM_POS);
+	desc->m0 |= cpu_to_le64(dst_ring_num << XGENE_DMA_RING_OWNER_DMA);
 }
 

which will store the descriptors in the right format with correct endianess,
make use of the sparse checking and let the reader see what's actually
going on.

	Arnd
