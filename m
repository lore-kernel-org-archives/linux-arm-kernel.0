From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 21 Apr 2017 11:29:35 +0200
Subject: [PATCH v2 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170421073056.GA2041@Red>
References: <20170419071418.18995-1-antoine.tenart@free-electrons.com>
 <20170419071418.18995-3-antoine.tenart@free-electrons.com>
 <20170421073056.GA2041@Red>
Message-ID: <20170421092935.fszux3qg5hbwwobj@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Fri, Apr 21, 2017 at 09:30:56AM +0200, Corentin Labbe wrote:
> 
> I have some minor comment below

[?]

> > +	/*
> > +	 * Result Descriptor Ring prepare
> > +	 */
> 
> This is not preferred comment format for one line

Sure.

> 
> [...]
> 
> > +static int safexcel_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +	struct safexcel_crypto_priv *priv;
> > +	int i, ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(struct safexcel_crypto_priv),
> > +			    GFP_KERNEL);
> 
> sizeof(priv) is preferred as asked by checkpatch
> 
> [...]
> > +		ring_irq = devm_kzalloc(dev, sizeof(struct safexcel_ring_irq_data),
> > +					GFP_KERNEL);
> 
> same comment here

Sure.

> [...]
> > +#define EIP197_ALG_ARC4				BIT(7)
> > +#define EIP197_ALG_AES_ECB			BIT(8)
> > +#define EIP197_ALG_AES_CBC			BIT(9)
> > +#define EIP197_ALG_AES_CTR_ICM			BIT(10)
> > +#define EIP197_ALG_AES_OFB			BIT(11)
> > +#define EIP197_ALG_AES_CFB			BIT(12)
> > +#define EIP197_ALG_DES_ECB			BIT(13)
> > +#define EIP197_ALG_DES_CBC			BIT(14)
> > +#define EIP197_ALG_DES_OFB			BIT(16)
> > +#define EIP197_ALG_DES_CFB			BIT(17)
> > +#define EIP197_ALG_3DES_ECB			BIT(18)
> > +#define EIP197_ALG_3DES_CBC			BIT(19)
> > +#define EIP197_ALG_3DES_OFB			BIT(21)
> > +#define EIP197_ALG_3DES_CFB			BIT(22)
> > +#define EIP197_ALG_MD5				BIT(24)
> > +#define EIP197_ALG_HMAC_MD5			BIT(25)
> 
> Does MD5, DES and 3DES will be added later ?

They might be added yes. And as these bits describe a register used to
configure the engine it's nice to have a proper definition of what all
combinations do.

> [...]
> > +static const u8 sha1_zero_digest[SHA1_DIGEST_SIZE] = {
> > +	0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55,
> > +	0xbf, 0xef, 0x95, 0x60, 0x18, 0x90, 0xaf, 0xd8, 0x07, 0x09,
> > +};
> > +
> > +static const u8 sha224_zero_digest[SHA224_DIGEST_SIZE] = {
> > +	0xd1, 0x4a, 0x02, 0x8c, 0x2a, 0x3a, 0x2b, 0xc9, 0x47, 0x61,
> > +	0x02, 0xbb, 0x28, 0x82, 0x34, 0xc4, 0x15, 0xa2, 0xb0, 0x1f,
> > +	0x82, 0x8e, 0xa6, 0x2a, 0xc5, 0xb3, 0xe4, 0x2f
> > +};
> > +
> > +static const u8 sha256_zero_digest[SHA256_DIGEST_SIZE] = {
> > +	0xe3, 0xb0, 0xc4, 0x42, 0x98, 0xfc, 0x1c, 0x14, 0x9a, 0xfb,
> > +	0xf4, 0xc8, 0x99, 0x6f, 0xb9, 0x24, 0x27, 0xae, 0x41, 0xe4,
> > +	0x64, 0x9b, 0x93, 0x4c, 0xa4, 0x95, 0x99, 0x1b, 0x78, 0x52,
> > +	0xb8, 0x55
> > +};
> 
> Thoses structures are already defined in crypto (sha1_zero_message_hash, etc...)
> You can use it since you select SHAxxx in Kconfig

That's right, I'll use these definitions instead.

> [...]
> > +static int safexcel_hmac_init_pad(struct ahash_request *areq,
> > +				  unsigned int blocksize, const u8 *key,
> > +				  unsigned int keylen, u8 *ipad, u8 *opad)
> > +{
> > +	struct safexcel_ahash_result result;
> > +	struct scatterlist sg;
> > +	int ret, i;
> > +	u8 *keydup;
> > +
> > +	if (keylen <= blocksize) {
> > +		memcpy(ipad, key, keylen);
> > +	} else {
> > +		keydup = kmemdup(key, keylen, GFP_KERNEL);
> > +		if (!keydup)
> > +			return -ENOMEM;
> > +
> > +		ahash_request_set_callback(areq, CRYPTO_TFM_REQ_MAY_BACKLOG,
> > +					   safexcel_ahash_complete, &result);
> > +		sg_init_one(&sg, keydup, keylen);
> > +		ahash_request_set_crypt(areq, &sg, ipad, keylen);
> > +		init_completion(&result.completion);
> > +
> > +		ret = crypto_ahash_digest(areq);
> > +		if (ret == -EINPROGRESS) {
> > +			wait_for_completion_interruptible(&result.completion);
> > +			ret = result.error;
> > +		}
> > +
> > +		/* Avoid leaking */
> > +		memset(keydup, 0, keylen);
> 
> It is safer to use memzero_explicit

Good to know, I'll update.

> > +		kfree(keydup);
> > +
> > +		if (ret)
> > +			return ret;
> > +
> > +		keylen = crypto_ahash_digestsize(crypto_ahash_reqtfm(areq));
> > +	}
> > +
> > +	memset(ipad + keylen, 0, blocksize - keylen);
> > +	memcpy(opad, ipad, blocksize);
> > +
> > +	for (i = 0; i < blocksize; i++) {
> > +		ipad[i] ^= 0x36;
> > +		opad[i] ^= 0x5c;
> 
> What are these constant ?

They are defined in the HMAC RFC, as ipad and opad values. See
https://www.ietf.org/rfc/rfc2104.txt.

> [...]
> > +static int safexcel_hmac_sha1_setkey(struct crypto_ahash *tfm, const u8 *key,
> > +				     unsigned int keylen)
> > +{
> > +	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
> > +	struct safexcel_ahash_export_state istate, ostate;
> > +	int ret, i;
> > +
> > +	ret = safexcel_hmac_setkey("safexcel-sha1", key, keylen, &istate, &ostate);
> 
> Perhaps you could use the algname instead of "safexcel-sha1"

No we can't (as of now), because using the SHA implementation of this
driver for partial hashes require special treatments (which we do).

> > +	if (ret)
> > +		return ret;
> > +
> > +	memcpy(ctx->ipad, &istate.state, SHA1_DIGEST_SIZE);
> > +	memcpy(ctx->opad, &ostate.state, SHA1_DIGEST_SIZE);
> 
> Perhaps you could the digest_size from alg_template

Well, this HMAC setkey function is dedicated to SHA1 for other reasons
than only this digest size. So why bother retrieving something which we
know is already fixed?

> [...]
> > +struct safexcel_alg_template safexcel_alg_sha256 = {
> > +	.type = SAFEXCEL_ALG_TYPE_AHASH,
> > +	.alg.ahash = {
> > +		.init = safexcel_sha256_init,
> > +		.update = safexcel_ahash_update,
> > +		.final = safexcel_ahash_final,
> > +		.finup = safexcel_ahash_finup,
> > +		.digest = safexcel_sha256_digest,
> > +		.export = safexcel_ahash_export,
> > +		.import = safexcel_ahash_import,
> > +		.halg = {
> > +			.digestsize = SHA256_DIGEST_SIZE,
> > +			.statesize = sizeof(struct safexcel_ahash_export_state),
> > +			.base = {
> > +				.cra_name = "sha256",
> > +				.cra_driver_name = "safexcel-sha256",
> > +				.cra_priority = 300,
> > +				.cra_flags = CRYPTO_ALG_ASYNC |
> > +					     CRYPTO_ALG_KERN_DRIVER_ONLY,
> 
> Why do use CRYPTO_ALG_KERN_DRIVER_ONLY ?

See http://lxr.free-electrons.com/source/include/linux/crypto.h#L97.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170421/11564af3/attachment-0001.sig>
