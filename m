From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 14 Feb 2013 13:37:45 -0800
Subject: [PATCH 1/2] drivers: dma-contiguous: clean source code and prepare
 for device tree
In-Reply-To: <1360845928-8107-2-git-send-email-m.szyprowski@samsung.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <1360845928-8107-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <511D5929.6060004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2/14/2013 4:45 AM, Marek Szyprowski wrote:
> This patch cleans the initialization of dma contiguous framework. The
> all-in-one dma_declare_contiguous() function is now separated into
> dma_contiguous_reserve_area() which only steals the the memory from
> memblock allocator and dma_contiguous_add_device() function, which
> assigns given device to the specified reserved memory area. This improves
> the flexibility in defining contiguous memory areas and assigning device
> to them, because now it is possible to assign more than one device to
> the given contiguous memory area. This split in initialization is also
> required for upcoming device tree support.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   drivers/base/dma-contiguous.c        |  210 +++++++++++++++++++++-------------
>   include/asm-generic/dma-contiguous.h |    4 +-
>   include/linux/dma-contiguous.h       |   32 +++++-
>   3 files changed, 161 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 0ca5442..085389c 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -39,7 +39,33 @@ struct cma {
>   	unsigned long	*bitmap;
>   };
>
> -struct cma *dma_contiguous_default_area;
> +static DEFINE_MUTEX(cma_mutex);
> +
> +struct cma *dma_contiguous_def_area;
> +phys_addr_t dma_contiguous_def_base;
> +
> +static struct cma_area {
> +	phys_addr_t base;
> +	unsigned long size;
> +	struct cma *cma;
> +} cma_areas[MAX_CMA_AREAS] __initdata;
> +static unsigned cma_area_count __initdata;
> +

cma_areas and cma_area_count are accessed from cma_get_area which gets 
called from cma_assign_device_from_dt. You need to drop the __initdata 
since the notifier can be called at anytime.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
