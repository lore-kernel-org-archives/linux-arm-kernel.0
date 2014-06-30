From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jun 2014 15:38:41 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <mvmvbri4k06.fsf@hawking.suse.de>
References: <mvmvbri4k06.fsf@hawking.suse.de>
Message-ID: <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 15:14, Andreas Schwab <schwab@suse.de> wrote:
> This fixes the following build failure:
>
>   CC [M]  arch/arm64/crypto/aes-glue-ce.o
> ld: cannot find arch/arm64/crypto/aes-glue-ce.o: No such file or directory
> scripts/Makefile.build:393: recipe for target 'arch/arm64/crypto/aes-ce-blk.o' failed
> make[1]: *** [arch/arm64/crypto/aes-ce-blk.o] Error 1
> Makefile:893: recipe for target 'arch/arm64/crypto' failed
> make: *** [arch/arm64/crypto] Error 2
>
> The $(obj)/aes-glue-%.o rule only creates $(obj)/.tmp_aes-glue-ce.o, it
> should use if_changed_rule instead of if_changed_dep.
>

Oops, my bad

Out of curiosity, how did you trigger this failure? I have build this
code numerous times (and so have others) and I have never seen this
failure.

-- 
Ard.



> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/arm64/crypto/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index 2070a56..a3f935f 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -35,4 +35,4 @@ AFLAGS_aes-neon.o     := -DINTERLEAVE=4
>  CFLAGS_aes-glue-ce.o   := -DUSE_V8_CRYPTO_EXTENSIONS
>
>  $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
> -       $(call if_changed_dep,cc_o_c)
> +       $(call if_changed_rule,cc_o_c)
> --
> 2.0.1
>
> --
> Andreas Schwab, SUSE Labs, schwab at suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
