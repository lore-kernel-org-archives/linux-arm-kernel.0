From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jan 2016 09:33:26 +0100
Subject: [Question] cacheline sharing problem on DMA for custom outer-cache
In-Reply-To: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
References: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
Message-ID: <134552368.ft0oU8iHdY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 January 2016 11:36:30 Masahiro Yamada wrote:
> 
> When only L1-cache is enabled, it is OK.
> 
> 
> If L2 is also enabled,
> kmalloc() & dma_map_single() could be a cacheline sharing problem.
> 
> 
> Is there any good solution?

kmalloc uses ARCH_KMALLOC_MINALIGN alignment, so we need to tweak that
in one form or another.


The relevant definitions I see are

#define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
#define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
#define L1_CACHE_SHIFT          CONFIG_ARM_L1_CACHE_SHIFT
#define L1_CACHE_BYTES          (1 << L1_CACHE_SHIFT)

I think you should check all other uses of L1_CACHE_SHIFT and L1_CACHE_BYTES.
If this is the only one that needs to be adjusted, we can change the
definition of ARCH_DMA_MINALIGN, otherwise we may have to add a platform
specific option to CONFIG_ARM_L1_CACHE_SHIFT.

I see a couple of suspicious uses of the L1 cache line size:

drivers/net/ethernet/broadcom/cnic.c:   data->rx.cache_line_alignment_log_size = L1_CACHE_SHIFT;
drivers/net/ethernet/qlogic/qede/qede.h:#define QEDE_RX_ALIGN_SHIFT             max(6, min(8, L1_CACHE_SHIFT))
lib/dma-debug.c:#define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
drivers/net/ethernet/sfc/tx.c:#define EFX_PIOBUF_SIZE_DEF ALIGN(256, L1_CACHE_BYTES)
drivers/net/wireless/ath/ath6kl/init.c:         skb_reserve(skb, reserved - L1_CACHE_BYTES);
include/linux/iio/iio.h:#define IIO_ALIGN L1_CACHE_BYTES
include/linux/mlx5/driver.h:    MLX5_DB_PER_PAGE = PAGE_SIZE / L1_CACHE_BYTES,

Those need closer inspection, and I'm sure there are a couple more. Maybe
they should use ARCH_DMA_MINALIGN instead of L1_CACHE_BYTES. There are also
lots of instances that assume L1_CACHE_BYTES is the L1 line size, not L2,
but they are typically only for performance optimization through prefetching,
so having it set too big will only make it slower rather than incorrect.

	Arnd
