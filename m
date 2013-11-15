From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Nov 2013 09:57:30 -0500
Subject: [PATCH 4/6] arm64: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <52862ED9.1050708@arm.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-5-git-send-email-santosh.shilimkar@ti.com>
 <20131115133948.GB1217@darko.cambridge.arm.com> <52862ED9.1050708@arm.com>
Message-ID: <5286365A.5080504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013 09:25 AM, Marc Zyngier wrote:
> On 15/11/13 13:39, Catalin Marinas wrote:
>> On Thu, Nov 14, 2013 at 07:37:44PM +0000, Santosh Shilimkar wrote:
>>> Slab allocator can allocate memory beyond the lowmem watermark
>>> which can lead to false failure of virt_addr_valid().
>>>
>>> So drop the check. The issue was seen with percpu_alloc()
>>> in KVM code which was allocating memory beyond lowmem watermark.
>>>
>>> Am not completly sure whether this is the right fix and if it could
>>> impact any other user of virt_addr_valid(). Without this fix as
>>> pointed out the KVM init was failing in my testing.
>>
>> Do you have a problem on arm64? There is no lowmem watermark here.
> 
> I don't think that change is relevant for arm64. Actually, the more I
> look at it, I don't think virt_addr_valid() should be touched at all.
> 
> The real issue is the use of virt_to_phys()/virt_addr_valid() on a
> percpu pointer, which is wrong and only worked by chance so far.
> 
> I'm working on a patch to solve this.
> 
Yep. I tried Marc's other approach and that does solve the issue.
The $subject patch was any way more for getting attention to figure
out right solution ;-) which I guess we have now.

Regards,
Santosh
