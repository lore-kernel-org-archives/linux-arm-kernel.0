From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Apr 2017 15:42:11 +0100
Subject: [PATCH] efi/libstub: arm/arm64: don't use TASK_SIZE when
 randomising the RT space
In-Reply-To: <20170410103038.20117-1-ard.biesheuvel@linaro.org>
References: <20170410103038.20117-1-ard.biesheuvel@linaro.org>
Message-ID: <20170410144210.GA30647@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 11:30:38AM +0100, Ard Biesheuvel wrote:
> As reported by James, Catalin and Mark, commit e69176d68d26
> ("ef/libstub/arm/arm64: Randomize the base of the UEFI rt services
> region") results in a crash in the firmware regardless of whether KASLR
> is in effect or not, and whether the firmware implements EFI_RNG_PROTOCOL
> or not.
> 
> Mark has identified the root cause to be the inappropriate use of
> TASK_SIZE in the stub, which arm64 defines as
> 
>   #define TASK_SIZE             (test_thread_flag(TIF_32BIT) ? \
>                                 TASK_SIZE_32 : TASK_SIZE_64)
> 
> and testing thread flags at this point results in the dereference of
> pointers in uninitialized structures.
> 
> So instead, introduce a preprocessor symbol EFI_RT_VIRTUAL_LIMIT and
> define it to TASK_SIZE_64 on arm64 and TASK_SIZE on ARM, both of which
> are compile time constants. Also, change the 'headroom' variable to
> static const to force an error if this changes in the future.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

It works for me as well:

Tested-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Ard and Mark.

-- 
Catalin
