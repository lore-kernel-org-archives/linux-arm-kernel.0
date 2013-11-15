From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Nov 2013 09:55:50 -0500
Subject: [PATCH 1/6] arm64: mm: Add __virt_to_idmap() to keep kvm build
 happy
In-Reply-To: <20131115133428.GA1217@darko.cambridge.arm.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
 <20131115133428.GA1217@darko.cambridge.arm.com>
Message-ID: <528635F6.6030207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013 08:34 AM, Catalin Marinas wrote:
> On Thu, Nov 14, 2013 at 07:37:41PM +0000, Santosh Shilimkar wrote:
>> ARM kvm code will make use of __virt_to_idmap() on arm32
>> machines as hardware interconnect supported alias of physical
>> memory for idmap purposes. The same code is shared with arm64
>> bit and hence will break the builds. So we add __virt_to_idmap()
>> which is just __virt_to_phys() on arm64 bit to keep build happy.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> BTW, there is normally no space between the Cc and Signed-off-by lines.
>
OK. 
>> ---
>>  arch/arm64/include/asm/memory.h |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 3776217..d9341ee 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -75,6 +75,14 @@
>>  #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
>>  
>>  /*
>> + * Added to keep arm64 kvm build working which shares code with
>> + * 32bit port. ARM kvm code makes use of __virt_to_idmap() on arm32
>> + * machines as hardware interconnect supported alias of physical
>> + * memory for idmap purposes.
>> + */
>> +#define virt_to_idmap(x)	__virt_to_phys(x)
> 
> There are consistency issues with the use of underscores before
> __virt_to_idmap. And I think you can simply say something like "Required
> by ARM KVM code". The explanation on why really belongs to the 32-bit
> arm code.
> 
Will update the comment as you suggested. Do you want me to rename the
macros as well. I need to do update some more code for that.

Let me know

Regards,
Santosh
