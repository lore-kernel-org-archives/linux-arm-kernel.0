From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 29 Oct 2018 11:16:15 +0000
Subject: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
In-Reply-To: <20181029102922.GC14127@arm.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
 <20180920135631.23833-2-aryabinin@virtuozzo.com>
 <20181029102922.GC14127@arm.com>
Message-ID: <9cf4a5ff-b68d-5703-720a-bce05409428a@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/29/2018 01:29 PM, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 04:56:30PM +0300, Andrey Ryabinin wrote:
>> ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
>> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
>> code, thus it can potentially miss many bugs.
>>
>> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
>> enabled, so the generic implementations from lib/string.c will be used.
>>
>> We can't just remove the asm functions because efistub uses them.
>> And we can't have two non-weak functions either, so declare the asm
>> functions as weak.
>>
>> Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> ---
>> Changes since v1:
>>  - Use WEAK() instead of .weak
>>
>>  arch/arm64/include/asm/string.h | 14 ++++++++------
>>  arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
>>  arch/arm64/lib/memchr.S         |  2 +-
>>  arch/arm64/lib/memcmp.S         |  2 +-
>>  arch/arm64/lib/strchr.S         |  2 +-
>>  arch/arm64/lib/strcmp.S         |  2 +-
>>  arch/arm64/lib/strlen.S         |  2 +-
>>  arch/arm64/lib/strncmp.S        |  2 +-
>>  arch/arm64/lib/strnlen.S        |  2 +-
>>  arch/arm64/lib/strrchr.S        |  2 +-
>>  10 files changed, 21 insertions(+), 16 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Please post these again after the merge window and we'll figure out how to
> get them queued.
> 


Andrew sent these patches to Linus couple days ago, so they are in tree already.

Something went wrong with mail notification though. I didn't even realize that they
were in -mm tree, because I didn't receive the usual 'the patch has been added to -mm tree' email.
But I did receive email that was sent to Linus.

Also there was no you or Catalin in Cc tags in 2,3 patches, and in the first patch, the Cc tags were
corrupted:

From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: include/linux/linkage.h: align weak symbols

Since WEAK() supposed to be used instead of ENTRY() to define weak
symbols, but unlike ENTRY() it doesn't have ALIGN directive.  It seems
there is no actual reason to not have, so let's add ALIGN to WEAK() too.

Link: http://lkml.kernel.org/r/20180920135631.23833-1-aryabinin at virtuozzo.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
