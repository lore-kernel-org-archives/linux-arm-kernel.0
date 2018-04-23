From: jan.kiszka@web.de (Jan Kiszka)
Date: Mon, 23 Apr 2018 12:33:17 +0200
Subject: BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0
In-Reply-To: <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
 <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
 <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
Message-ID: <02ba4513-7913-6415-5252-9cb7d75f3687@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-23 12:29, Mark Rutland wrote:
> On Mon, Apr 23, 2018 at 07:00:52AM +0200, Jan Kiszka wrote:
>> On 2018-04-22 21:06, Mark Rutland wrote:
> 
>>> Does the below help?
> 
>>> From ade322407e3d6d1f50e558ebd50d2c1c7bd811c2 Mon Sep 17 00:00:00 2001
>>> From: Mark Rutland <mark.rutland@arm.com>
>>> Date: Sun, 22 Apr 2018 19:58:08 +0100
>>> Subject: [PATCH] arm64: add sentinel to kpti_safe_list
>>>
>>> We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_range_list()
>>> can walk past the end of kpti_safe_list. Depending on the contents of memory,
>>> this could erroneously match a CPU's MIDR, cause a data abort, or other bad
>>> outcomes.
>>>
>>> Add the sentinel entry to avoid this.
>>>
>>> Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks based on a list of MIDRs")
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Reported-by: Jan Kiszka <jan.kiszka@web.de>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> ---
>>>  arch/arm64/kernel/cpufeature.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 536d572e5596..9d1b06d67c53 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>>  	static const struct midr_range kpti_safe_list[] = {
>>>  		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
>>>  		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
>>> +		{ /* sentinel */ }
>>>  	};
>>>  	char const *str = "command line option";
>>>  
>>>
>>
>> Jep, all fine now!
> 
> Cool. Can I take that as a Tested-by?

Yes, sorry:

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/650bd2e9/attachment.sig>
