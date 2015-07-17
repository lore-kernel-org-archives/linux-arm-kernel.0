From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 17 Jul 2015 11:42:26 +0100
Subject: [PATCH] arm64: alternative: Provide if/else/endif assembler macros
In-Reply-To: <20150716181929.GU26390@arm.com>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <20150716181929.GU26390@arm.com>
Message-ID: <55A8DC12.2060904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/15 19:19, Will Deacon wrote:
>> Notes:
>>      To be honest these if not/else/endif macros are simply more readable
>>      than the original macro and that might be enough to justify them on
>>      their own. However below is an example that is needlessly hard to
>>      write without them because ICC_PMR_EL1 is a C pre-processor macro.
>>
>>       	.macro	disable_irq, tmp
>>       	mov	\tmp, #ICC_PMR_EL1_MASKED
>>      alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
>>      	msr	daifset, #2
>>      alternative_else
>>       	msr_s	ICC_PMR_EL1, \tmp
>>      alternative_endif
>>      	.endm
>>
>>      The new macros have received a fair degree of testing because I have
>>      based my (not published since March) pseudo-NMI patch set on them.
>
> After some consideration, I think I prefer your suggestion over what we
> currently have in mainline. However, there are a bunch of patches that
> are candidates for 4.3 which will conflict horribly with this.
>
> Would you be able to:
>
>    (1) Split this up so that you have a patch introducing the new macro,
>        then a patch converting entry.S and cache.S then a separate one
>        for kvm/hyp.S?
>
>    (2) Keep alternative_insn around for the moment
>
>    (3) Once the dust has settled for 4.3, we can see how easy the old
>        macro is to remove
>
> Sound ok to you?

Absolutely fine.

I will get the split out patches posted soon.


Daniel.
