From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Jun 2013 11:04:22 +0200
Subject: [PATCH v1] ARM: DMA-mapping: mark all !DMA_TO_DEVICE pages in
 unmapping as clean
In-Reply-To: <1368590989-5433-1-git-send-email-ming.lei@canonical.com>
References: <1368590989-5433-1-git-send-email-ming.lei@canonical.com>
Message-ID: <51C17416.60601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 5/15/2013 6:09 AM, Ming Lei wrote:
> It is common for one sg to include many pages, so mark all these
> pages as clean to avoid unnecessary flushing on them in
> set_pte_at() or update_mmu_cache().
>
> The patch might improve loading performance of applciation code a bit.
>
> On the below test code to read file(~1GByte size) from usb mass storage
> disk to buffer created with mmap(PROT_READ | PROT_EXEC) on
> Pandaboard, average ~1% improvement can be observed with the patch on
> 10 times test.
>
> unsigned int sum = 0;
>
> static unsigned long tv_diff(struct timeval *tv1, struct timeval *tv2)
> {
> 	return (tv2->tv_sec - tv1->tv_sec) * 1000000 +
> 		(tv2->tv_usec - tv1->tv_usec);
> }
>
> int main(int argc, char *argv[])
> {
> 	char *mbuffer;
> 	int fd;
> 	int i;
> 	unsigned long page_size, size;
> 	struct stat stat;
> 	struct timeval t1, t2;
>
> 	page_size = getpagesize();
> 	fd = open(argv[1], O_RDONLY);
> 	assert(fd >= 0);
>
> 	fstat(fd, &stat);
> 	size = stat.st_size;
> 	printf("%s: file %s, file size %lu, page size %lu\n", argv[0],
> 		read_filename, size, page_size);
>
> 	gettimeofday(&t1, NULL);
> 	mbuffer = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
> 	for (i = 0 ; i < size ; i += page_size)
> 		sum += mbuffer[i];
> 	munmap(mbuffer, page_size);
> 	gettimeofday(&t2, NULL);
> 	printf("\tread mmaped time: %luus\n", tv_diff(&t1, &t2));
>
> 	close(fd);
> }
>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Thanks for proving this patch. I'm really sorry for a late reply. I've 
applied it to my dma-mapping tree.

> ---
> v1:
> 	- fix one mistake on computing pfn, pointed out by Nicolas
>
>   arch/arm/mm/dma-mapping.c |   20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ef3e0f3..c038ec0 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -880,10 +880,24 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
>   	dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
>   
>   	/*
> -	 * Mark the D-cache clean for this page to avoid extra flushing.
> +	 * Mark the D-cache clean for these pages to avoid extra flushing.
>   	 */
> -	if (dir != DMA_TO_DEVICE && off == 0 && size >= PAGE_SIZE)
> -		set_bit(PG_dcache_clean, &page->flags);
> +	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
> +		unsigned long pfn;
> +		size_t left = size;
> +
> +		pfn = page_to_pfn(page) + off / PAGE_SIZE;
> +		off %= PAGE_SIZE;
> +		if (off) {
> +			pfn++;
> +			left -= PAGE_SIZE - off;
> +		}
> +		while (left >= PAGE_SIZE) {
> +			page = pfn_to_page(pfn++);
> +			set_bit(PG_dcache_clean, &page->flags);
> +			left -= PAGE_SIZE;
> +		}
> +	}
>   }
>   
>   /**

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
