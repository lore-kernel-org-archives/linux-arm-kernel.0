From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Apr 2014 09:36:47 -0400
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <20140412084630.GT16119@n2100.arm.linux.org.uk>
References: <53487A9E.70805@ti.com>
 <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
 <20140412002401.GS16119@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1404112036470.980@knanqh.ubzr> <534893F8.30309@ti.com>
 <20140412084630.GT16119@n2100.arm.linux.org.uk>
Message-ID: <534BE46F.2070201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 April 2014 04:46 AM, Russell King - ARM Linux wrote:
> On Fri, Apr 11, 2014 at 09:16:40PM -0400, Santosh Shilimkar wrote:
>> +	if (mem_start < KEYSTONE_HIGH_PHYS_START ||
>> +	    mem_end   > KEYSTONE_HIGH_PHYS_END) {
>> +		pr_crit("Invalid address space for memory (%08llx-%08llx)\n",
>> +		      (u64)mem_start, (u64)mem_end);
>> +	}
>> +
>> +	offset += KEYSTONE_HIGH_PHYS_START;
>> +	__pv_phys_offset = offset;
> 
> Right, so this will create a link error, and needs to become:
> 
Yep and I did fix that by using __pv_phys_pfn_offset

> 	__pv_phys_pfn_offset = offset >> PAGE_SHIFT;
> 
But I missed to convert it to pfn and that was the issue.
Thanks.

Regards,
Santosh
