From: pintu.k@outlook.com (Pintu Kumar)
Date: Sat, 12 Jul 2014 06:57:12 +0530
Subject: [linux-3.10.17] Could not allocate memory from free CMA areas
In-Reply-To: <1404862900.76779.YahooMailNeo@web160102.mail.bf1.yahoo.com>
References: <1404862900.76779.YahooMailNeo@web160102.mail.bf1.yahoo.com>
Message-ID: <BAY169-W80F409CBF18E8FE62CCD1DEF080@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

No reply on the below.

Does anybody came across with the similar issues?
Please let me know if any fixes are already available.

Issues:
1) When free memory pages and CMA free pages are almost equal, min watermark check is failing, resulting in swapping.
2) Almost all the free memory in system is CMA free memory.
3) When ZRAM tries to allocate pages from CMA free areas, the allocation fails.

Please refer below for more details.



Thank you!
Regards,
Pintu



> Date: Tue, 8 Jul 2014 16:41:40 -0700
> From: pintu_agarwal at yahoo.com
> Subject: [linux-3.10.17] Could not allocate memory from free CMA areas
> To: linux-mm at kvack.org; linux-mm at kvack.org; linux-arm-kernel at lists.infradead.org; linaro-mm-sig at lists.linaro.org
> CC: pintu.k at outlook.com; pintu.k at samsung.com; vishu_1385 at yahoo.com; m.szyprowski at samsung.com; mina86 at mina86.com; ngupta at vflare.org; iqbalblr at gmail.com
> 
> Hi,
> 
> We are facing one problem on linux 3.10 when we try to use CMA as large as 56MB for 256MB RAM device.
> We found that after certain point of time (during boot), min watermark check is failing when "free_pages" and "free_cma_pages" are almost equal and falls below the min level.
> 
> system details:
> ARM embedded device: RAM: 256MB
> Kernel version: 3.10.17
> Fixed Reserved memory: ~40MB
> Available memory: 217MB
> CMA reserved 1 : 56MB
> ZRAM configured: 128MB or 64MB
> min_free_kbytes: 1625 (default)
> Memory controller group enabled (MEMCG)
> 
> 
> After boot-up the "free -tm" command shows free memory as: ~50MB
> CMA is used for all UI display purposes. CMA used during bootup is close to ~6MB.
> Thus most of the free memory is in the form of CMA free memory.
> ZRAM getting uses was around ~5MB.
> 
> 
> During boot-up itself we observe that the following conditions are met.
> 
> 
> if (free_pages - free_cma <= min + lowmem_reserve) {
> ??? printk"[PINTU]: __zone_watermark_ok: failed !\n");
> 
> ??? return false;
> }
> Here: free_pages was: 12940, free_cma was: 12380, min: 566, lowmem: 0
> 
> 
> Thus is condition is met most of the time.
> And because of this watermark failure, Kswapd is waking up frequently.
> The /proc/pagetypeinfo reports that most of the higher order pages are from CMA regions.
> 
> 
> We also observed that ZRAM is trying to allocate memory from CMA region and failing.
> 
> We also tried by decreasing the CMA region to 20MB. With this the watermark failure is not happening in boot time. But if we launch more than 3 apps {Browser, music-player etc}, again the watermark started failing.
> 
> Also we tried decreasing the min_free_kbytes=256, and with this also watermark is passed.
> 
> Our observation is that ZRAM/zsmalloc trying to allocate memory from CMA areas and failed.
> 
> 
> Please let us know if anybody have come across the same problem and how to resolve this issue.
> 
> 
> 
> 
> 
> Thank You!
> Regards,
> Pintu
 		 	   		  
