From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:02:57 +0000
Subject: [PATCH 07/15] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171103171203.107569-9-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-9-samitolvanen@google.com>
Message-ID: <20171103180257.e52r2qdeeg4m4l5p@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 10:11:52AM -0700, Sami Tolvanen wrote:
> From: Greg Hackmann <ghackmann@google.com>
> 
> LLVM bug 30792 causes clang's AArch64 backend to crash compiling
> arch/arm64/crypto/aes-ce-cipher.c.  Replacing -mgeneral-regs-only with
> -mno-implicit-float is the suggested workaround.
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Ah, so I guess this is what I was hitting when testing with clang 5.0.0.

I was under the impression that this series was jsut enablnig LTO
support, not clang support generally.

It would be much nicer if we could depend on a fixed clang to start
with...

Thanks,
Mark.

> ---
>  arch/arm64/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 939b310913cf..eb6f3c9ec6cb 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -45,7 +45,13 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>    endif
>  endif
>  
> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +ifeq ($(cc-name),clang)
> +# This is a workaround for https://bugs.llvm.org/show_bug.cgi?id=30792.
> +KBUILD_CFLAGS	+= -mno-implicit-float
> +else
> +KBUILD_CFLAGS	+= -mgeneral-regs-only
> +endif
> +KBUILD_CFLAGS	+= $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
>  KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
> -- 
> 2.15.0.403.gc27cc4dac6-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
