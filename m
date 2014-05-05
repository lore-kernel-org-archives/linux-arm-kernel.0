From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 May 2014 17:43:24 -0400
Subject: [PATCH v3 5/7] ARM: dma: Use dma_pfn_offset for dma address
 translation
In-Reply-To: <20140505195040.GE3693@n2100.arm.linux.org.uk>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <1398353407-2345-6-git-send-email-santosh.shilimkar@ti.com>
 <20140502145852.GC3693@n2100.arm.linux.org.uk> <5363B42C.4010404@ti.com>
 <20140505195040.GE3693@n2100.arm.linux.org.uk>
Message-ID: <536805FC.8090406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 03:50 PM, Russell King - ARM Linux wrote:
> On Fri, May 02, 2014 at 11:05:16AM -0400, Santosh Shilimkar wrote:
>> On Friday 02 May 2014 10:58 AM, Russell King - ARM Linux wrote:
>>> On Thu, Apr 24, 2014 at 11:30:05AM -0400, Santosh Shilimkar wrote:
>>>>  static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
>>>>  {
>>>> -	return (void *)__bus_to_virt((unsigned long)addr);
>>>> +	if (!dev)
>>>> +		return (void *)__bus_to_virt((unsigned long)addr);
>>>> +	else
>>>> +		return (void *)__bus_to_virt(__pfn_to_bus(dma_to_pfn(dev, addr)));
>>>
>>> This is quite horrendous.  There's easier ways to do this...  I assume
>>> you haven't looked at the assembler resulting from this at all with
>>> stuff like the p2v patching enabled?
>>>
>> I haven't. Will check.
> 
> 	if (dev) {
> 		unsigned long pfn = dma_to_pfn(dev, addr);
> 
> 		return phys_to_virt(__pfn_to_phys(pfn));
> 	}
> 
> 	return (void *)__bus_to_virt((unsigned long)addr);
> 
Thanks a lot Russell. Updated patch below for archive records.

>From 97a6f063270265d03ffcb010b9dc156b274631e7 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 24 Apr 2014 11:30:05 -0400
Subject: [PATCH v3 5/7] ARM: dma: Use dma_pfn_offset for dma address
 translation

In most of cases DMA addresses can be performed using offset value of
 Bus address space relatively to physical address space as following:

PFN->DMA:
 __pfn_to_phys(pfn + [-]dma_pfn_offset)

DMA->PFN:
 __phys_to_pfn(dma_addr) + [-]dma_pfn_offset

Thanks to Russell King for suggesting the optimised macro's for
conversion.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/dma-mapping.h |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index e701a4d..b0c79fd 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -58,21 +58,37 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
 #ifndef __arch_pfn_to_dma
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
+	if (dev)
+		pfn -= dev->dma_pfn_offset;
 	return (dma_addr_t)__pfn_to_bus(pfn);
 }
 
 static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
-	return __bus_to_pfn(addr);
+	unsigned long pfn = __bus_to_pfn(addr);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
+	return pfn;
 }
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
+	if (dev) {
+		unsigned long pfn = dma_to_pfn(dev, addr);
+
+		return phys_to_virt(__pfn_to_phys(pfn));
+	}
+
 	return (void *)__bus_to_virt((unsigned long)addr);
 }
 
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
+	if (dev)
+		return pfn_to_dma(dev, virt_to_pfn(addr));
+
 	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
 }
 
-- 
1.7.9.5
