From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 6 Dec 2010 18:41:31 +0000
Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	with CONFIG_THUMB2_KERNEL
In-Reply-To: <AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
Message-ID: <AANLkTi=E4wDRH6CtNhvX-iHmrDeWK8jrqyYJtiTPMrV8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 6, 2010 at 6:17 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On 6 December 2010 17:35, Dave Martin <dave.martin@linaro.org> wrote:
>> ?* Explicitly build a few parts of sleep34xx.S as ARM.
>>
>> ? ? ?* lock_scratchpad_sem is kept as ARM because of the need to
>> ? ? ? ?synchronise with hardware (?) using the SWP instruction.
>>
>> ? ? ?* save_secure_ram_context and omap34xx_cpu_suspend are built
>> ? ? ? ?as ARM in case the Secure World firmware expects to decode
>> ? ? ? ?the comment field from the SMC (aka smi) instructions.
>>
>> ? ? ? ?This can be undone later if the firmware is confirmed as
>> ? ? ? ?able to decode the Thumb SMC encoding (or ignores the
>> ? ? ? ?comment field).
>>
>> ? ? ?* es3_sdrc_fix should presumably only be called from the
>> ? ? ? ?low-level wakeup code. ?To minimise the diff, switched this
>> ? ? ? ?to ARM and demoted it to be a local symbol, since I believe
>> ? ? ? ?it shouldn't be called from outside anyway.
>
> I haven't checked the code but does this always work? The kernel isn't
> built with interworking enabled, so it's either ARM or Thumb-2.

Interworking is mandated by EABI, and when building for EABI there is
no such thing as non-interworking C code IIUC: i.e.,
-mno-thumb-interwork does nothing.  Certainly, calls via a function
pointer are assembled as BX instructions, and the linker fixes up
static function calls with the right instruction (BL/BX).

Provided the affected functions are only called from C code, and
providing that legacy tools/ABI aren't used, it should work.  I've
reviewed to make sure that this is the case, and the code as posted
executes correctly on Beagle xM (not including the omap4-specific
code, for which I have no board to test on).

CONFIG_THUMB2_KERNEL already depends on CONFIG_AEABI, so we should be
relatively safe on this point.  Without CONFIG_THUMB2_KERNEL,
everything is built as ARM, so we have no problem.

The two cases where we have to be careful are:

  * Where code assumes that f == <base address of body of function f>,
which would lead to off-by-one errors by code which tries to copy
function bodies and derive pointers to the copies, due to the setting
of bit 0 of the address to indicate Thumb.  The patch series fix the
instances of this error present in the upstream OMAP BSP, except for
instances in code specific to OMAP2 and earlier which can't usefully
be built for Thumb-2 anyway.

  * Where bootloaders / firmware may jump directly into locations in
the kernel, and assume ARM (or don't interwork correctly), or where
the firmware may implicitly decode instructions from the caller as ARM
(e.g., to examine the SMC instruction comment field).  The most
straightforward way to avoid such problems is to make all such entry
points ARM.  But we could get rid of that if the platform maintainers
believe it's safe.


I did experiment with sticking with pure ARM in the low-level
assembler, with explicit veneers to switch instruction set, but that
gets rather messy and shouldn't really be necessary.  I suspect it
would be harder to maintain also.

Pure Thumb on the other hand is unlikely to be possible in every case:
the OMAP BSP uses SWP, and I've conservatively made the assumption
that bootloaders / firmware may assume they're jumping into ARM code,
and may try to decode SMC instructions as ARM instructions -- these
may not be true in practice, but these are harder to test, and I'm not
in a position to check _every_ bootloader/firmware/kernel combination
...

Cheers
---Dave
