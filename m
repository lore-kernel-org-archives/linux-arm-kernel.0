From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Oct 2018 10:29:23 +0000
Subject: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
In-Reply-To: <20180920135631.23833-2-aryabinin@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
 <20180920135631.23833-2-aryabinin@virtuozzo.com>
Message-ID: <20181029102922.GC14127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 04:56:30PM +0300, Andrey Ryabinin wrote:
> ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> code, thus it can potentially miss many bugs.
> 
> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> enabled, so the generic implementations from lib/string.c will be used.
> 
> We can't just remove the asm functions because efistub uses them.
> And we can't have two non-weak functions either, so declare the asm
> functions as weak.
> 
> Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
> Changes since v1:
>  - Use WEAK() instead of .weak
> 
>  arch/arm64/include/asm/string.h | 14 ++++++++------
>  arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
>  arch/arm64/lib/memchr.S         |  2 +-
>  arch/arm64/lib/memcmp.S         |  2 +-
>  arch/arm64/lib/strchr.S         |  2 +-
>  arch/arm64/lib/strcmp.S         |  2 +-
>  arch/arm64/lib/strlen.S         |  2 +-
>  arch/arm64/lib/strncmp.S        |  2 +-
>  arch/arm64/lib/strnlen.S        |  2 +-
>  arch/arm64/lib/strrchr.S        |  2 +-
>  10 files changed, 21 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Please post these again after the merge window and we'll figure out how to
get them queued.

Will
