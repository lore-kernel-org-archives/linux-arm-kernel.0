From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 17 Sep 2015 16:28:11 +0100
Subject: [RFC PATCH v2 3/7] arm64: alternative: Apply alternatives early
 in boot process
In-Reply-To: <20150917140126.GE25634@arm.com>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <1442237181-17064-4-git-send-email-daniel.thompson@linaro.org>
 <20150916130549.GJ28771@arm.com> <55F98FF0.7030605@linaro.org>
 <20150916162452.GN28771@arm.com> <55FABF64.3080404@linaro.org>
 <20150917140126.GE25634@arm.com>
Message-ID: <55FADC0B.9080200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/15 15:01, Will Deacon wrote:
> On Thu, Sep 17, 2015 at 02:25:56PM +0100, Daniel Thompson wrote:
>> On 16/09/15 17:24, Will Deacon wrote:
>>> On Wed, Sep 16, 2015 at 04:51:12PM +0100, Daniel Thompson wrote:
>>>> On 16/09/15 14:05, Will Deacon wrote:
>>>>> On Mon, Sep 14, 2015 at 02:26:17PM +0100, Daniel Thompson wrote:
>>>>>>     /*
>>>>>> + * This is called very early in the boot process (directly after we run
>>>>>> + * a feature detect on the boot CPU). No need to worry about other CPUs
>>>>>> + * here.
>>>>>> + */
>>>>>> +void apply_alternatives_early(void)
>>>>>> +{
>>>>>> +	struct alt_region region = {
>>>>>> +		.begin	= __alt_instructions,
>>>>>> +		.end	= __alt_instructions_end,
>>>>>> +	};
>>>>>> +
>>>>>> +	__apply_alternatives(&region);
>>>>>> +}
>>>>>
>>>>> How do you choose which alternatives are applied early and which are
>>>>> applied later? AFAICT, this just applies everything before we've
>>>>> established the capabilities of the CPUs in the system, which could cause
>>>>> problems for big/little SoCs.
>>>>
>>>> They are applied twice. This relies for correctness on the fact that
>>>> cpufeatures can be set but not unset.
>>>>
>>>> In other words the boot CPU does a feature detect and, as a result, a
>>>> subset of the required alternatives will be applied. However after this
>>>> the other CPUs will boot and the the remaining alternatives applied as
>>>> before.
>>>>
>>>> The current implementation is inefficient (because it will redundantly
>>>> patch the same code twice) but I don't think it is broken.
>>>
>>> What about a big/little system where we boot on the big cores and only
>>> they support LSE atomics?
>>
>> Hmmnn... I don't think this patch will impact that.
>>
>> Once something in the boot sequence calls cpus_set_cap() then if there
>> is a corresponding alternative then it is *going* to be applied isn't
>> it? The patch only means that some of the alternatives will be applied
>> early. Once the boot is complete the patched .text should be the same
>> with and without the patch.
>>
>> Have I overlooked some code in the current kernel that prevents a system
>> with mis-matched LSE support from applying the alternatives?
>
> Sorry, I'm thinking slightly ahead of myself, but the series from Suzuki
> creates a shadow "safe" view of the ID registers in the system,
> corresponding to the intersection of CPU features:
>
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/370386.html
>
> In this case, it is necessary to inspect all of the possible CPUs before
> we can apply the patching, but as I say above, I'm prepared to make an
> exception for NMI because I don't think we can assume a safe value anyway
> for a system with mismatched GIC CPU interfaces. I just don't want to
> drag all of the alternatives patching earlier as well.

Thanks. I'll take a close look at this patch set and work out how to 
cooperate with it.

However I would like, if I can, to persuade you that we are making an 
exception ARM64_HAS_SYSREG_GIC_CPUIF rather than specifically for things 
that are NMI related. AFAIK all ARMv8 cores have a GIC_CPUIF and the 
system either has a GICv3+ or it doesn't so it shouldn't matter what 
core you check the feature on; it is in the nature of the feature we are 
detecting that it is safe to patch early.

To some extent this is quibbling about semantics but:

1. Treating this as a general case will put us in a good position if we
    ever have to deal with an errata that cannot wait until the system
    has nearly finished booting.

2. It makes the resulting code very simple because we can just have a
    bitmask indicating which cpufeatures we need should apply early and
    which we apply late. That in turn means we don't have to
    differentiate NMI alternatives from other alternatives (thus avoiding
    a bunch of new alternative macros).

I'm not seeking any kind binding agreement from you before you see the 
patch but if you *know* right now that you would nack something that 
follows the above thinking then please let me know so I don't waste time 
writing it ;-) . If you're on the fence I'll happily write the patch and 
you can see what I think then.


>>> We also need to think about how an incoming NMI interacts with
>>> concurrent patching of later features. I suspect we want to set the I
>>> bit, like you do for WFI, unless you can guarantee that no patched
>>> sequences run in NMI context.
>>
>> Good point. I'll fix this in the next respin.
>
> Great, thanks. It probably also means that the NMI code needs
> __kprobes/__notrace annotations for similar reasons.

Oops. That I really should have thought about already (but I didn't).


Daniel.
