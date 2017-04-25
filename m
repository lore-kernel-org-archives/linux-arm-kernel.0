From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 25 Apr 2017 08:53:40 +0200
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <2475079.gcOV5qCq7E@tauon.chronox.de>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
 <2475079.gcOV5qCq7E@tauon.chronox.de>
Message-ID: <20170425065340.xdhmilo5caswkmxp@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

On Mon, Apr 24, 2017 at 02:59:05PM +0200, Stephan M?ller wrote:
> Am Montag, 24. April 2017, 09:54:06 CEST schrieb Antoine Tenart:
> 
> > +struct safexcel_cipher_ctx {
> > +	struct safexcel_context base;
> > +	struct safexcel_crypto_priv *priv;
> > +
> > +	enum safexcel_cipher_direction direction;
> > +	u32 mode;
> > +
> > +	__le32 key[8];
> 
> Can you please help me find the location where this memory is zeroized when 
> released?

It's not, I'll fix this.

> > +static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx,
> > +				  struct crypto_async_request *async,
> > +				  struct safexcel_command_desc *cdesc,
> > +				  u32 length)
> > +{
> > +	struct ablkcipher_request *req = ablkcipher_request_cast(async);
> > +	struct safexcel_token *token;
> > +	unsigned offset = 0;
> > +
> > +	if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CBC) {
> > +		offset = AES_BLOCK_SIZE / sizeof(u32);
> > +		memcpy(cdesc->control_data.token, req->info, AES_BLOCK_SIZE);
> > +
> > +		cdesc->control_data.options |= EIP197_OPTION_4_TOKEN_IV_CMD;
> > +	}
> > +
> > +	token = (struct safexcel_token *)(cdesc->control_data.token + offset);
> > +
> > +	token[0].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
> > +	token[0].packet_length = length;
> > +	token[0].stat = EIP197_TOKEN_STAT_LAST_PACKET;
> > +	token[0].instructions = EIP197_TOKEN_INS_LAST |
> > +				EIP197_TOKEN_INS_TYPE_CRYTO |
> > +				EIP197_TOKEN_INS_TYPE_OUTPUT;
> > +}
> > +
> > +static int safexcel_aes_setkey(struct crypto_ablkcipher *ctfm, const u8
> > *key, +			       unsigned int len)
> > +{
> 
> You still use ablkcipher. I thought that it is on its way out in favor of the 
> skcipher API. Why do you stick to ablkcipher?
> 
> Note, a change could be as simple as s/ablkcipher/skcipher/g

Because I wasn't aware of this :) I'll update.

> > +	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(ctfm);
> > +	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
> > +	struct crypto_aes_ctx aes;
> > +	int ret, i;
> > +
> > +	ret = crypto_aes_expand_key(&aes, key, len);
> > +	if (ret) {
> > +		crypto_ablkcipher_set_flags(ctfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < len / sizeof(u32); i++) {
> > +		if (ctx->key[i] != cpu_to_le32(aes.key_enc[i])) {
> > +			ctx->base.needs_inv = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < len / sizeof(u32); i++)
> > +		ctx->key[i] = cpu_to_le32(aes.key_enc[i]);
> > +
> > +	ctx->key_len = len;
> 
> memzero_explicit(aes)?

OK, I'll update.

> > +static int safexcel_aes_send(struct crypto_async_request *async,
> > +			     int ring, struct safexcel_request *request,
> > +			     int *commands, int *results)
> > +{
> > +	struct ablkcipher_request *req = ablkcipher_request_cast(async);
> > +	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
> > +	struct safexcel_crypto_priv *priv = ctx->priv;
> > +	struct safexcel_command_desc *cdesc;
> > +	struct safexcel_result_desc *rdesc;
> > +	struct scatterlist *sg;
> > +	int nr_src, nr_dst, n_cdesc = 0, n_rdesc = 0, queued = req->nbytes;
> > +	int i, ret = 0;
> > +
> > +	request->req = &req->base;
> > +
> > +	if (req->src == req->dst) {
> > +		nr_src = dma_map_sg(priv->dev, req->src,
> > +				    sg_nents_for_len(req->src, req->nbytes),
> > +				    DMA_BIDIRECTIONAL);
> > +		nr_dst = nr_src;
> > +		if (!nr_src)
> > +			return -EINVAL;
> > +	} else {
> > +		nr_src = dma_map_sg(priv->dev, req->src,
> > +				    sg_nents_for_len(req->src, req->nbytes),
> > +				    DMA_TO_DEVICE);
> > +		if (!nr_src)
> > +			return -EINVAL;
> > +
> > +		nr_dst = dma_map_sg(priv->dev, req->dst,
> > +				    sg_nents_for_len(req->dst, req->nbytes),
> > +				    DMA_FROM_DEVICE);
> > +		if (!nr_dst) {
> > +			dma_unmap_sg(priv->dev, req->src,
> > +				     sg_nents_for_len(req->src, req->nbytes),
> > +				     DMA_TO_DEVICE);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	memcpy(ctx->base.ctxr->data, ctx->key, ctx->key_len);
> 
> Is ctxr->data properly zeroized?

No, I'll update.

Thanks for the review!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/4970b066/attachment-0001.sig>
