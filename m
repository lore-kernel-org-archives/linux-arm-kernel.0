From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Tue, 22 Mar 2016 15:53:02 +0530
Subject: [Query]  doubt on parameters passed to dma_map_single_attrs() API
Message-ID: <eedb87e1131d74a77b49599648cc5aac@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

Would like to check whether the dma_map_single_attrs() API, can accept 
ptr variable from high memory or not?
If we pass the memory pointer, which is pointing high memory does not 
work with virt_to_page API.

10 static inline dma_addr_t dma_map_single_attrs(struct device *dev, 
void *ptr,
  11                                               size_t size,
  12                                               enum 
dma_data_direction dir,
  13                                               struct dma_attrs 
*attrs)
  14 {
  15         const struct dma_map_ops *ops = get_dma_ops(dev);
  16         dma_addr_t addr;
  17
  18         kmemcheck_mark_initialized(ptr, size);
  19         BUG_ON(!valid_dma_direction(dir));
  20         addr = ops->map_page(dev, virt_to_page(ptr),
  21                              (unsigned long)ptr & ~PAGE_MASK, size,
  22                              dir, attrs);
<Prasad> using the virt_to_page for the high memory will end up with 
wrong address.
  23         debug_dma_map_page(dev, virt_to_page(ptr),
  24                            (unsigned long)ptr & ~PAGE_MASK, size,
  25                            dir, addr, true);
  26         return addr;
  27 }

The only restriction which is observed that, ptr should point to 
physically contiguous memory.

So can we pass high memory mapped address to dma_map_single API or not?

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
