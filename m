From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 2 Jan 2014 19:16:46 +0100
Subject: [PATCH RFC] CRYPTO: Fix more AES build errors:
In-Reply-To: <E1Vylu8-0005Q9-MO@rmk-PC.arm.linux.org.uk>
References: <E1Vylu8-0005Q9-MO@rmk-PC.arm.linux.org.uk>
Message-ID: <CAKv+Gu9SrF_jkNc1ie+AX07YVGUdAYMGoKnJopFyirwh=acDVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 January 2014 18:17, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Building a multi-arch kernel results in:
>
> arch/arm/crypto/built-in.o: In function `aesbs_xts_decrypt':
> sha1_glue.c:(.text+0x15c8): undefined reference to `bsaes_xts_decrypt'
> arch/arm/crypto/built-in.o: In function `aesbs_xts_encrypt':
> sha1_glue.c:(.text+0x1664): undefined reference to `bsaes_xts_encrypt'
> arch/arm/crypto/built-in.o: In function `aesbs_ctr_encrypt':
> sha1_glue.c:(.text+0x184c): undefined reference to `bsaes_ctr32_encrypt_blocks'
> arch/arm/crypto/built-in.o: In function `aesbs_cbc_decrypt':
> sha1_glue.c:(.text+0x19b4): undefined reference to `bsaes_cbc_encrypt'
>

Interestingly, when I try to reproduce this, the reference is
(correctly) reported to reside in aesbs-glue.c and not sha1_glue.c

> This code is already runtime-conditional on NEON being supported, so
> there's no point compiling it out depending on the minimum build
> architecture.
>

Agreed. It is a leftover from the way this code was embedded into
OpenSSL originally.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is more a request for acks since I'd like to keep it/push it through
> my tree to reduce the autobuilder failures.
>
>  arch/arm/crypto/bsaes-armv7.pl |    2 +-

The .S_shipped file produced by this script should be updated at the same time.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


Regards,
Ard.



>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/crypto/bsaes-armv7.pl b/arch/arm/crypto/bsaes-armv7.pl
> index f3d96d932573..be068db960ee 100644
> --- a/arch/arm/crypto/bsaes-armv7.pl
> +++ b/arch/arm/crypto/bsaes-armv7.pl
> @@ -701,7 +701,7 @@ $code.=<<___;
>  # define VFP_ABI_FRAME 0
>  # define BSAES_ASM_EXTENDED_KEY
>  # define XTS_CHAIN_TWEAK
> -# define __ARM_ARCH__ __LINUX_ARM_ARCH__
> +# define __ARM_ARCH__  7
>  #endif
>
>  #ifdef __thumb__
> --
> 1.7.4.4
>
