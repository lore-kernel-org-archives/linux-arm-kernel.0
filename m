From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 24 Sep 2012 17:53:34 -0400
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <alpine.LFD.2.02.1209241709200.6667@xanadu.home>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
 <alpine.LFD.2.02.1209241152540.6667@xanadu.home> <5060C9C6.8080900@ti.com>
 <alpine.LFD.2.02.1209241709200.6667@xanadu.home>
Message-ID: <5060D65E.40006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/24/2012 5:20 PM, Nicolas Pitre wrote:
> On Mon, 24 Sep 2012, Cyril Chemparathy wrote:
>
>> On 9/24/2012 11:56 AM, Nicolas Pitre wrote:
>>> On Mon, 24 Sep 2012, Catalin Marinas wrote:
>>>
>>>> On Fri, Sep 21, 2012 at 04:56:03PM +0100, Cyril Chemparathy wrote:
>>>>> This patch adds support for 64-bit physical addresses in virt_to_phys()
>>>>> patching.  This does not do real 64-bit add/sub, but instead patches in
>>>>> the
>>>>> upper 32-bits of the phys_offset directly into the output of
>>>>> virt_to_phys.
>>>>
>>>> So this assumes that for the kernel linear mapping, all the physical
>>>> addresses have the same upper 32-bit. That's a good optimisation but I
>>>> haven't seen this check when calculating lowmem in sanity_check_meminfo.
>>>> Someone may build platform with memory starting at 3GB and going across
>>>> the 4GB limit.
>>>
>>> Good point.  We better get an early warning if that happens.
>>>
>>
>> Thanks.
>>
>> I'm thinking of splitting the bank at the 32-bit boundary in such an event,
>> assuming that the remaining memory should be usable as highmem.
>
> No.  That's not the point here.
>
> Let's suppose a system with 1GB of physical RAM starting at 0xe0000000.
>
> In this case there is no need for highmem.  However the v2p patching
> code in the LPAE case assumes the high bits of a physical address are
> always the same which wouldn't be the case in this hypothetical example.
>
> We want to make sure the kernel won't boot if a system with physical RAM
> crossing the 4GB address mark is encountered.
>

Why brick the box if memory crosses over the 4G mark?

Since this constraint (constant upper 32-bits of PA) applies only to 
lowmem, why couldn't this hypothetical system run with 256M of lowmem, 
and the remaining 768M being used as highmem (if enabled).

IOW, why can't we treat this constraint just like the vmalloc limit 
constraint in sanity_check_meminfo(), by splitting the bank at the limit?

-- 
Thanks
- Cyril
