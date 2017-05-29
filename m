From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 29 May 2017 16:47:57 +0200
Subject: [PATCH 09/11] crypto: sun4i-ss: move from ablkcipher to skcipher
 API
In-Reply-To: <20170524190652.13278-10-antoine.tenart@free-electrons.com>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
 <20170524190652.13278-10-antoine.tenart@free-electrons.com>
Message-ID: <20170529144757.GA23017@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 09:06:50PM +0200, Antoine Tenart wrote:
> Update the sun4i-ss driver to use the skcipher API instead of the old
> ablkcipher one. It's a bit more tricky than s/ablkcipher/skcipher/, but
> still nothing special and the driver's logic stays the same.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 189 ++++++++++++-------------
>  drivers/crypto/sunxi-ss/sun4i-ss-core.c   | 227 +++++++++++++++---------------
>  drivers/crypto/sunxi-ss/sun4i-ss.h        |  34 ++---
>  3 files changed, 226 insertions(+), 224 deletions(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> index 23e549204365..5cf64746731a 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> -{       .type = CRYPTO_ALG_TYPE_ABLKCIPHER,
> +{       .type = CRYPTO_ALG_TYPE_SKCIPHER,
>  	.alg.crypto = {
> -		.cra_name = "cbc(aes)",
> -		.cra_driver_name = "cbc-aes-sun4i-ss",
> -		.cra_priority = 300,
> -		.cra_blocksize = AES_BLOCK_SIZE,
> -		.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER,
> -		.cra_ctxsize = sizeof(struct sun4i_tfm_ctx),
> -		.cra_module = THIS_MODULE,
> -		.cra_alignmask = 3,
> -		.cra_type = &crypto_ablkcipher_type,
> -		.cra_init = sun4i_ss_cipher_init,
> -		.cra_ablkcipher = {
> -			.min_keysize	= AES_MIN_KEY_SIZE,
> -			.max_keysize	= AES_MAX_KEY_SIZE,
> -			.ivsize		= AES_BLOCK_SIZE,
> -			.setkey         = sun4i_ss_aes_setkey,
> -			.encrypt        = sun4i_ss_cbc_aes_encrypt,
> -			.decrypt        = sun4i_ss_cbc_aes_decrypt,
> +		.setkey         = sun4i_ss_aes_setkey,
> +		.encrypt        = sun4i_ss_cbc_aes_encrypt,
> +		.decrypt        = sun4i_ss_cbc_aes_decrypt,
> +		.min_keysize	= AES_MIN_KEY_SIZE,
> +		.max_keysize	= AES_MAX_KEY_SIZE,
> +		.ivsize		= AES_BLOCK_SIZE,
> +		.base = {
> +			.cra_name = "cbc(aes)",
> +			.cra_driver_name = "cbc-aes-sun4i-ss",
> +			.cra_priority = 300,
> +			.cra_blocksize = AES_BLOCK_SIZE,
> +			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> +				     CRYPTO_ALG_KERN_DRIVER_ONLY,

Hello

You add CRYPTO_ALG_KERN_DRIVER_ONLY on all flags which is unrelated to the patch description.

Regards
