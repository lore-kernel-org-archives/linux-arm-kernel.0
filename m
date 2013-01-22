From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 22 Jan 2013 13:55:56 +0100
Subject: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
In-Reply-To: <20130121180113.GA22517@atomide.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
 <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com>
 <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com>
Message-ID: <50FE8C5C.2030409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 01/21/2013 07:01 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130121 07:09]:
>>>
>> So I looked at this one with help of Rajendra. We can get rid of the
>> IRQ and DMA data(needs DMA biding updates) easily. The address
>> space though is needed since hwmod code uses it to setup the
>> sysconfig registers.
> 
> OK great. The address space tinkering in hwmod code should be
> moved to be done in the drivers.
> 
> As discussed earlier, there should be a driver specific reset
> function driver_xyz_reset() in the driver header file so the
> hwmod code can call it too in a late_initcall if no driver is
> loaded.
> 
>> Extracting that from DT code seems to be really expensive and
>> ugly [1]. I am yet to try out DMA lines removal but that seems
>> to be doable by pulling Vinod'd DMA engine branch and updating
>> DT file.
> 
> The overhead here does not matter as it should only happen in a
> late_initcall and only for some of the drivers. For that to
> happen we just need to go through the list of modules not yet
> probed. We also need to have some locking in the driver specific
> reset function to avoid races with the loadable modules.

Mmm, not really, that address is used by *every* hwmod for sysconfig
access. So iterating over every DT nodes for every hwmods seems pretty
ugly and un-optimized.

That being said, it might worth checking the overhead. That will not
make the fix nicer anyway, but at least it will allow a smooth
transition toward a real clean solution. Assuming someone will work on
that later, which might never happen.

Regards,
Benoit
