From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 31 Oct 2010 20:00:34 +0100
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit
	5bc23d32d
In-Reply-To: <20101031183140.GA30636@n2100.arm.linux.org.uk>
References: <20101031182157.GY15069@ibawizard.net>
	<20101031183140.GA30636@n2100.arm.linux.org.uk>
Message-ID: <20101031190034.GZ15069@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> [2010-10-31 18:31:40]:

> On Sun, Oct 31, 2010 at 07:21:57PM +0100, Petr ?tetiar wrote:
> > The allocation of the 4th buffer fails here and goes to nospc label. When I've
> > reverted commit mentioned in the subject:
> > 
> >     Revert "ARM: DMA coherent allocator: align remapped addresses"
> >     
> >     This reverts commit 5bc23d32d86a132b5636a48dca0fa2528ef69ff9.
> > 
> > the driver can now allocate the buffers and seems to work on 2.6.36. How to
> > proceed now? I know, that the driver is pile of crap, but it works for me(tm)
> > quite well on 2.6.34.7, so I don't know how to fix this. Thank you for any
> > suggestions.
> 
> It might be worth adding a printk to find out what entries get allocated
> and freed from the vmregion.

Patch:

diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
index 19e09bd..1150335 100644
--- a/arch/arm/mm/vmregion.c
+++ b/arch/arm/mm/vmregion.c
@@ -47,6 +47,8 @@ arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)
                goto out;
        }
 
+       printk("arm_vmregion_alloc() size: %x\n", size);
+
        new = kmalloc(sizeof(struct arm_vmregion), gfp);
        if (!new)
                goto out;
@@ -71,11 +73,14 @@ arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)
        new->vm_start = addr;
        new->vm_end = addr + size;
        new->vm_active = 1;
+       printk("arm_vmregion_alloc() found: start: %lu end: %lu size: %x\n",
+              new->vm_start, new->vm_end, size);
 
        spin_unlock_irqrestore(&head->vm_lock, flags);
        return new;
 
  nospc:
+       printk("arm_vmregion_alloc() no space!\n");
        spin_unlock_irqrestore(&head->vm_lock, flags);
        kfree(new);
  out:
@@ -124,6 +129,10 @@ void arm_vmregion_free(struct arm_vmregion_head *head, struct arm_vmregion *c)
        unsigned long flags;
 
        spin_lock_irqsave(&head->vm_lock, flags);
+
+       printk("arm_vmregion_free() start: %lu end: %lu size: %lu\n",
+              c->vm_start, c->vm_end, c->vm_end-c->vm_start);
+
        list_del(&c->vm_list);
        spin_unlock_irqrestore(&head->vm_lock, flags);

Without the revert:

	root at ts72xx:~# ifup ra0
	WPA: Configuring Interface
	[   30.900000] arm_vmregion_alloc() size: 33000
	[   30.910000] arm_vmregion_alloc() found: start: 4291297280 end: 4291506176 size: 33000
	[   30.920000] arm_vmregion_alloc() size: 33000
	[   30.930000] arm_vmregion_alloc() found: start: 4291821568 end: 4292030464 size: 33000
	[   30.940000] arm_vmregion_alloc() size: 33000
	[   30.950000] arm_vmregion_alloc() found: start: 4292345856 end: 4292554752 size: 33000
	[   30.960000] arm_vmregion_alloc() size: 33000
	[   30.970000] arm_vmregion_alloc() no space!
	[   30.970000] <-- ERROR in Alloc TX TxContext[3] HTTX_BUFFER !!

With revert:

	root at ts72xx:~# ifup ra0
	WPA: Configuring Interface
	[   31.740000] arm_vmregion_alloc() size: 33000
	[   31.740000] arm_vmregion_alloc() found: start: 4290789376 end: 4290998272 size: 33000
	[   31.760000] arm_vmregion_alloc() size: 33000
	[   31.760000] arm_vmregion_alloc() found: start: 4290998272 end: 4291207168 size: 33000
	[   31.780000] arm_vmregion_alloc() size: 33000
	[   31.780000] arm_vmregion_alloc() found: start: 4291207168 end: 4291416064 size: 33000
	[   31.790000] arm_vmregion_alloc() size: 33000
	[   31.810000] arm_vmregion_alloc() found: start: 4291416064 end: 4291624960 size: 33000
	[   31.820000] arm_vmregion_alloc() size: 1000
	[   31.820000] arm_vmregion_alloc() found: start: 4291624960 end: 4291629056 size: 1000
	[   31.820000] arm_vmregion_alloc() size: 1000
	[   31.840000] arm_vmregion_alloc() found: start: 4291629056 end: 4291633152 size: 1000
	[   31.840000] arm_vmregion_alloc() size: 1000
	[   31.860000] arm_vmregion_alloc() found: start: 4291633152 end: 4291637248 size: 1000
	[   31.870000] arm_vmregion_alloc() size: 1000
	[   31.870000] arm_vmregion_alloc() found: start: 4291637248 end: 4291641344 size: 1000
	[   31.880000] arm_vmregion_alloc() size: 1000
	[   31.880000] arm_vmregion_alloc() found: start: 4291641344 end: 4291645440 size: 1000
	[   31.900000] arm_vmregion_alloc() size: 6000
	[   31.900000] arm_vmregion_alloc() found: start: 4291645440 end: 4291670016 size: 6000
	[   31.920000] arm_vmregion_alloc() size: 6000
	[   31.930000] arm_vmregion_alloc() found: start: 4291670016 end: 4291694592 size: 6000
	[   31.940000] arm_vmregion_alloc() size: 6000
	[   31.940000] arm_vmregion_alloc() found: start: 4291694592 end: 4291719168 size: 6000
	[   31.950000] arm_vmregion_alloc() size: 6000
	[   31.950000] arm_vmregion_alloc() found: start: 4291719168 end: 4291743744 size: 6000
	[   31.970000] arm_vmregion_alloc() size: 6000
	[   31.970000] arm_vmregion_alloc() found: start: 4291743744 end: 4291768320 size: 6000
	[   31.990000] arm_vmregion_alloc() size: 6000
	[   32.000000] arm_vmregion_alloc() found: start: 4291768320 end: 4291792896 size: 6000
	[   32.010000] arm_vmregion_alloc() size: 6000
	[   32.010000] arm_vmregion_alloc() found: start: 4291792896 end: 4291817472 size: 6000
	[   32.020000] arm_vmregion_alloc() size: 6000
	[   32.020000] arm_vmregion_alloc() found: start: 4291817472 end: 4291842048 size: 6000

	$ ifdown ra0

	root@ts72xx:~# ifdown ra0
	[  102.080000] ---> RTMPFreeTxRxRingMemory
	[  102.080000] arm_vmregion_free() start: 4291645440 end: 4291670016 size: 24576
	[  102.090000] arm_vmregion_free() start: 4291670016 end: 4291694592 size: 24576
	[  102.100000] arm_vmregion_free() start: 4291694592 end: 4291719168 size: 24576
	[  102.110000] arm_vmregion_free() start: 4291719168 end: 4291743744 size: 24576
	[  102.120000] arm_vmregion_free() start: 4291743744 end: 4291768320 size: 24576
	[  102.130000] arm_vmregion_free() start: 4291768320 end: 4291792896 size: 24576
	[  102.140000] arm_vmregion_free() start: 4291792896 end: 4291817472 size: 24576
	[  102.150000] arm_vmregion_free() start: 4291817472 end: 4291842048 size: 24576
	[  102.160000] arm_vmregion_free() start: 4291641344 end: 4291645440 size: 4096
	[  102.170000] arm_vmregion_free() start: 4291633152 end: 4291637248 size: 4096
	[  102.180000] arm_vmregion_free() start: 4291637248 end: 4291641344 size: 4096
	[  102.190000] arm_vmregion_free() start: 4291624960 end: 4291629056 size: 4096
	[  102.200000] arm_vmregion_free() start: 4291629056 end: 4291633152 size: 4096
	[  102.210000] arm_vmregion_free() start: 4290789376 end: 4290998272 size: 208896
	[  102.220000] arm_vmregion_free() start: 4290998272 end: 4291207168 size: 208896
	[  102.230000] arm_vmregion_free() start: 4291207168 end: 4291416064 size: 208896
	[  102.240000] arm_vmregion_free() start: 4291416064 end: 4291624960 size: 208896

-- ynezz
