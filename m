From: james.morse@arm.com (James Morse)
Date: Tue, 18 Sep 2018 18:47:43 +0100
Subject: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
In-Reply-To: <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
 <3becf020-b230-beb8-b304-d8097377f234@arm.com>
 <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
 <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
Message-ID: <46463b3d-7ceb-f5a5-4061-e988bfc53a6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel, Julien,

On 09/18/2018 12:44 AM, Daniel Thompson wrote:
> On Wed, Sep 12, 2018 at 05:49:09PM +0100, Julien Thierry wrote:
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 3bc1c8b..0d1e41e 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -52,6 +52,8 @@
>>>>    DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>>>    EXPORT_SYMBOL(cpu_hwcaps);
>>>> +unsigned long boot_capabilities;
>>>> +
>>>>    /*
>>>>     * Flag to indicate if we have computed the system wide
>>>>     * capabilities based on the boot time active CPUs. This
>>>> @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>>>>    		if (!cpus_have_cap(caps->capability) && caps->desc)
>>>>    			pr_info("%s %s\n", info, caps->desc);
>>>>    		cpus_set_cap(caps->capability);
>>>
>>> Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
>>> __apply_alternatives() looks at. If you had a call to __apply_alternatives after
>>> update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
>>> apply those alternatives...
>>>
>>> (I don't think there is a problem re-applying the same alternative, but I
>>> haven't checked).

>> Interesting idea. If someone can confirm that patching alternatives twice is
>> safe, I think it would make things simpler.

Sounds good, I think we need to avoid adding a limit to the number of caps.

The extra-work is inefficient, but if it saves merging those lists as part of this 
series its probably fine. (we only do this stuff once during boot)



> Early versions of this patch applied the alternatives twice. I never
> noticed any problems with double patching (second time round it will
> write out code that is identical to what is already there so it is
> merely inefficient rather than unsafe.

For the regular kind, I agree. But we've recently grown some fancy dynamic patching 
where the code is generated at runtime, instead of swapping in an alternative 
sequence. Details in commit dea5e2a4 ("arm64: alternatives: Add dynamic patching 
feature"). Its unlikely we would ever apply these twice as they can't have a scope, 
... and they all look safe.


Thanks,

James
