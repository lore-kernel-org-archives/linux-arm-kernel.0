From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 4 Aug 2014 16:11:00 +0900
Subject: [linux-3.10.17] Could not allocate memory from free CMA areas
In-Reply-To: <54sabdnxop04vxd7ewndc0qf.1407077745645@email.android.com>
References: <54sabdnxop04vxd7ewndc0qf.1407077745645@email.android.com>
Message-ID: <003201cfafb3$3fe43180$bfac9480$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Dear Joonsoo,
> 
> I tried your changes which are present at the below link. 
> https://github.com/JoonsooKim/linux/tree/cma-fix-up-v3.0-next-20140625
> But unfortunately for me it did not help much. 
> After running various apps that uses ION nonmovable memory, it fails to allocate memory after some time. When I see the pagetypeinfo shows lots of CMA pages available and non-movable were very less and thus nonmovable allocation were failing.

Okay. CMA pages cannot be used for nonmovable memory, so it can fail in above case.

> However I noticed the failure was little delayed.

It is good sign. I guess that there is movable/CMA ratio problem.
My patchset uses free CMA pages in certain ratio to free movable page consumption.
If your system doesn't use movable page sufficiently, free CMA pages cannot
be used fully. Could you test with following workaround?

+       if (normal > cma) {
+               zone->max_try_normal = pageblock_nr_pages;
+               zone->max_try_cma = pageblock_nr_pages;
+       } else {
+               zone->max_try_normal = pageblock_nr_pages;
+               zone->max_try_cma = pageblock_nr_pages;
+       }

Thanks.
