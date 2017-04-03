From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 3 Apr 2017 11:55:26 +0100
Subject: [RFC PATCH v2 00/41] Scalable Vector Extension (SVE) core support
In-Reply-To: <20170403105157.GP3750@e103592.cambridge.arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu_JUqQu7nUB3MfJrpHL19NTSzGBDmZqLejBx8pNkwSq+A@mail.gmail.com>
 <20170403094501.GN3750@e103592.cambridge.arm.com>
 <CAKv+Gu8vUq0A8BEuLHT8e3w9xJ4fbQ3j7K+mVwJafbQP3Eku5A@mail.gmail.com>
 <20170403105157.GP3750@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu89MAwGh9t9OdZ3tisTtDM8zsNTtWiacPf7j2XEf2vRLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(- list)

On 3 April 2017 at 11:51, Dave Martin <Dave.Martin@arm.com> wrote:
> On Mon, Apr 03, 2017 at 11:01:28AM +0100, Ard Biesheuvel wrote:
>> On 3 April 2017 at 10:45, Dave Martin <Dave.Martin@arm.com> wrote:
>> > On Fri, Mar 31, 2017 at 04:28:16PM +0100, Ard Biesheuvel wrote:
>
> [...]
>
>> >> Given the above, I think it is perfectly reasonable to conditionally
>> >> disallow kernel mode NEON in hardirq context. The crypto routines that
>> >> rely on it can easily be fixed up (I already wrote the patches for
>> >> that). This would only be necessary on SVE systems, and the reason for
>> >> doing so is that - given how preserving and restoring the NEON
>> >> register file blows away the upper SVE part of the registers - whoever
>> >> arrives at the SVE-aware preserve routine first should be allowed to
>> >> run to completion. This does require disabling softirqs during the
>> >> time the preserved NEON state is being manipulated but that does not
>> >> strike me as a huge price to pay. Note that both restrictions
>> >> (disallowing kernel mode NEON in hardirq context, and the need to
>> >> disable softirqs while manipulating the state) could be made runtime
>> >> dependent on whether we are actually running on an SVE system.
>> >
>> > Given that we already bail out of kernel_neon_begin() with a WARN() if
>> > the hardware lacks FPSIMD, I'm not sure it would be worse to do the same
>> > if SVE is present.
>> >
>> > However, we should probably abstract that check: currently, drivers
>> > seemt to be using a cocktail of Kconfig dependencies,
>> > MODULE_DEVICE_TABLE() and runtime hwcap checks in order to deduce
>> > whether kernel_neon_begin() is safe to use.
>> >
>>
>> Not quite. The Kconfig dependencies are about
>> CONFIG_KERNEL_MODE_NEON=y being set, without which it is pretty
>> pointless to build the modules that depend on it.
>>
>> The hwcap dependencies are mostly about the actual instructions
>> themselves, i.e., AES, PMULL, SHA1/2 etc
>
> Sure, there are multiple reasons why these checks are being done:
> checking that kernel_neon_begin() is available is part of the reason,
> but not the whole reason for some of the checks.
>
> Doing other checks for specific ISA extensions that the driver
> wants to use remains perfectly appropriate.
>
>> > Would you be happy with a single API for checking whether
>> > kernel_neon_begin() works?  Maintaining this check in every driver
>> > doesn't feel very scalable.
>> >
>>
>> Yes, that makes sense, but it is unrelated to hwcap. I'd like to see a
>> kernel_neon_allowed() that would return '!IS_ENABLED(CONFIG_SVE) ||
>> !(elf_hwcap & HWCAP_SVE) || !in_irq()' at some point, although I
>> understand you want to remove the last part for now.
>> To short-circuit some decisions in the driver when
>> kernel_neon_allowed() is always true (as it would be currently),
>> something like kernel_neon_need_fallback() comes to mind.
>>
>> >
>> > This would allow SVE to disable KERNEL_MODE_NEON without having to make
>> > them conflict in Kconfig.  This wouldn't be our end goal, but it allows
>> > the dependency to be decoupled while we figure out a better solution.
>> >
>>
>> I still don't think there is a need to disable kernel mode NEON
>> altogether. But we can defer that decision until later, but prepare
>> the existing code to deal with that in the mean time.
>
> Agreed -- given that SVE hardware won't exist in the wild for some time,
> I prefer to at least have SVE buildable in defconfig without impacting
> existing systems.
>
> This means that integrating KMN with SVE could be worked on later, and
> also means that the improvements to KMN already discussed can be worked
> on independently without necessarily considering SVE.
>
>> As I mentioned, I already looked into this a while ago, so I can
>> quickly respin the changes to the crypto code to take this into
>> account.
>
> It would be interesting to see what that looks like.
>

This stuff is quite stale and out of date, and overloading
may_use_simd() is inappropriate since async crypto algorithms may
still prefer to defer their work to process context even if crypto is
allowed in hardirq context. But this should give you an idea

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm64-sve-crypto
