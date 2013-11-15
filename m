From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 14:25:29 +0000
Subject: [PATCH 4/6] arm64: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <20131115133948.GB1217@darko.cambridge.arm.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-5-git-send-email-santosh.shilimkar@ti.com>
 <20131115133948.GB1217@darko.cambridge.arm.com>
Message-ID: <52862ED9.1050708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 13:39, Catalin Marinas wrote:
> On Thu, Nov 14, 2013 at 07:37:44PM +0000, Santosh Shilimkar wrote:
>> Slab allocator can allocate memory beyond the lowmem watermark
>> which can lead to false failure of virt_addr_valid().
>>
>> So drop the check. The issue was seen with percpu_alloc()
>> in KVM code which was allocating memory beyond lowmem watermark.
>>
>> Am not completly sure whether this is the right fix and if it could
>> impact any other user of virt_addr_valid(). Without this fix as
>> pointed out the KVM init was failing in my testing.
> 
> Do you have a problem on arm64? There is no lowmem watermark here.

I don't think that change is relevant for arm64. Actually, the more I
look at it, I don't think virt_addr_valid() should be touched at all.

The real issue is the use of virt_to_phys()/virt_addr_valid() on a
percpu pointer, which is wrong and only worked by chance so far.

I'm working on a patch to solve this.

	M.
-- 
Jazz is not dead. It just smells funny...
