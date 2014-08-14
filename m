From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 14 Aug 2014 12:31:35 +0200
Subject: [PATCH] arm64: align randomized TEXT_OFFSET on 4 kB boundary
In-Reply-To: <20140814102307.GB24018@leverpostej>
References: <1407952383-1214-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140814102307.GB24018@leverpostej>
Message-ID: <CAKv+Gu8yne5zdtgsVcsc+D=C--qQcMoOuanPuHeWg+BiKO8xfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2014 12:23, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Wed, Aug 13, 2014 at 06:53:03PM +0100, Ard Biesheuvel wrote:
>> When booting via UEFI, the kernel Image is loaded at a 4 kB boundary and
>> the embedded EFI stub is executed in place. The EFI stub relocates the
>> Image to reside TEXT_OFFSET bytes above a 2 MB boundary, and jumps into
>> the kernel proper.
>>
>> In AArch64, PC relative symbol references are emitted using adrp/add or
>> adrp/ldr pairs, where the offset into a 4 kB page is resolved using a
>> separate :lo12: relocation. This implicitly assumes that the code will
>> always be executed at the same relative offset with respect to a 4 kB
>> boundary, or the references will point to the wrong address.
>>
>> This means we should link the kernel at a 4 kB aligned base address in
>> order to remain compatible with the base address the UEFI loader uses
>> when doing the initial load of Image. So update the code that generates
>> TEXT_OFFSET to choose a multiple of 4 kB.
>>
>> At the same time, update the code so it chooses from the interval [0..2MB)
>> as the author originally intended.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/Makefile      | 2 +-
>>  arch/arm64/kernel/head.S | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 57833546bf00..2df5e5daeebe 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -39,7 +39,7 @@ head-y              := arch/arm64/kernel/head.o
>>
>>  # The byte offset of the kernel image in RAM from the start of RAM.
>>  ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
>> -TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%04x0\n", int(65535 * rand())}')
>> +TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%03x000\n", int(512 * rand())}')
>>  else
>>  TEXT_OFFSET := 0x00080000
>>  endif
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index b6ca95aee348..ae055a18b04a 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -38,11 +38,11 @@
>>
>>  #define KERNEL_RAM_VADDR     (PAGE_OFFSET + TEXT_OFFSET)
>>
>> -#if (TEXT_OFFSET & 0xf) != 0
>> -#error TEXT_OFFSET must be at least 16B aligned
>> -#elif (PAGE_OFFSET & 0xfffff) != 0
>> +#if (TEXT_OFFSET & 0xfff) != 0
>> +#error TEXT_OFFSET must be at least 4kB aligned
>
> Minor nit, but can we have "KB" here to match "MB"?
>

Ack

>> +#elif (PAGE_OFFSET & 0x1fffff) != 0
>>  #error PAGE_OFFSET must be at least 2MB aligned
>> -#elif TEXT_OFFSET > 0xfffff
>> +#elif TEXT_OFFSET > 0x1fffff
>>  #error TEXT_OFFSET must be less than 2MB
>>  #endif
>
> I thought I'd left wording in Kconfig.debug, but that doesn't seem to be
> the case. This looks sane to me, so:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> Catalin, can you pick this up? Without it UEFI boot can be broken by
> ARM64_RANDOMIZE_TEXT_OFFSET.
>

I assume the above change does not require a v2.

-- 
Ard.
