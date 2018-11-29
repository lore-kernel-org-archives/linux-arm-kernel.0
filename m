From: Julien.Thierry@arm.com (Julien Thierry)
Date: Thu, 29 Nov 2018 09:03:54 +0000
Subject: [PATCH] arm64: io: specify asm operand width for __iormb()
In-Reply-To: <20181129041912.5918-1-nick.desaulniers@gmail.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
Message-ID: <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/11/18 04:19, Nick Desaulniers wrote:
> Fixes the warning produced from Clang:
> ./include/asm-generic/io.h:711:9: warning: value size does not match
> register size specified by the constraint and modifier
> [-Wasm-operand-widths]
>         return readl(addr);
>                ^
> ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
>                                                           ^
> ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
>                                                   ^
> ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
>         asm volatile("eor       %w0, %1, %1\n" \
>                                      ^

Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
The variable passed to the inline assembly for %0 is unsigned long, so
always 64-bits wide on arm64. Why is clang trying to use a 32-bit
register for it?

Although it's not really important since all this is just introducing a
control dependency, I find it a bit odd.

Thanks,

> Though we disable Clang's integrated assembler with -no-integrated-as,
> it still tries to do some validation of assembler constraints.
>
> While __iormb() is type agnostic to operand widths for argument v, its
> lone use is to zero'd out via eor (exclusive or).
>
> Fixes commit 6460d3201471 ("arm64: io: Ensure calls to delay routines
> are ordered against prior readX()")
> Link: https://github.com/ClangBuiltLinux/continuous-integration/issues/78
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
> Side note: is it not correct to cite SHAs from linux-next in "Fixes
> commit ..." lines? I guess we can drop it.
>
> Link to regression build:
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/92799938
>
> Link to build w/ this patch:
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/92935901
>
>
>  arch/arm64/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index d42d00d8d5b6..dbdebf81162b 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -115,7 +115,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>   * later instructions. This ensures that a subsequent call to\
>   * udelay() will be ordered due to the ISB in get_cycles().\
>   */\
> -asm volatile("eor%0, %1, %1\n"\
> +asm volatile("eor%0, %x1, %x1\n"\
>       "cbnz%0, ."\
>       : "=r" (tmp) : "r" (v) : "memory");\
>  })
>

--
Julien Thierry
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
