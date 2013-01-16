From: subhashj@codeaurora.org (Subhash Jadavani)
Date: Wed, 16 Jan 2013 18:17:08 +0530
Subject: ARM DMA: Fix in dma_cache_maint_page
In-Reply-To: <50F69F72.4030807@codeaurora.org>
References: <50F69F72.4030807@codeaurora.org>
Message-ID: <50F6A14C.6040206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Is it possible to pick up James patch below? Thread here: 
http://comments.gmane.org/gmane.linux.kernel.mmc/18670, have the details 
on the motivation behind this fix.

Regards,
Subhash

-------- Original Message --------
Subject: 	Re: [PATCH v2 1/1] block: blk-merge: don't merge the pages 
with non-contiguous descriptors
Date: 	Wed, 16 Jan 2013 18:09:14 +0530
From: 	Subhash Jadavani <subhashj@codeaurora.org>
To: 	James Bottomley <James.Bottomley@HansenPartnership.com>
CC: 	linux-kernel at vger.kernel.org, linux-scsi at vger.kernel.org, 
linux-mmc at vger.kernel.org, linux-arm-msm at vger.kernel.org, 
martin.petersen at oracle.com, asias at redhat.com, tj at kernel.org, 
linux-arm-kernel at lists.infradead.org, Russell King <linux@arm.linux.org.uk>



On 1/16/2013 4:02 PM, James Bottomley wrote:
> On Wed, 2013-01-16 at 12:07 +0530, Subhash Jadavani wrote:
>
>> Now consider this call stack from MMC block driver (this is on the ARmv7
>> based board):
>>       [   98.918174] [<c001b50c>] (v7_dma_inv_range+0x30/0x48) from
>> [<c0017b8c>] (dma_cache_maint_page+0x1c4/0x24c)
>>       [   98.927819] [<c0017b8c>] (dma_cache_maint_page+0x1c4/0x24c) from
>> [<c0017c28>] (___dma_page_cpu_to_dev+0x14/0x1c)
>>       [   98.937982] [<c0017c28>] (___dma_page_cpu_to_dev+0x14/0x1c) from
>> [<c0017ff8>] (dma_map_sg+0x3c/0x114)
> OK, so this is showing that ARM itself is making the assumption that the
> pages are contiguous in the page offset map.
>
> Fix this by doing the increment via the pfn, which will do the right
> thing whatever the memory model.
>
> Signed-off-by: James Bottomley <JBottomley@Parallels.com>

Thanks James. Yes, it make sense to fix the ARM code itself if it is the
only one giving this trouble.
I have tried your change below and it also fixes this issue (without
having my blk-merge patch). I will forward your change to Russel King to
see what he thinks about it.

Regards,
Subhash
>
> ---
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6b2fb87..ab88c5b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -809,7 +809,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>   			op(vaddr, len, dir);
>   		}
>   		offset = 0;
> -		page++;
> +		page = pfn_to_page(page_to_pfn(page) + 1);
>   		left -= len;
>   	} while (left);
>   }
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/bcc1625a/attachment-0001.html>
