From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 26 Sep 2013 14:13:33 +0200
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <1380194306-5243-2-git-send-email-marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
Message-ID: <21060.9453.908125.71858@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

some small comments below.

Marek Vasut writes:
> diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
> new file mode 100644
> index 0000000..c2b35c7
> --- /dev/null
> +++ b/drivers/crypto/mxs-dcp.c
[...]
> +/* AES 128 ECB and AES 128 CBC */
> +static struct crypto_alg dcp_aes_algs[] = {
> +	[0] = {
> +		.cra_name		= "ecb(aes)",
> +		.cra_driver_name	= "ecb-aes-dcp",
> +		.cra_priority		= 400,
> +		.cra_alignmask		= 15,
> +		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
> +					  CRYPTO_ALG_ASYNC |
> +					  CRYPTO_ALG_NEED_FALLBACK,
> +		.cra_init		= mxs_dcp_aes_fallback_init,
> +		.cra_exit		= mxs_dcp_aes_fallback_exit,
> +		.cra_blocksize		= AES_BLOCK_SIZE,
> +		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> +		.cra_type		= &crypto_ablkcipher_type,
> +		.cra_module		= THIS_MODULE,
> +		.cra_u	= {
> +			.ablkcipher = {
> +				.min_keysize	= AES_MIN_KEY_SIZE,
> +				.max_keysize	= AES_MAX_KEY_SIZE,
> +				.setkey		= mxs_dcp_aes_setkey,
> +				.encrypt	= mxs_dcp_aes_ecb_encrypt,
> +				.decrypt	= mxs_dcp_aes_ecb_decrypt
> +			}
missing ',' after '}'
> +		}
dto.

> +	},
> +	[1] = {
> +		.cra_name		= "cbc(aes)",
> +		.cra_driver_name	= "cbc-aes-dcp",
> +		.cra_priority		= 400,
> +		.cra_alignmask		= 15,
> +		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
> +					  CRYPTO_ALG_ASYNC |
> +					  CRYPTO_ALG_NEED_FALLBACK,
> +		.cra_init		= mxs_dcp_aes_fallback_init,
> +		.cra_exit		= mxs_dcp_aes_fallback_exit,
> +		.cra_blocksize		= AES_BLOCK_SIZE,
> +		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> +		.cra_type		= &crypto_ablkcipher_type,
> +		.cra_module		= THIS_MODULE,
> +		.cra_u = {
> +			.ablkcipher = {
> +				.min_keysize	= AES_MIN_KEY_SIZE,
> +				.max_keysize	= AES_MAX_KEY_SIZE,
> +				.setkey		= mxs_dcp_aes_setkey,
> +				.encrypt	= mxs_dcp_aes_cbc_encrypt,
> +				.decrypt	= mxs_dcp_aes_cbc_decrypt,
> +				.ivsize		= AES_BLOCK_SIZE,
> +			}
dto.
> +		}
dto.
> +	},
> +};
> +
> +/* SHA1 */
> +static struct ahash_alg dcp_sha1_alg = {
> +	.init	= dcp_sha_init,
> +	.update	= dcp_sha_update,
> +	.final	= dcp_sha_final,
> +	.finup	= dcp_sha_finup,
> +	.digest	= dcp_sha_digest,
> +	.halg	= {
> +		.digestsize	= SHA1_DIGEST_SIZE,
> +		.base		= {
> +			.cra_name		= "sha1",
> +			.cra_driver_name	= "sha1-dcp",
> +			.cra_priority		= 400,
> +			.cra_alignmask		= 63,
> +			.cra_flags		= CRYPTO_ALG_ASYNC,
> +			.cra_blocksize		= SHA1_BLOCK_SIZE,
> +			.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> +			.cra_module		= THIS_MODULE,
> +			.cra_init		= dcp_sha_cra_init,
> +			.cra_exit		= dcp_sha_cra_exit,
> +		}
dto.
> +	}
dto.

> +};
> +
> +/* SHA256 */
> +static struct ahash_alg dcp_sha256_alg = {
> +	.init	= dcp_sha_init,
> +	.update	= dcp_sha_update,
> +	.final	= dcp_sha_final,
> +	.finup	= dcp_sha_finup,
> +	.digest	= dcp_sha_digest,
> +	.halg	= {
> +		.digestsize	= SHA256_DIGEST_SIZE,
> +		.base		= {
> +			.cra_name		= "sha256",
> +			.cra_driver_name	= "sha256-dcp",
> +			.cra_priority		= 400,
> +			.cra_alignmask		= 63,
> +			.cra_flags		= CRYPTO_ALG_ASYNC,
> +			.cra_blocksize		= SHA256_BLOCK_SIZE,
> +			.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> +			.cra_module		= THIS_MODULE,
> +			.cra_init		= dcp_sha_cra_init,
> +			.cra_exit		= dcp_sha_cra_exit,
> +		}
dto.
> +	}
dto.

> +static const struct of_device_id mxs_dcp_dt_ids[] = {
> +	{.compatible = "fsl,mxs-dcp", .data = NULL,},
>
missing spaces after '{' and before '}'


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
