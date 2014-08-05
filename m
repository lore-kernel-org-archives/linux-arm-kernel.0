From: pintu.k@outlook.com (Pintu Kumar)
Date: Tue, 5 Aug 2014 20:24:50 +0530
Subject: [linux-3.10.17] Could not allocate memory from free CMA areas
In-Reply-To: <003201cfafb3$3fe43180$bfac9480$@lge.com>
References: <54sabdnxop04vxd7ewndc0qf.1407077745645@email.android.com>,
 <003201cfafb3$3fe43180$bfac9480$@lge.com>
Message-ID: <BAY169-W348ADD9113F32C2B459631EFE30@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> From: iamjoonsoo.kim at lge.com
> To: pintu_agarwal at yahoo.com; linux-mm at kvack.org; linux-arm-kernel at lists.infradead.org; linaro-mm-sig at lists.linaro.org; ritesh.list at gmail.com
> CC: pintu.k at outlook.com; pintu.k at samsung.com; vishu_1385 at yahoo.com; m.szyprowski at samsung.com; mina86 at mina86.com; ngupta at vflare.org; iqbalblr at gmail.com
> Subject: RE: [linux-3.10.17] Could not allocate memory from free CMA areas
> Date: Mon, 4 Aug 2014 16:11:00 +0900
> 
>> Dear Joonsoo,
>> 
>> I tried your changes which are present at the below link. 
>> https://github.com/JoonsooKim/linux/tree/cma-fix-up-v3.0-next-20140625
>> But unfortunately for me it did not help much. 
>> After running various apps that uses ION nonmovable memory, it fails to allocate memory after some time. When I see the pagetypeinfo shows lots of CMA pages available and non-movable were very less and thus nonmovable allocation were failing.
> 
> Okay. CMA pages cannot be used for nonmovable memory, so it can fail in above case.
> 
>> However I noticed the failure was little delayed.
> 
> It is good sign. I guess that there is movable/CMA ratio problem.
> My patchset uses free CMA pages in certain ratio to free movable page consumption.
> If your system doesn't use movable page sufficiently, free CMA pages cannot
> be used fully. Could you test with following workaround?
> 
> +       if (normal> cma) {
> +               zone->max_try_normal = pageblock_nr_pages;
> +               zone->max_try_cma = pageblock_nr_pages;
> +       } else {
> +               zone->max_try_normal = pageblock_nr_pages;
> +               zone->max_try_cma = pageblock_nr_pages;
> +       }

I applied these changes but still the allocations are failing because there are no non-movable memory left in the system.
With the changes I noticed that nr_cma_free sometimes becomes almost zero.
But in our case Display/Xorg needs to have atleast 8MB of CMA (contiguous) memory of order-8 and order-4 type.
CMA:56MB is shared across display,camera,video etc.

I think the previous changes are slightly better.

My concern is that whether I am applying all you changes or missing some thing.
I saw that your kernel version is based on next-20140625 but my kernel version is 3.10.17.
And till now I applied only the below changes:
https://github.com/JoonsooKim/linux/commit/33a0416b3ac1cd7c88e6b35ee61b4a81a7a14afc 

But I haven't applied this:
https://github.com/JoonsooKim/linux/commit/166b4186d101b190cf50195d841e2189f2743649
(CMA: always treat free cma pages as non-free on watermark checking)
These changes have other dependencies which is not present in my kernel version.
Like inclusion of ALLOC_FAIR and area->nr_cma_free.
Please let me know if these changes are also important for "aggressive alloc changes..."

If possible please send me all the patches related to "aggressive cma.." so that I can conclude on my experiment.

Further I will share the experimental result from my side.


> 
> Thanks.
> 
 		 	   		  
