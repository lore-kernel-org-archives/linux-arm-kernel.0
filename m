From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 08 Sep 2015 11:30:37 +0100
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <20150908093729.GE14550@e104818-lin.cambridge.arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55EDC12E.8000408@arm.com>
 <20150907171501.GD10645@e104818-lin.cambridge.arm.com>
 <55EDCC5E.9080203@arm.com>
 <20150908090023.GB14550@e104818-lin.cambridge.arm.com>
 <55EEA5CA.5050901@arm.com>
 <20150908093729.GE14550@e104818-lin.cambridge.arm.com>
Message-ID: <55EEB8CD.2040001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/15 10:37, Catalin Marinas wrote:
> On Tue, Sep 08, 2015 at 10:09:30AM +0100, Suzuki K. Poulose wrote:
>> On 08/09/15 10:00, Catalin Marinas wrote:
>>> On Mon, Sep 07, 2015 at 06:41:50PM +0100, Suzuki K. Poulose wrote:
>>>> On 07/09/15 18:15, Catalin Marinas wrote:
>>>>> On Mon, Sep 07, 2015 at 05:54:06PM +0100, Suzuki K. Poulose wrote:
>>>>>> On 14/08/15 19:28, Robert Richter wrote:
>>>>>>> +static void gicv3_enable_quirks(void)
>>>>>>> +{
>>>>>>> +	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
>>>>>>> +		static_key_slow_inc(&is_cavium_thunderx);
>>>>>>
>>>>>> May be you could use the enable() method added to struct arm64_cpu_capability
>>>>>> here to perform the above operation, added by James :
>>>>>>
>>>>>> commit 1c0763037f1e1caef739e36e09c6d41ed7b61b2d
>>>>>> Author: James Morse <james.morse@arm.com>
>>>>>> Date:   Tue Jul 21 13:23:28 2015 +0100
>>>>>>
>>>>>>      arm64: kernel: Add cpufeature 'enable' callback
>>>>>
>>>>> I thought about this as well when looking at the patch but decided it's
>>>>> better as it is. The "enable" method is meant to enable per-CPU features
>>>>> (or workarounds) but here it is about GICv3, so we don't want to enable
>>>>> for every CPU.
>>>>
>>>> Right. I have been playing with a series where the checks are delayed until
>>>> all CPUs are brought up.
>>>
>>> Unrelated to the GIC workaround, delaying the enable feature until the
>>> CPUs are brought up is not always be feasible.
>>
>> Right. But then, enabling a feature(and applying the alternatives) based on
>> a single CPU may not be safe, always, like PAN. If one of the boot time CPU
>> doesn't have it, then we are in trouble (even though we WARN about it from
>> SANITY check)
>
> I see your point but there's a trade-off. For some features it's not be
> feasible to postpone until user space (e.g. errata workarounds). But if

Right, I agree. I should have been more descriptive. Here is my plan :

Classify the capabilities / workarounds as two different types.

1) Errata workaround capability checks are triggered for each booting
    CPU.
2) CPU Feature capabilities are checked until all boot-time enabled CPUs are
active, in smp_cpus_done() and before apply_alternatives_all().

(We could even classify some of the capabilities as CPU_LOCAL and check it
  per-CPU).

Delay the feature/capability detection to smp_cpus_done() and before
apply_alternatives_all().

i.e, :

  void __init smp_cpus_done(unsigned int max_cpus)
  {
         pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
+       setup_cpu_features();
         hyp_mode_check();
         apply_alternatives_all();
  }

Where setup_cpu_features() will do all the CPU feature related processing
based on the system wide safe value(will be available from the new infrastructure) :

1) cpu capability based on feature registers (e.g, GIC SYSREG, PAN, ATOMICS )
2) ELF_HWCAP


> a CPU coming up late doesn't have compatible features, just keep it in a
> loop (or park it back if possible or even refuse to boot any further). I
> don't think we should cater for insane hardware configurations (e.g. mix


Any other new CPU, which is missing an available system capability, could be
made to loop, as you mentioned.

> of PAN/no-PAN as we already do the code patching). Do you plan to defer
> code patching as well?

As shown above, the apply_alternatives_all() is already done from smp_cpus_done(),
which will stay there.

>
> Note that we may have to use the .enable function for errata workarounds
> as well, not just features like PAN (we currently only do code patching
> but we may have to do other things like issuing SMC calls, you never
> know what's going to hit us).

Given that ERRATAs are checked for each CPU and are not delayed, we need not
worry about. But yes, we could have flags to indicate how/when the enable methods
should be invoked ? e.g, per CPU (like PAN), or per SYSTEM (once for the entire system)

>>> At some point we may
>>> implement support to defer the CPU on to user space (I already have a
>>> patch that does this when no DT enable-method is specified, but I won't
>>> publish it before Qualcomm fixes its firmware ;)). But we may have other
>>> reasons to start with CPUs hot-unplugged by default and turn them on
>>> later.
>>
>> We have SANITY check infrastructure that WARNs in such cases, if the features
>> don't match.  But still, wouldn't it be better to enable a feature
>> only if all the boot-time enabled CPUs have it ? (Errata is an exception though,
>> which only depends on whether one of the CPU needs it).
>
> If we ever need this, I think we should implement a separate late_enable
> function as just deferring all features enabling is not generic enough.
> But in the meantime, I don't think we should worry about this case,
> let's wait and see whether we ever get such configurations (panicking
> the kernel on incompatible features is a good starting point -
> FPSIMD/no-FPSIMD, PAN/no-PAN etc.)

OK. I will post the series after the merge window. We can discuss further
then.

Cheers
Suzuki
