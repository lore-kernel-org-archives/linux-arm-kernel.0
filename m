From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 04 Jan 2016 10:13:46 -0800
Subject: [PATCH 6/6] arm64: switch to relative exception tables
In-Reply-To: <20160104144643.GE1616@arm.com>
References: <1451837157-447-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451837157-447-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160104144643.GE1616@arm.com>
Message-ID: <568AB65A.8030901@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2016 06:46 AM, Will Deacon wrote:
> On Sun, Jan 03, 2016 at 05:05:57PM +0100, Ard Biesheuvel wrote:
>> Instead of using absolute addresses for both the exception location
>> and the fixup, use offsets relative to the exception table entry values.
>> Not only does this cut the size of the exception table in half, it is
>> also a prerequisite for KASLR, since absolute exception table entries
>> are subject to dynamic relocation, which is incompatible with the sorting
>> of the exception table that occurs at build time.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> Note that this patch supersedes the version I sent as part of the series that
>> implements KASLR for arm64: http://thread.gmane.org/gmane.linux.kernel/2116531
>>
>>  arch/arm64/include/asm/assembler.h   |  2 +-
>>  arch/arm64/include/asm/futex.h       |  4 ++--
>>  arch/arm64/include/asm/uaccess.h     | 18 ++++++++++--------
>>  arch/arm64/kernel/armv8_deprecated.c |  4 ++--
>>  arch/arm64/mm/extable.c              |  2 +-
>>  scripts/sortextable.c                |  2 +-
>>  6 files changed, 17 insertions(+), 15 deletions(-)
> 
> This looks good to me, so for the arm64 part (i.e. this patch):
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

May I humbly ask why the [Finnish] you don't use the equivalent of the
x86 _ASM_EXTABLE() macro?  In fact, why don't we make that one generic, too?

	-hpa
