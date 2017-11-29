From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Nov 2017 12:15:14 +0000
Subject: [PATCH 3/3] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171129000011.55235-4-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-4-samitolvanen@google.com>
Message-ID: <CAKv+Gu99XM5jLcOTkqPJPj5oZnUCNv2c7C=5X2hFCM4-4_gwNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 November 2017 at 00:00, Sami Tolvanen <samitolvanen@google.com> wrote:
> From: Greg Hackmann <ghackmann@google.com>
>
> LLVM bug 30792 causes clang's AArch64 backend to crash compiling
> arch/arm64/crypto/aes-ce-cipher.c.  Replacing -mgeneral-regs-only with
> -mno-implicit-float is the suggested workaround.
>

Do we still need these patches now that the AES code has been fixed?

> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> [added clang-ifversion to enable the workaround only for clang <6.0]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b35788c909f1..d2efb5a0212f 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -49,7 +49,10 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>    endif
>  endif
>
> -KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +# This is a workaround for https://bugs.llvm.org/show_bug.cgi?id=30792.
> +KBUILD_CFLAGS  += $(call clang-ifversion, -lt, 0600, -mno-implicit-float, -mgeneral-regs-only)
> +
> +KBUILD_CFLAGS  += $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS  += $(call cc-option, -mpc-relative-literal-loads)
>  KBUILD_AFLAGS  += $(lseinstr) $(brokengasinst)
> --
> 2.15.0.417.g466bffb3ac-goog
>
