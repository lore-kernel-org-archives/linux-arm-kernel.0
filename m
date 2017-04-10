From: james.morse@arm.com (James Morse)
Date: Mon, 10 Apr 2017 12:34:42 +0100
Subject: [PATCH] efi/libstub: arm/arm64: don't use TASK_SIZE when
 randomising the RT space
In-Reply-To: <20170410104403.GC13899@leverpostej>
References: <20170410103038.20117-1-ard.biesheuvel@linaro.org>
 <20170410104403.GC13899@leverpostej>
Message-ID: <58EB6DD2.1010102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, Mark

On 10/04/17 11:44, Mark Rutland wrote:
> On Mon, Apr 10, 2017 at 11:30:38AM +0100, Ard Biesheuvel wrote:
>> As reported by James, Catalin and Mark, commit e69176d68d26
>> ("ef/libstub/arm/arm64: Randomize the base of the UEFI rt services
>> region") results in a crash in the firmware regardless of whether KASLR
>> is in effect or not, and whether the firmware implements EFI_RNG_PROTOCOL
>> or not.
>>
>> Mark has identified the root cause to be the inappropriate use of
>> TASK_SIZE in the stub, which arm64 defines as
>>
>>   #define TASK_SIZE             (test_thread_flag(TIF_32BIT) ? \
>>                                 TASK_SIZE_32 : TASK_SIZE_64)
>>
>> and testing thread flags at this point results in the dereference of
>> pointers in uninitialized structures.
>>
>> So instead, introduce a preprocessor symbol EFI_RT_VIRTUAL_LIMIT and
>> define it to TASK_SIZE_64 on arm64 and TASK_SIZE on ARM, both of which
>> are compile time constants. Also, change the 'headroom' variable to
>> static const to force an error if this changes in the future.
>>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Matt Fleming <matt@codeblueprint.co.uk>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> With this patch applied atop of next-20170410, a defconfig arm64 kernel
> built with the Linaro 15.08 toolchain boots happily for me on Juno R1.

Likewise, this fixes the problem I was seeing on Seattle. If it's useful:
Tested-by: James Morse <james.morse@arm.com>

Thanks for debugging that so quickly Mark!


James
