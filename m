From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 17 Sep 2015 14:25:56 +0100
Subject: [RFC PATCH v2 3/7] arm64: alternative: Apply alternatives early
 in boot process
In-Reply-To: <20150916162452.GN28771@arm.com>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <1442237181-17064-4-git-send-email-daniel.thompson@linaro.org>
 <20150916130549.GJ28771@arm.com> <55F98FF0.7030605@linaro.org>
 <20150916162452.GN28771@arm.com>
Message-ID: <55FABF64.3080404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/15 17:24, Will Deacon wrote:
> On Wed, Sep 16, 2015 at 04:51:12PM +0100, Daniel Thompson wrote:
>> On 16/09/15 14:05, Will Deacon wrote:
>>> On Mon, Sep 14, 2015 at 02:26:17PM +0100, Daniel Thompson wrote:
>>>> Currently alternatives are applied very late in the boot process (and
>>>> a long time after we enable scheduling). Some alternative sequences,
>>>> such as those that alter the way CPU context is stored, must be applied
>>>> much earlier in the boot sequence.
>>>>
>>>> Introduce apply_alternatives_early() to allow some alternatives to be
>>>> applied immediately after we detect the CPU features of the boot CPU.
>>>>
>>>> Currently apply_alternatives_all() is not optimized and will re-patch
>>>> code that has already been updated. This is harmless but could be
>>>> removed by adding extra flags to the alternatives store.
>>>>
>>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>> ---
>>> [snip]
>>>>    /*
>>>> + * This is called very early in the boot process (directly after we run
>>>> + * a feature detect on the boot CPU). No need to worry about other CPUs
>>>> + * here.
>>>> + */
>>>> +void apply_alternatives_early(void)
>>>> +{
>>>> +	struct alt_region region = {
>>>> +		.begin	= __alt_instructions,
>>>> +		.end	= __alt_instructions_end,
>>>> +	};
>>>> +
>>>> +	__apply_alternatives(&region);
>>>> +}
>>>
>>> How do you choose which alternatives are applied early and which are
>>> applied later? AFAICT, this just applies everything before we've
>>> established the capabilities of the CPUs in the system, which could cause
>>> problems for big/little SoCs.
>>
>> They are applied twice. This relies for correctness on the fact that
>> cpufeatures can be set but not unset.
>>
>> In other words the boot CPU does a feature detect and, as a result, a
>> subset of the required alternatives will be applied. However after this
>> the other CPUs will boot and the the remaining alternatives applied as
>> before.
>>
>> The current implementation is inefficient (because it will redundantly
>> patch the same code twice) but I don't think it is broken.
>
> What about a big/little system where we boot on the big cores and only
> they support LSE atomics?

Hmmnn... I don't think this patch will impact that.

Once something in the boot sequence calls cpus_set_cap() then if there 
is a corresponding alternative then it is *going* to be applied isn't 
it? The patch only means that some of the alternatives will be applied 
early. Once the boot is complete the patched .text should be the same 
with and without the patch.

Have I overlooked some code in the current kernel that prevents a system 
with mis-matched LSE support from applying the alternatives?


>>> Also, why do we need this for the NMI?
>>
>> I was/am concerned that a context saved before the alternatives are
>> applied might be restored afterwards. If that happens the bit that
>> indicates what value to put into the PMR would read during the restore
>> without having been saved first. Applying early ensures that the context
>> save/restore code is updated before it is ever used.
>
> Damn, and stop_machine makes use of local_irq_restore immediately after
> the patching has completed, so it's a non-starter. Still, special-casing
> this feature via an explicit apply_alternatives call would be better
> than moving everything earlier, I think.

Can you expand on you concerns here? Assuming I didn't miss anything 
about how the current machinery works then it really is only a matter of 
whether applying some alternatives early could harm the boot sequence. 
After we have booted the results should be the same.


> We also need to think about how an incoming NMI interacts with
> concurrent patching of later features. I suspect we want to set the I
> bit, like you do for WFI, unless you can guarantee that no patched
> sequences run in NMI context.

Good point. I'll fix this in the next respin.


Daniel.
