From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 03 Dec 2015 17:22:37 +0100
Subject: [PATCH] drivers: dma-coherent: free memory when failed to init
 DMA memory pool
In-Reply-To: <20151203153937.GP8644@n2100.arm.linux.org.uk>
References: <1449138962-8264-1-git-send-email-b38611@freescale.com>
 <xa1toae7y9u8.fsf@mina86.com>
 <CY1PR0301MB12257F63F594E65DE67E64DFF50D0@CY1PR0301MB1225.namprd03.prod.outlook.com>
 <20151203153937.GP8644@n2100.arm.linux.org.uk>
Message-ID: <xa1t1tb3y01e.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03 2015, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2015 at 01:54:05PM +0000, Duan Andy wrote:
>> From: Mike Nazarewicz <mpn@google.com> Sent: Thursday, December 03, 2015 8:51 PM
>> > To: Duan Fugang-B38611; torvalds at linux-foundation.org;
>> > gregkh at linuxfoundation.org; m.szyprowski at samsung.com
>> > Cc: linux-arm-kernel at lists.infradead.org; arnd at arndb.de;
>> > iamjoonsoo.kim at lge.com; Duan Fugang-B38611
>> > Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed to
>> > init DMA memory pool
>> > 
>> > On Thu, Dec 03 2015, Fugang Duan wrote:
>> > > Free dma coherent memory when it failed to init DMA memory pool after
>> > > calling .dma_init_coherent_memory(), otherwise it causes memmory leak.
>> > >
>> > > Signed-off-by: Fugang Duan <B38611@freescale.com>
>> > > ---
>> > >  drivers/base/dma-coherent.c | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
>> > > index 55b8398..beb6bbe 100644
>> > > --- a/drivers/base/dma-coherent.c
>> > > +++ b/drivers/base/dma-coherent.c
>> > > @@ -286,6 +286,7 @@ static int rmem_dma_device_init(struct reserved_mem
>> > *rmem, struct device *dev)
>> > >  				     &mem) != DMA_MEMORY_MAP) {
>> > >  		pr_err("Reserved memory: failed to init DMA memory pool
>> > at %pa, size %ld MiB\n",
>> > >  			&rmem->base, (unsigned long)rmem->size / SZ_1M);
>> > > +		kfree(mem);
>> > 
>> > mem == NULL at this point.  If dma_init_coherent_memory doesn?t return
>> > DMA_MEMORY_MAP, mem pointer is not assigned any value.  If you think
>> > there is a memory leak, please demonstrate a path of it happening.
>> > 
>> Kfree() will check mem NULL condition, so no need to add check in here.
>
> That isn't what the reviewer was stating.
>
> However, had the reviewer looked at the existing code, then he may have
> stated a different opinion. :)

I?m not sure that I would.  Here?s code I?m looking at:


static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_addr,
			     size_t size, int flags,
			     struct dma_coherent_mem **mem)
{
	struct dma_coherent_mem *dma_mem = NULL;
	void __iomem *mem_base = NULL;
	int pages = size >> PAGE_SHIFT;
	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);

	if ((flags & (DMA_MEMORY_MAP | DMA_MEMORY_IO)) == 0)
		goto out;
	if (!size)
		goto out;

	mem_base = ioremap(phys_addr, size);
	if (!mem_base)
		goto out;

	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
	if (!dma_mem)
		goto out;
	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
	if (!dma_mem->bitmap)
		goto out;

	dma_mem->virt_base = mem_base;
	dma_mem->device_base = device_addr;
	dma_mem->pfn_base = PFN_DOWN(phys_addr);
	dma_mem->size = pages;
	dma_mem->flags = flags;
	spin_lock_init(&dma_mem->spinlock);

	/**************************************************************/
	/* Here's the only place where mem is set to non-NULL value.  */
	/**************************************************************/
	*mem = dma_mem;

	if (flags & DMA_MEMORY_MAP)
		/******************************************************/
		/* Here's where function returns.                     */
		/******************************************************/
		return DMA_MEMORY_MAP;

	return DMA_MEMORY_IO;

out:
	kfree(dma_mem);
	if (mem_base)
		iounmap(mem_base);
	return 0;
}

static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
{
	struct dma_coherent_mem *mem = rmem->priv;

	if (!mem &&
	    /**********************************************************/
	    /* Note that flags & DMA_MEMORY_MAP is non-zero.          */
	    /**********************************************************/
	    dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
				     DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
				     &mem) != DMA_MEMORY_MAP) {
		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
			&rmem->base, (unsigned long)rmem->size / SZ_1M);
		return -ENODEV;
	}
	rmem->priv = mem;
	dma_assign_coherent_memory(dev, mem);
	return 0;
}


> When you look at the existing code, there are three possible return
> values from dma_init_coherent_memory():
>
> - zero, which means failure, and the mem pointer is left alone.  In
>   the above code, we know that it's guaranteed to be NULL, as we
>   won't get into the if() unless it was.
> - DMA_MEMORY_IO, which would mean that mem points at a kmalloc()d
>   chunk of memory, and this case is treated as failure because we
>   want memory.

No.  This never happens in the code that is being patched.  flags &
DMA_MEMORY_MAP is non-zero thus dma_init_coherent_memory returns
DMA_MEMORY_MAP.

> - DMA_MEMORY_MAP, which also means that mem points at a kmalloc()d
>   chunk of memory, which we treat as success.
>
> So, in the case of DMA_MEMORY_IO,

Which never happens.

> we have a failure case where the kmalloc'd memory is dropped on the
> floor - aka a memory leak.


To me it seems that a better patch would be the following (not tested in
any capacity):


>From 49cece0c0a052022022776f2555d26308deba959 Mon Sep 17 00:00:00 2001
From: Michal Nazarewicz <mina86@mina86.com>
Date: Thu, 3 Dec 2015 17:15:07 +0100
Subject: [PATCH] drivers: dma-coherent: simplify dma_init_coherent_memory
 return value

Since only dma_declare_coherent_memory cares about
dma_init_coherent_memory returning part of flags as it return value,
move the condition to the former and simplify the latter.  This in turn
makes rmem_dma_device_init less confusing.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 drivers/base/dma-coherent.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

\o/ negative delta.

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 55b8398..87b8083 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -17,9 +17,9 @@ struct dma_coherent_mem {
 	spinlock_t	spinlock;
 };
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_addr,
-			     size_t size, int flags,
-			     struct dma_coherent_mem **mem)
+static bool dma_init_coherent_memory(
+	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
+	struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
 	void __iomem *mem_base = NULL;
@@ -50,17 +50,13 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
 	spin_lock_init(&dma_mem->spinlock);
 
 	*mem = dma_mem;
-
-	if (flags & DMA_MEMORY_MAP)
-		return DMA_MEMORY_MAP;
-
-	return DMA_MEMORY_IO;
+	return true;
 
 out:
 	kfree(dma_mem);
 	if (mem_base)
 		iounmap(mem_base);
-	return 0;
+	return false;
 }
 
 static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -88,15 +84,13 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
 	struct dma_coherent_mem *mem;
-	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, flags,
-				       &mem);
-	if (ret == 0)
+	if (!dma_init_coherent_memory(phys_addr, device_addr, size, flags,
+				      &mem))
 		return 0;
 
 	if (dma_assign_coherent_memory(dev, mem) == 0)
-		return ret;
+		return flags & DMA_MEMORY_MAP ? DMA_MEMORY_MAP : DMA_MEMORY_IO;
 
 	dma_release_coherent_memory(mem);
 	return 0;
@@ -281,9 +275,9 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 
 	if (!mem &&
-	    dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
-				     DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
-				     &mem) != DMA_MEMORY_MAP) {
+	    !dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+				      DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE,
+				      &mem)) {
 		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
 		return -ENODEV;
-- 
2.6.0.rc2.230.g3dd15c0

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  ??? ?mina86? ??????  (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
