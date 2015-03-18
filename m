From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 19:28:51 +0100
Subject: [PATCH v5 0/8] arm64: head.S cleanup
In-Reply-To: <20150318182352.GI19814@leverpostej>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150318182352.GI19814@leverpostej>
Message-ID: <CAKv+Gu-G++qtHYcoCS+Os2cGAEmOLfHxRbbJXnNZAeLxeGBUmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 19:23, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 18, 2015 at 02:55:19PM +0000, Ard Biesheuvel wrote:
>> This some janitorial work on head.S, just stuff I noticed when making
>> changes to it for other reasons.
>>
>> This still needs acks on patches #2, #5 and #8
>
> I've given each patch of the series series a spin on Juno (using
> EFI+PSCI) and a model (using the bootwwapper + spin-table). For patches
> 1-7 the code looks sane, I see no build regressions on defconfig, and
> everything works, so for those feel free to add:
>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks!

>>
>> Changes since v4:
>> - included Marc Zyngier's struct cpu_table removal patch
>> - dropped __lookup_processor_type_data patch now that Marc has nuked the
>>   whole thing
>> - added patch to merge __enable_mmu() and __turn_mmu_on() into a single
>>   function, as there is no need for funky trampoline stuff when you have
>>   two non-overlapping TTBRs
>> - added patch to remove __calc_phys_offset and use PC-relative references or
>>   absolute (linker generated) references as appropriate
>> - added patch to complain when x1/x2/x3 are non-zero, which helps ensure that
>>   we will ever be able to use them for anything
>> - added R-b's
>>
>> Changes since v3:
>> - added similar patch for secondary_holding_pen_release
>> - fixed bug in patch #1 (ldr_l)
>>
>> Changes since v2:
>> - added separate patch to add macros for adrp/add, adrp/ldr and adrp/str
>> - added R-b's
>>
>> Ard Biesheuvel (7):
>>   arm64: add macros for common adrp usages
>>   arm64: remove processor_id
>>   arm64: remove __switch_data object from head.S
>>   arm64: use PC-relative reference for secondary_holding_pen_release
>>   arm64: merge __enable_mmu and __turn_mmu_on
>>   arm64: remove __calc_phys_offset
>>   arm64: enforce x1|x2|x3 == 0 upon kernel entry as per boot protocol
>>
>> Marc Zyngier (1):
>>   arm64: Get rid of struct cpu_table
>>
>>  arch/arm64/include/asm/assembler.h |  29 ++++++
>>  arch/arm64/include/asm/cputable.h  |  30 ------
>>  arch/arm64/kernel/Makefile         |   2 +-
>>  arch/arm64/kernel/asm-offsets.c    |   4 -
>>  arch/arm64/kernel/cputable.c       |  33 ------
>>  arch/arm64/kernel/head.S           | 203 +++++++------------------------------
>>  arch/arm64/kernel/setup.c          |  34 +++----
>>  7 files changed, 83 insertions(+), 252 deletions(-)
>>  delete mode 100644 arch/arm64/include/asm/cputable.h
>>  delete mode 100644 arch/arm64/kernel/cputable.c
>>
>> --
>> 1.8.3.2
>>
>>
