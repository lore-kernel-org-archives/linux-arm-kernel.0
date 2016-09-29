From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Sep 2016 16:37:16 -0700
Subject: [PATCH] crypto: arm64/sha256 - add support for SHA256 using NEON
 instructions
In-Reply-To: <1475189503-9175-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1475189503-9175-1-git-send-email-ard.biesheuvel@linaro.org>
 <1475189503-9175-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8J9rHA2opKqHQr74GU6xxwMpaJak1mNpRVpOf=+BZ81w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2016 at 15:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This is a port to arm64 of the NEON implementation of SHA256 that lives
> under arch/arm/crypto.
>
> Due to the fact that the AArch64 assembler dialect deviates from the
> 32-bit ARM one in ways that makes sharing code problematic, and given
> that this version only uses the NEON version whereas the original
> implementation supports plain ALU assembler, NEON and Crypto Extensions,
> this code is built from a version sha256-armv4.pl that has been
> transliterated to the AArch64 NEON dialect.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/crypto/Kconfig               |   5 +
>  arch/arm64/crypto/Makefile              |  11 +
>  arch/arm64/crypto/sha256-armv4.pl       | 413 +++++++++
>  arch/arm64/crypto/sha256-core.S_shipped | 883 ++++++++++++++++++++
>  arch/arm64/crypto/sha256_neon_glue.c    | 103 +++
>  5 files changed, 1415 insertions(+)
>
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index 2cf32e9887e1..d32371198474 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -18,6 +18,11 @@ config CRYPTO_SHA2_ARM64_CE
>         depends on ARM64 && KERNEL_MODE_NEON
>         select CRYPTO_HASH
>
> +config CRYPTO_SHA2_ARM64_NEON
> +       tristate "SHA-224/SHA-256 digest algorithm (ARMv8 NEON)"
> +       depends on ARM64 && KERNEL_MODE_NEON
> +       select CRYPTO_HASH
> +
>  config CRYPTO_GHASH_ARM64_CE
>         tristate "GHASH (for GCM chaining mode) using ARMv8 Crypto Extensions"
>         depends on ARM64 && KERNEL_MODE_NEON
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index abb79b3cfcfe..5156ebee0488 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -29,6 +29,9 @@ aes-ce-blk-y := aes-glue-ce.o aes-ce.o
>  obj-$(CONFIG_CRYPTO_AES_ARM64_NEON_BLK) += aes-neon-blk.o
>  aes-neon-blk-y := aes-glue-neon.o aes-neon.o
>
> +obj-$(CONFIG_CRYPTO_SHA2_ARM64_NEON) := sha256-neon.o

There is a typo here that I only spotted just now: this should be += not :=

Herbert, if you're picking this up, could you please fix this at merge
time? Or do you need me to resend?

Thanks,
Ard.
