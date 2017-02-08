From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 8 Feb 2017 14:30:46 +0000
Subject: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
In-Reply-To: <20170208135252.GF15459@leverpostej>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
 <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
 <20170202174218.GO31394@leverpostej>
 <017701d281f9$927c5fb0$b7751f10$@codeaurora.org>
 <20170208114002.GD15459@leverpostej>
 <018401d28207$34db60a0$9e9221e0$@codeaurora.org>
 <b55359d8-2665-aef0-3215-53a0e8f21bcd@arm.com>
 <000301d28211$a5233a90$ef69afb0$@codeaurora.org>
 <20170208135252.GF15459@leverpostej>
Message-ID: <db9bc01c-635d-1a57-8a6c-9be19a0cda16@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/17 13:52, Mark Rutland wrote:
> On Wed, Feb 08, 2017 at 07:15:37PM +0530, Sricharan wrote:
>>> Clocks are not architectural, so it only makes sense to associate them
>>> with an implementation-specific compatible string. There's also no
>>
>> ok, it for this the QCOM specific implementation binding is tried(going to).
>>
>>> guarantee that different microarchitectures have equivalent internal
>>> clock domains - I'm not sure if "the SMMU's underlying bus access" is
>>> meant to refer to accesses *by* the SMMU, i.e. page table walks,
>>> accesses *through* the SMMU by upstream masters, or both
>>
>> In the above QCOM case, it is actually both. Its the same path for both the
>> page table walker and upstream masters.

Right, that's what I feared. As far as I can make out the current ARM
implementations, transactions passing through will require at least
TBUn_BCLK for the appropriate TBU, but would also need the page table
walker clocked with CCLK to resolve TLB misses. But then the programming
interface is also in the CCLK domain (not counting the incoming APB or
AXI clock for the actual slave port itself). Thus this 'generic' clock
binding already isn't compatible with MMU-40x/500.

>>> differences are rather significant. I'd also note that an MMU-500
>>> configuration may have up to *33* clocks.
>>>
>>> Either way, the QCOM implementation deserves its own compatible if only
>>> for the sake of the imp-def gaps in the architecture (e.g. FSR.SS
>>> behaviour WRT to IRQs as touched upon in the other thread).
>>>
>>
>> Ok, slightly unclear, so you mean then *clocks* are not good enough reason
>> to have a new compatible ?
> 
> I beleive Robin's point was even if the clocks didn't matter, there are
> other reasons we should have the QCOM-specific compatible string.
> 
> So we should have one regardless.

Exactly.

Robin.

> 
> Thanks,
> Mark.
> 
