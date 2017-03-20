From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 20 Mar 2017 05:14:29 -0500
Subject: [PATCH v3] irqchip/gicv3-its: Avoid memory over allocation for
 ITEs
In-Reply-To: <24159fb4-0438-9f9e-9e28-6ac573f6b6f6@arm.com>
References: <1488896720-6223-1-git-send-email-shankerd@codeaurora.org>
 <b74f8fbb-0d9a-b1e2-83d2-ba9c1a858222@arm.com>
 <f91e706e-c0b1-cf38-484a-1965435ad5bb@codeaurora.org>
 <24159fb4-0438-9f9e-9e28-6ac573f6b6f6@arm.com>
Message-ID: <f2c25e72-d62a-55dd-1594-1781b52f9d5c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 03/17/2017 10:33 AM, Marc Zyngier wrote:
> On 17/03/17 14:18, Shanker Donthineni wrote:
>> Hi Marc,
>>
>>
>> On 03/17/2017 08:50 AM, Marc Zyngier wrote:
>>> On 07/03/17 14:25, Shanker Donthineni wrote:
>>>> We are always allocating extra 255Bytes of memory to handle ITE
>>>> physical address alignment requirement. The kmalloc() satisfies
>>>> the ITE alignment since the ITS driver is requesting a minimum
>>>> size of ITS_ITT_ALIGN bytes.
>>>>
>>>> Let's try to allocate the exact amount of memory that is required
>>>> for ITEs to avoid wastage.
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> ---Hi 
>>>> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
>>>> v3: changed from IITE to ITE.
>>>>
>>>>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 86bd428..5aeca78 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -1329,8 +1329,13 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>>  	 */
>>>>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>>>>  	sz = nr_ites * its->ite_size;
>>>> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
>>>> +	sz = max(sz, ITS_ITT_ALIGN);
>>>>  	itt = kzalloc(sz, GFP_KERNEL);
>>>> +	if (itt && !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
>>>> +		kfree(itt);
>>>> +		itt = kzalloc(sz + ITS_ITT_ALIGN - 1, GFP_KERNEL);
>>>> +	}
>>>> +
>>> Is this really worth the complexity? Are you aware of a system where the
>>> accumulation of overallocation actually shows up as being an issue?
>> As such there is no issue with over allocation. Actually this change masked QDF2400 bug 'iirqchip/gicv3-its: Add workaround for QDF2400 ITS erratum 0065' till now, found and fixed recently while looking at the code for possible memory optimizations.
>>  
>>> If you want to be absolutely exact in your allocation, then I'd suggest
>>> doing it all the time, and have a proper dedicated allocator that always
>>> do the right thing, without a wasteful fallback like you still have here.
>> We don't need to fallbak, and it can be removed safely. Looking for
>> your suggestion. should I implement a dedicated allocator or remove
>> fallbak for simpler code?
> Are you saying that kmalloc is guaranteed to give us something that is
> 256 byte aligned? If so, why do we test for alignment (with free +
> over-allocate if it fails)?

I've verified on my system kmalloc() is always allocating memory with 256bytes alignment. kmalloc() uses the generic slab caches available in the kernel to allocate memory based on the input size.

> I'd rather have only one way of allocating the ITT. Either we always
> overallocate in order to guarantee right alignment (and my personal view
> is that for most system, this doesn't matter at all), or we create our
> own allocator. The issue with the latter is that we don't really have a
> good story for allocating arrays of objects with a given alignment
> (kmem_cache_* only deals with single objects).

Adding a dedicated function to allocate memory is preferable but need pull a few of lines of code.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a27a074..f0125e5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -90,6 +90,8 @@ struct its_node {
        u32                     ite_size;
        u32                     device_ids;
        int                     numa_node;
+       struct page             *ite_page;
+       u32                     ite_psz;
 };

 #define ITS_ITT_ALIGN          SZ_256
@@ -266,7 +268,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
        u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);

        itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
-       itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);

        its_encode_cmd(cmd, GITS_CMD_MAPD);
        its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -1319,6 +1320,42 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
        return true;
 }

+static void *its_alloc_memory_ites(struct its_node *its, int nr_ites)
+{
+       unsigned long flags;
+       struct page *page;
+       void *ite;
+       u32 size;
+
+       size = ALIGN(nr_ites * its->ite_size, ITS_ITT_ALIGN);
+       raw_spin_lock_irqsave(&its->lock, flags);
+
+       /* Try to reuse the current page if enough space is available */
+       if (size > its->ite_psz) {
+               /* Allocate a new compound page with minimum order 1 */
+               page = alloc_pages(GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
+                                  max(get_order(size), 1));
+               if (!page) {
+                       raw_spin_unlock_irqrestore(&its->lock, flags);
+                       return NULL;
+               }
+
+               /* Free current page, decrement page count */
+               if (its->ite_page)
+                       put_page(its->ite_page);
+               its->ite_psz = PAGE_ORDER_TO_SIZE(compound_order(page));
+               its->ite_page = page;
+       }
+
+       get_page(its->ite_page); /* increment page count */
+       its->ite_psz -= size;    /* update free space  */
+       ite = page_address(its->ite_page) + its->ite_psz;
+       raw_spin_unlock_irqrestore(&its->lock, flags);
+       gic_flush_dcache_to_poc(ite, size);
+
+       return ite;
+}
+
 static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
                                            int nvecs)
 {
@@ -1330,7 +1367,6 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
        int lpi_base;
        int nr_lpis;
        int nr_ites;
-       int sz;

        if (!its_alloc_device_table(its, dev_id))
                return NULL;
@@ -1342,22 +1378,22 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
         * express an ITT with a single entry.
         */
        nr_ites = max(2UL, roundup_pow_of_two(nvecs));
-       sz = nr_ites * its->ite_size;
-       sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-       itt = kzalloc(sz, GFP_KERNEL);
+       itt = its_alloc_memory_ites(its, nr_ites);
+       if (!itt)
+               return NULL;
+
        lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
        if (lpi_map)
                col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);

-       if (!dev || !itt || !lpi_map || !col_map) {
+       if (!dev || !lpi_map || !col_map) {
                kfree(dev);
-               kfree(itt);
+               put_page(virt_to_page(itt));
                kfree(lpi_map);
                kfree(col_map);
                return NULL;
        }

-       gic_flush_dcache_to_poc(itt, sz);

        dev->its = its;
        dev->itt = itt;
@@ -1386,7 +1422,7 @@ static void its_free_device(struct its_device *its_dev)
        raw_spin_lock_irqsave(&its_dev->its->lock, flags);
        list_del(&its_dev->entry);
        raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
-       kfree(its_dev->itt);
+       put_page(virt_to_page(its_dev->itt));
        kfree(its_dev);
 }



-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
