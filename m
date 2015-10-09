From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 9 Oct 2015 14:00:21 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
 <56163D7F.4000003@arm.com>
 <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
Message-ID: <5617BA65.5060405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 16:03, Catalin Marinas wrote:
> On Thu, Oct 08, 2015 at 10:55:11AM +0100, Suzuki K. Poulose wrote:
>>>> +#define ARM64_FTR_BITS(ftr_strict, ftr_type, ftr_shift, ftr_width, ftr_safe_val) \

>>>
>>> You can drop "ftr_" from all the arguments, it makes the macro
>>> definition shorter.
>>
>> In fact I tried that before, but then the macro expansion will replace the
>> field names with the supplied values and hence won't compile. Either we
>> should change the field names or the values.
>
> OK, keep them in this case.

I have changed it to :

ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)

>>
>>> Also, you captured lots of fields that Linux does not care about. Is it
>>> possible to ignore them altogether, only keep those which are relevant.
>>>
>>
>> The list is entierly from the SANITY check. If there are any registers
>> that we think need not be cross checked, we could get rid of them.
>
> So we have three types of fields in these registers:
>
> a) features defined but not something we care about in Linux
> b) reserved fields
> c) features important to Linux
>
> I guess for (a), Linux may not even care if they don't match (though we
> need to be careful which fields we ignore). As for (b), even if they
> differ, since we don't know the meaning at this point, I think we should
> just ignore them. If, for example, they add a feature that Linux doesn't
> care about, they practically fall under the (a) category.

OK. So we can pack the consecutive features of type (a) and make it NONSTRICT.

>
> Regarding exposing reserved CPUID fields to user, I assume we would
> always return 0.

Ideally, the architecturally reserved value (i.e, 0 for RAZ and 1 for RES1).

>>> Is this function ever called on a hot path? If not, just keep everything
>>> in an array and do a linear search rather than having different arrays
>>> based on op*. Especially if we managed to limit the number of registers
>>> to only those that Linux cares about.
>>
>> I started with linear array in the RFC post. But since then the number of
>> users for the API has gone up. Hence thought of optimising it. The only
>> 'intensive' user is SANITY check for each register at CPU bring up.
>
> This shouldn't be that bad since it's not happening very often. However,
> do we need this thing for MRS emulation (not many registers though)? You
> could use a binary search (something like radix tree seems overkill)

Yes we do need this for MRS emulation. I will change it to binary search.

Thanks
Suzuki
