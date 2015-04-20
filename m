From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Apr 2015 11:03:05 +0100
Subject: [PATCH] arm64: kill flush_cache_all()
In-Reply-To: <20150420094644.GD15875@leverpostej>
References: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
 <5534C9FF.2030703@arm.com> <20150420094644.GD15875@leverpostej>
Message-ID: <5534CED9.8050300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/15 10:46, Mark Rutland wrote:
> On Mon, Apr 20, 2015 at 10:42:23AM +0100, Marc Zyngier wrote:
>> Hi Mark,
>>
>> On 20/04/15 10:24, Mark Rutland wrote:
>>> The documented semantics of flush_cache_all are not possible to provide
>>> for arm64 (short of flushing the entire physical address space by VA),
>>> and there are currently no users; KVM uses VA maintenance exclusively,
>>> cpu_reset is never called, and the only two users outside of arch code
>>> cannot be built for arm64.
>>>
>>> While cpu_soft_reset and related functions (which call flush_cache_all)
>>> were thought to be useful for kexec, their current implementations only
>>> serve to mask bugs. For correctness kexec will need to perform
>>> maintenance by VA anyway to account for system caches, line migration,
>>> and other subtleties of the cache architecture. As the extent of this
>>> cache maintenance will be kexec-specific, it should probably live in the
>>> kexec code.
>>
>> I assume you mean that kexec will perform VA maintenance as part of its
>> private cpu_soft_reset implementation, not that it will reimplement
>> flush by S/W as a private method...
> 
> Yes; the only subtlety being *what* needs to be flushed will be specific
> to kexec. Is there any way I can reword the above to be clearer in that
> respect?

I just found the last sentence slightly confusing, but I don't think
there is much point in reworking this; the removal of all S/W ops should
be a clear enough message...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
