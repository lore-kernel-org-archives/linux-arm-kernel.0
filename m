From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 19 Nov 2015 10:03:13 +0000
Subject: [PATCH 2/5] arm64: cpufeature: Track unsigned fields
In-Reply-To: <564D56CA.60502@linaro.org>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-2-git-send-email-suzuki.poulose@arm.com>
 <564D56CA.60502@linaro.org>
Message-ID: <564D9E61.8010802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/15 04:57, AKASHI Takahiro wrote:
> Hi
>
>  From my curiosity,
> can you please clarify your criteria regarding which fields of a register should be signed or unsigned?
> I guessed that the fields marked with FTR_LOWER_SAFE or FTR_HIGHER_SAFE could be unsigned,
> but it seems to be not always true looking at your patch.
> Anyhow, for example,

...

>> -    ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
>> +    U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
>>       ARM64_FTR_END,
>>   };
>
> BigEnd, bits[11:8], is 0b0000 for "No mixed-endian support", and 0b0001 for
> "Mixed-endian support". But can any other value be possible? If not, why signed?
> If there are some hidden (or undocumented) specifications, as Ard mentioned, that's fine.
> Please ignore my comments.

There are no hidden specifications, but just that they are undocumented. To be precise,
the criteria I selected was based on the meaning of their values.

1) If value represents something which cannot be negative and hence should be treated as
    unsigned.
    e.g, number of break points ID_AA64DFR0:BRPs.

    
2) If the individual values are mapped to some other values which cannot be negative, but have
    LOWER_SAFE/HIGHER_SAFE relation.
     e.g,  CTR_EL0:WRG - Log2 of the write granule size.
	  ID_AA64MMFR0:PARANGE - Supported PA Size


Thanks
Suzuki
