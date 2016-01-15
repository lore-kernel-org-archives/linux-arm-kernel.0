From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Jan 2016 11:36:30 +0900
Subject: [Question] cacheline sharing problem on DMA for custom outer-cache
Message-ID: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


Documentation/DMA-API-HOWTO.txt states as follows.

--------------->8---------------------
Even if those classes of
memory could physically work with DMA, you'd need to ensure the I/O
buffers were cacheline-aligned.  Without that, you'd see cacheline
sharing problems (data corruption) on CPUs with DMA-incoherent caches.
(The CPU could write to one word, DMA would write to a different one
in the same cache line, and one of them could be overwritten.)
---------------8<-----------------------


The UniPhier SoC series (ARM SoC) uses
its own custom outer-cache, not the one from ARM Ltd.
(arch/arm/mm/cache-uniphier.c)

Its line-size is 128 byte.


As far as I tested on my board, the memory allocated by kmalloc()
is 64byte-aligned.
(the kernel image is configured with multi_v7_defconfig)


For example,
  a = kmalloc(1, GFP_KERNEL);
  b = kmalloc(1, GFP_KERNEL);
  printk("a=%p, b=%p\n", a, b);

shows console log as follows

  a=ee5db9c0, b=ee5dba00





When only L1-cache is enabled, it is OK.


If L2 is also enabled,
kmalloc() & dma_map_single() could be a cacheline sharing problem.


Is there any good solution?


-- 
Best Regards
Masahiro Yamada
