From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 18:00:01 +0100
Subject: [PATCH] arm/arm64/crypto: assure that ECB modes don't require an
 IV
In-Reply-To: <1455292072-5236-1-git-send-email-jeremy.linton@arm.com>
References: <1455292072-5236-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <CAKv+Gu8_Z5=0dTeBsVgx_BT0c+_O5PNUCyKFjuDf9x470bxHOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 16:47, Jeremy Linton <jeremy.linton@arm.com> wrote:
> ECB modes don't use an initialization vector. The kernel
> /proc/crypto interface doesn't reflect this properly.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks for spotting that!

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/crypto/aes-ce-glue.c | 4 ++--
>  arch/arm64/crypto/aes-glue.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
> index b445a5d..89a3a3e 100644
> --- a/arch/arm/crypto/aes-ce-glue.c
> +++ b/arch/arm/crypto/aes-ce-glue.c
> @@ -364,7 +364,7 @@ static struct crypto_alg aes_algs[] = { {
>         .cra_blkcipher = {
>                 .min_keysize    = AES_MIN_KEY_SIZE,
>                 .max_keysize    = AES_MAX_KEY_SIZE,
> -               .ivsize         = AES_BLOCK_SIZE,
> +               .ivsize         = 0,
>                 .setkey         = ce_aes_setkey,
>                 .encrypt        = ecb_encrypt,
>                 .decrypt        = ecb_decrypt,
> @@ -441,7 +441,7 @@ static struct crypto_alg aes_algs[] = { {
>         .cra_ablkcipher = {
>                 .min_keysize    = AES_MIN_KEY_SIZE,
>                 .max_keysize    = AES_MAX_KEY_SIZE,
> -               .ivsize         = AES_BLOCK_SIZE,
> +               .ivsize         = 0,
>                 .setkey         = ablk_set_key,
>                 .encrypt        = ablk_encrypt,
>                 .decrypt        = ablk_decrypt,
> diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
> index 05d9e16..7a3d22a 100644
> --- a/arch/arm64/crypto/aes-glue.c
> +++ b/arch/arm64/crypto/aes-glue.c
> @@ -294,7 +294,7 @@ static struct crypto_alg aes_algs[] = { {
>         .cra_blkcipher = {
>                 .min_keysize    = AES_MIN_KEY_SIZE,
>                 .max_keysize    = AES_MAX_KEY_SIZE,
> -               .ivsize         = AES_BLOCK_SIZE,
> +               .ivsize         = 0,
>                 .setkey         = aes_setkey,
>                 .encrypt        = ecb_encrypt,
>                 .decrypt        = ecb_decrypt,
> @@ -371,7 +371,7 @@ static struct crypto_alg aes_algs[] = { {
>         .cra_ablkcipher = {
>                 .min_keysize    = AES_MIN_KEY_SIZE,
>                 .max_keysize    = AES_MAX_KEY_SIZE,
> -               .ivsize         = AES_BLOCK_SIZE,
> +               .ivsize         = 0,
>                 .setkey         = ablk_set_key,
>                 .encrypt        = ablk_encrypt,
>                 .decrypt        = ablk_decrypt,
> --
> 2.4.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
