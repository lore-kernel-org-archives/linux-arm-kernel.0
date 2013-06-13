From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 13 Jun 2013 19:18:58 +0530
Subject: [PATCH 3/3] ARM: OMAP: dma: Fix the kfree ordering
In-Reply-To: <20130613131647.GS21614@n2100.arm.linux.org.uk>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com>
 <1371128960-24822-4-git-send-email-rnayak@ti.com>
 <20130613131647.GS21614@n2100.arm.linux.org.uk>
Message-ID: <51B9CDCA.9010901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013 06:46 PM, Russell King - ARM Linux wrote:
> On Thu, Jun 13, 2013 at 06:39:20PM +0530, Rajendra Nayak wrote:
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index 8a71f75..8e16503 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -2111,8 +2111,8 @@ exit_dma_irq_fail:
>>  	}
>>  
>>  exit_dma_lch_fail:
>> -	kfree(p);
>>  	kfree(d);
>> +	kfree(p);
> 
> Err.
> 
>         p = pdev->dev.platform_data;
>         d                       = p->dma_attr;
> 
> Why is it kfree'ing platform data in the first place?  This means that
> a failed bind can't be reattempted later.  It also means that an unbind
> plus rebind in userspace will free the platform data leaving stale
> pointers behind.

Right, I just seemed to have overlooked the fact that p was pointing to
platform data. Will remove all the kfree(p) and kfree(d) across the
driver (I just realized this is also the case in .remove)

> 
> This is totally nonsense.  Don't kfree() data in your driver which you
> haven't allocated yourself!
> 
