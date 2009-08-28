From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 28 Aug 2009 12:19:49 +0900
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <4A967FB0.8090502@billgatliff.com>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<4A967FB0.8090502@billgatliff.com>
Message-ID: <20090828031949.GF3928@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

On Thu, Aug 27, 2009 at 07:44:32AM -0500, Bill Gatliff wrote:
> Jinsung Yang wrote:
>> The second problem is that even though same family, the features like the
>> memory map and internal devices (IPs) are very different.  For example,
>> s5p6442 and s5pc110 have different arm core, but internal devices are very
>> similar. 
>>
>> Otherwise, although s5p6440 and s5p6442 are in the same family, architecture
>> and similar names, internal devices are very different.  It makes to be hard
>> to integrate codes in a same platform directory.
>
> The AT91 and AVR32 SoCs have the same problem: very different cores  
> (different instruction set architectures, actually), but compatible  
> peripherals.  Their solution has been to embrace the platform and other  
> device models heavily, which I think is the appropriate one.  I think  
> this approach will work for you as well.

I think the existing s3c (mainline and samsung tree) and s5p (samsung tree)
is already using the device model and platform devices quite extensively - much
due to Ben Dooks great work in that area.

All that is in the plat-X and are
* the actual platform devices for the various integrated peripherals (IPs)
* the clock structure
* dma support
* gpio support
* irq support
* core power management support

There are no real 'drivers' in those directories, at least unless you call the
DMA and VIC support a driver.

The actual drivers for the IPs are all in the driver/ directory, and they are
using different platform device names (in case of completely different hardware)
or platform_data to define which variant of an otherwise similar IP is used.

However, even in this core platform/arch code, there is a lot of copy+paste
going on if we extend the current model.  Samsung has a 2.6.29 derived kernel
branch that does this, and you will see many files that are copied from
plat-s5p64xx into plat-s5pc1xx, and later into plat-s5pc110.

I hope later today we can push that tree to git.kernel.org.  Anyone who's
interested can then look at it and see that it is far from being optimal.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
