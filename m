From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 18 Jan 2016 21:05:15 +0900
Subject: [Question] cacheline sharing problem on DMA for custom outer-cache
In-Reply-To: <134552368.ft0oU8iHdY@wuerfel>
References: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
 <134552368.ft0oU8iHdY@wuerfel>
Message-ID: <CAK7LNAQBJbjx4koGjkKHo1Xe9NKC-dCj_0TP6AiT=3eaPTYdoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2016-01-15 17:33 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 15 January 2016 11:36:30 Masahiro Yamada wrote:
>>
>> When only L1-cache is enabled, it is OK.
>>
>>
>> If L2 is also enabled,
>> kmalloc() & dma_map_single() could be a cacheline sharing problem.
>>
>>
>> Is there any good solution?
>
> kmalloc uses ARCH_KMALLOC_MINALIGN alignment, so we need to tweak that
> in one form or another.
>
>
> The relevant definitions I see are
>
> #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
> #define L1_CACHE_SHIFT          CONFIG_ARM_L1_CACHE_SHIFT
> #define L1_CACHE_BYTES          (1 << L1_CACHE_SHIFT)

Thanks for this clue.

By increasing CONFIG_ARM_L1_CACHE_SHIFT by 1, now I can solve the issue locally,
but it would be better if there existed a solution that can be upstreamed.


> I think you should check all other uses of L1_CACHE_SHIFT and L1_CACHE_BYTES.
> If this is the only one that needs to be adjusted, we can change the
> definition of ARCH_DMA_MINALIGN, otherwise we may have to add a platform
> specific option to CONFIG_ARM_L1_CACHE_SHIFT.

L1_CACHE_BYTES is not a configuration.  It is a hardware property.

Actually, Tegra is the only hardware that has L1 cache with 64byte line-size.

The other SoCs in multi_v7_defconfig run software configured for
64byte line-size
on CPUs with 32byte line-size.  Weird.


And, deciding the DMA aligment only with L1 line-size does not seem nice.
I admit the outer-cache on my SoC is odd, though.



> I see a couple of suspicious uses of the L1 cache line size:
>
> drivers/net/ethernet/broadcom/cnic.c:   data->rx.cache_line_alignment_log_size = L1_CACHE_SHIFT;
> drivers/net/ethernet/qlogic/qede/qede.h:#define QEDE_RX_ALIGN_SHIFT             max(6, min(8, L1_CACHE_SHIFT))
> lib/dma-debug.c:#define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
> drivers/net/ethernet/sfc/tx.c:#define EFX_PIOBUF_SIZE_DEF ALIGN(256, L1_CACHE_BYTES)
> drivers/net/wireless/ath/ath6kl/init.c:         skb_reserve(skb, reserved - L1_CACHE_BYTES);
> include/linux/iio/iio.h:#define IIO_ALIGN L1_CACHE_BYTES
> include/linux/mlx5/driver.h:    MLX5_DB_PER_PAGE = PAGE_SIZE / L1_CACHE_BYTES,


Hmm, this is too advanced for me to check drivers I am unfamiliar with...


> Those need closer inspection, and I'm sure there are a couple more. Maybe
> they should use ARCH_DMA_MINALIGN instead of L1_CACHE_BYTES. There are also
> lots of instances that assume L1_CACHE_BYTES is the L1 line size, not L2,
> but they are typically only for performance optimization through prefetching,
> so having it set too big will only make it slower rather than incorrect.

My SoC is a member of multi_v7_defconfig.
I wonder if it is accepted to make other SoCs slower.


If we could parse "line-size" DT-property in the early stage
and change the DMA alignment run-time, it would avoid degrading
performance on other SoCs.



-- 
Best Regards
Masahiro Yamada
