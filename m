From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 22 Mar 2011 20:15:27 -0700
Subject: Revert "[ARM] pxa: remove now unnecessary dma_needs_bounce()"
In-Reply-To: <20110322081746.GA17264@n2100.arm.linux.org.uk>
References: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
	<20110321150349.GC4340@n2100.arm.linux.org.uk>
	<AANLkTinVBCpinGfMkFbb_RpJbdAJiuQ57aWjqj5F=FoB@mail.gmail.com>
	<20110322081746.GA17264@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimOi0w3BNW=XURkhuOHpfHof_b834TGmyY5njh7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Mar 21, 2011 at 07:00:57PM -0700, Barry Song wrote:
>> For sa1111, why don't PCB design just connect one sdram to bank0 and
>> make software use bank0 as DMA bank if bank0 is not slower than
>> bank1/2/3? If bank0 is same with bank1/2/3 in hardware timing, there
>> is no reason to make a strange design which uses bank1/2/3 as DMA
>> area.
>
> Who knows why board and SoC designers do silly things. ?If we could stop
> that, the kernel would be *much* simpler.

How about doing something like this to permit chips without strange
issues don't implement dma_needs_bounce() function?  if you are ok, i
can send a full patch:

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index ea5ee4d..f4ef5ac 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -23,6 +23,10 @@ config PL330
 config SA1111
        bool
        select DMABOUNCE if !ARCH_PXA
+       select HAVE_DMA_NEEDS_BOUNCE if !ARCH_PXA
+
+config HAVE_DMA_NEEDS_BOUNCE
+       bool

 config DMABOUNCE
        bool
diff --git a/arch/arm/include/asm/dma-mapping.h
b/arch/arm/include/asm/dma-mapping.h
index 4fff837..baef463 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -277,6 +277,7 @@ extern int dmabounce_register_dev(struct device *,
unsigned long,
  */
 extern void dmabounce_unregister_dev(struct device *);

+#ifdef CONFIG_HAVE_DMA_NEEDS_BOUNCE
 /**
  * dma_needs_bounce
  *
@@ -294,6 +295,12 @@ extern void dmabounce_unregister_dev(struct device *);
  *
  */
 extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
+#else
+static inline int dma_needs_bounce(struct device*, dma_addr_t, size_t)
+{
+       return 0;
+}
+#endif

 /*
  * The DMA API, implemented by dmabounce.c.  See below for descriptions.

>
