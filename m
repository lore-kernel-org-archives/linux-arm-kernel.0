From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Aug 2015 10:14:25 +0200
Subject: [PATCH] ARM: l2c: fix support for HW coherent systems in PL310
 cache
In-Reply-To: <20150811172620.GK23307@e104818-lin.cambridge.arm.com>
References: <1439312743-6237-1-git-send-email-gregory.clement@free-electrons.com>
 <20150811172620.GK23307@e104818-lin.cambridge.arm.com>
Message-ID: <55CB0061.2010602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 11/08/2015 19:26, Catalin Marinas wrote:
> On Tue, Aug 11, 2015 at 07:05:43PM +0200, Gregory CLEMENT wrote:
>> From: Nadav Haklai <nadavh@marvell.com>
>>
>> When a PL310 cache is used in a system that provides hardware
>> coherency, the entire outer cache operations are useless, and can be
>> skipped.  Moreover, on some systems, it is harmful as it causes
>> deadlocks between the Marvell coherency mechanism, the Marvell PCIe
>> controller and the Cortex-A9.
>>
>> This commit extends a previous commit:
>> 98ea2dba65932ffc456b6d7b11b8a0624e2f7b95 which added the io-coherent
>> support for the PL310 cache by also disabling the outer cache flush
>> range operation.
>>
>> In the current kernel implementation, the outer cache flush range
>> operation is triggered by the dma_alloc function.
>> This operation can be take place during runtime and in some
>> circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
>> SoCs.
> 
> While this may work around the issue for your specific SoC, I think a
> better fix is in DMA alloc code to avoid flushing caches for coherent
> devices. This would be the __dma_clear_buffer() implementation which
> isn't aware of whether the device is coherent or not.

Indeed, the other use of the outer cache flush range is done pretty
early in the boot and should not be a problem.

What do you think of the following patch?

I am not totally happy with it because I added a variable to a struct
dedicated for the outer cache functions. But using a function at the
l2cc driver level would be too much. At the opposite we could directly
set a boolean from the l2cc driver. From my point of view it would
violate the layer but I might be wrong.


Thanks,

Gregory



 arch/arm/include/asm/outercache.h | 9 +++++++++
 arch/arm/mm/cache-l2x0.c          | 1 +
 arch/arm/mm/dma-mapping.c         | 6 ++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 563b92fc2f41..7f7bbfcf1d32 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -35,6 +35,7 @@ struct outer_cache_fns {
 	void (*sync)(void);
 #endif
 	void (*resume)(void);
+	bool is_coherent;

 	/* This is an ARM L2C thing */
 	void (*write_sec)(unsigned long, unsigned);
@@ -56,6 +57,14 @@ static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
 }

 /**
+ * outer_is_coherent - tell if the outer cache is io coherent
+ */
+static inline bool outer_is_coherent(void)
+{
+	return outer_cache.is_coherent;
+}
+
+/**
  * outer_clean_range - clean dirty outer cache lines
  * @start: starting physical address, inclusive
  * @end: end physical address, exclusive
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 71b3d3309024..0071e276adc0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1291,6 +1291,7 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
 		.flush_all   = l2c210_flush_all,
 		.disable     = l2c310_disable,
 		.resume      = l2c310_resume,
+		.is_coherent = true,
 	},
 };

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ced8a0f7a52..4d87df2c16f9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -241,12 +241,14 @@ static void __dma_clear_buffer(struct page *page, size_t size)
 			page++;
 			size -= PAGE_SIZE;
 		}
-		outer_flush_range(base, end);
+		if (!outer_is_coherent())
+			outer_flush_range(base, end);
 	} else {
 		void *ptr = page_address(page);
 		memset(ptr, 0, size);
 		dmac_flush_range(ptr, ptr + size);
-		outer_flush_range(__pa(ptr), __pa(ptr) + size);
+		if (!outer_is_coherent())
+			outer_flush_range(__pa(ptr), __pa(ptr) + size);
 	}
 }

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
