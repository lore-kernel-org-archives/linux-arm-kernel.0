From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 22:57:38 +0200
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
In-Reply-To: <20140703225244.50378fa4@free-electrons.com>
References: <20140703135146.GA6898@luxor.wired.org>	<20140703162759.3909592a@free-electrons.com>	<53B5BB85.2070900@free-electrons.com>
 <20140703225244.50378fa4@free-electrons.com>
Message-ID: <53B5C3C2.6080501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> Thanks for reproducing the problem. In my opinion, the problem is in
> drivers/iommu/omap-iommu.c, which gets compiled when
> CONFIG_OMAP_IOMMU=y. This file does:
> 

I was also looking at it

> static int __init omap_iommu_init(void)
> {
>         struct kmem_cache *p;
>         const unsigned long flags = SLAB_HWCACHE_ALIGN;
>         size_t align = 1 << 10; /* L2 pagetable alignement */
> 
>         p = kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, align, flags,
>                               iopte_cachep_ctor);
>         if (!p)
>                 return -ENOMEM;
>         iopte_cachep = p;
> 
>         bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
> 
>         return platform_driver_register(&omap_iommu_driver);
> }
> /* must be ready before omap3isp is probed */
> subsys_initcall(omap_iommu_init);
> 
> So it calls bus_set_iommu() unconditionally, without caring at all
> whether it is running on a platform that actually cares about OMAP
> IOMMU. And then later on, a bus notifier of the IOMMU subsystem gets
> called, and some NULL pointer gets dereferenced. I'm pretty sure that
> if you comment out this subsys_initcall(), you won't see the problem
> anymore.

Indeed I comment it, and I didn't see the problem anymore.


> 
> However, this code has been around since a while, so I don't know if
> it's actually the change that makes it visible. Maybe some other IOMMU
> core internal change makes it actually visible. But this
> subsys_initcall() that does random stuff without caring about the
> platform it runs on anyway looks incorrect.

I think that nobody until now have run this configuration.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
