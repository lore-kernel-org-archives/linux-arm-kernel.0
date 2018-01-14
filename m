From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 14 Jan 2018 23:29:16 +0000
Subject: [PATCH 1/7] arm64: kernel: avoid executable literal pools
In-Reply-To: <CAKv+Gu8D5Zxfjbj21J9-e2Z+kVdDv4KmFhrOf-SinGM_1zh36g@mail.gmail.com>
References: <20180110121142.18291-1-ard.biesheuvel@linaro.org>
 <20180110121142.18291-2-ard.biesheuvel@linaro.org>
 <CAKv+Gu8D5Zxfjbj21J9-e2Z+kVdDv4KmFhrOf-SinGM_1zh36g@mail.gmail.com>
Message-ID: <CAKv+Gu-eBKS7_7jc5AAiWkO8VcEpVWF4VFwA9zrDvsM_dkpw8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2018 at 23:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 10 January 2018 at 12:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Recent versions of GCC will emit literals into a separate .rodata section
>> rather than interspersed with the instruction stream. We disabled this
>> in commit 67dfa1751ce71 ("arm64: errata: Add -mpc-relative-literal-loads
>> to build flags"), because it uses adrp/add pairs to reference these
>> literals even when building with -mcmodel=large, which breaks module
>> loading when we have the mitigation for Cortex-A53 erratum #843419
>> enabled.
>>
>> However, due to the recent discoveries regarding speculative execution,
>> we should avoid putting data into executable sections, to prevent
>> creating speculative gadgets inadvertently.
>>
>> So set -mpc-relative-literal-loads only for modules, and only if the
>> A53 erratum is enabled.
>>
>
> This appears not to help: even with the command line option removed,
> the literals are still emitted into the .text section, even though the
> references are emitted using adrp/ldr pairs. AFAICT, the reason for
> this feature was very large functions (>1 MB), even though I am pretty
> sure I discussed the ROP gadget use case with Ramana at some point.
>

Ehm, apologies, right reply but to wrong patch.

*This* patch is pointless because vmlinux is built using the small
model so whether we apply the GGC option to everything or to modules
only does not make any difference.

In summary, it seems the only way to get rid of literals in the .text
section entirely is by dropping the large C model entirely.

>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index b481b4a7c011..bd7cb205e28a 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -26,7 +26,8 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
>>    ifeq ($(call ld-option, --fix-cortex-a53-843419),)
>>  $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
>>    else
>> -LDFLAGS_vmlinux        += --fix-cortex-a53-843419
>> +LDFLAGS_vmlinux                += --fix-cortex-a53-843419
>> +KBUILD_CFLAGS_MODULE   += $(call cc-option, -mpc-relative-literal-loads)
>>    endif
>>  endif
>>
>> @@ -51,7 +52,6 @@ endif
>>
>>  KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)
>>  KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>> -KBUILD_CFLAGS  += $(call cc-option, -mpc-relative-literal-loads)
>>  KBUILD_AFLAGS  += $(lseinstr) $(brokengasinst)
>>
>>  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
>> --
>> 2.11.0
>>
