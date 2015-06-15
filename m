From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 17:54:21 +0800
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150615095421.GA32158@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
>
> +static int mv_cesa_cbc_aes_op(struct ablkcipher_request *req,
> +			      struct mv_cesa_op_ctx *tmpl)
> +{
> +	mv_cesa_update_op_cfg(tmpl, CESA_SA_DESC_CFG_CRYPTCM_CBC,
> +			      CESA_SA_DESC_CFG_CRYPTCM_MSK);
> +	memcpy(tmpl->ctx.blkcipher.iv, req->info, 16);

You need to copy the IV back into req->info after completion.

Incidentally we don't seem to test for output IVs in our self-
test so bugs like this can slip through until someone tries to
do chaining with it.  That's something worth adding to testmgr.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
