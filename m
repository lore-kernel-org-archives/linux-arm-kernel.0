From: csd@broadcom.com (Christian Daudt)
Date: Fri, 3 May 2013 10:13:42 -0700
Subject: [PATCH V2] ARM: bcm281xx: Add L2 support for Rev A2 chips
In-Reply-To: <20130503085100.GA6188@mudshark.cambridge.arm.com>
References: <1367542653-955-1-git-send-email-csd@broadcom.com>
 <20130503085100.GA6188@mudshark.cambridge.arm.com>
Message-ID: <5183F046.9020802@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-03 01:51 AM, Will Deacon wrote:
> Hi Christian,
>
> On Fri, May 03, 2013 at 01:57:33AM +0100, Christian Daudt wrote:
>> Rev A2 SoCs have an unorthodox memory re-mapping and this needs
>> to be reflected in the cache operations.
>> This patch adds new outer cache functions for the l2x0 driver
>> to support this SoC revision. It also adds a new compatible
>> value for the cache to enable this functionality.
>>
>> Updates from V1:
>> - remove section 1 altogether and note that in comments
>> - simplify section selection caused by section 1 removal
>> - BUG_ON just in case section 1 shows up
> Looking much better now :)
>
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index c465fac..d70e0ab 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -523,6 +523,147 @@ static void aurora_flush_range(unsigned long start, unsigned long end)
>>   	}
>>   }
>>   
>> +/*
>> + * For certain Broadcom SoCs, depending on the address range, different offsets
>> + * need to be added to the address before passing it to L2 for
>> + * invalidation/clean/flush
>> + *
>> + * Section Address Range              Offset        EMI
>> + *   1     0x00000000 - 0x3FFFFFFF    0x80000000    VC
>> + *   2     0x40000000 - 0xBFFFFFFF    0x40000000    SYS
>> + *   3     0xC0000000 - 0xFFFFFFFF    0x80000000    VC
> I don't think you answered last time (or I missed it) but where is the RAM
> in the physical memory map for boards with this L2 controller? Do you
> actually have 3GB at 0x40000000?
There can be up to 1G for VC and 1G for SYS. Usually that translates to 
0x80000000-0xFFFFFFFF

  thanks,
    csd
