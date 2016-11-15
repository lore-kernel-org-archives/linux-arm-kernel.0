From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 15 Nov 2016 10:42:41 +0000
Subject: [PATCH v3 2/2] arm64: Support systems without FP/ASIMD
In-Reply-To: <20161114114858.GB3096@e104818-lin.cambridge.arm.com>
References: <1478613381-5718-1-git-send-email-suzuki.poulose@arm.com>
 <1478613381-5718-3-git-send-email-suzuki.poulose@arm.com>
 <20161114114858.GB3096@e104818-lin.cambridge.arm.com>
Message-ID: <3fe7dcce-97ef-54ad-fc3b-8d23bcaa066a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/16 11:48, Catalin Marinas wrote:
> Hi Suzuki,
>

>> +static inline bool system_supports_fpsimd(void)
>> +{
>> +	return !cpus_have_const_cap(ARM64_HAS_NO_FPSIMD);
>> +}
>
> Any particular reason why using negation instead of a ARM64_HAS_FPSIMD?
> A potential problem would be the default cpus_have_const_cap()
> implementation and the default static key having a slight performance
> impact.

The negation was chosen to avoid hotpatching in the most common case.
But as you said, it has an impact on the other side. I think doing
a one time hotpatching at boot time is more optimal than penalising
a bunch of other users throughout the execution. I will take a look
at changing it back to a ARM64_HAS_FPSIMD.

>>  	},
>> +	{
>> +		/* FP/SIMD is not implemented */
>> +		.capability = ARM64_HAS_NO_FPSIMD,
>> +		.def_scope = SCOPE_SYSTEM,
>> +		.min_field_value = 0,
>> +		.matches = has_no_fpsimd,
>> +	},
>
> If we go for negation, I don't think we need a min_field_value at all,
> the matching is done by the has_no_fpsimd() function.

You're right.

Suzuki
