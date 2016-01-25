From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 25 Jan 2016 15:23:34 +0800
Subject: [PATCH 5/5] crypto: atmel-sha: fix algorihtm registration
In-Reply-To: <49c8ccb4a2bd61eaab85d0cceba592f41ce7f21c.1452867917.git.cyrille.pitchen@atmel.com>
References: <cover.1452867917.git.cyrille.pitchen@atmel.com>
 <49c8ccb4a2bd61eaab85d0cceba592f41ce7f21c.1452867917.git.cyrille.pitchen@atmel.com>
Message-ID: <20160125072334.GC5609@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 03:49:35PM +0100, Cyrille Pitchen wrote:
>
> +static int atmel_sha_export(struct ahash_request *req, void *out)
> +{
> +	const struct atmel_sha_reqctx *ctx = ahash_request_ctx(req);
> +	struct atmel_sha_state *state = out;
> +
> +	memcpy(state->digest, ctx->digest, SHA512_DIGEST_SIZE);
> +	memcpy(state->buffer, ctx->buffer, ctx->bufcnt);
> +	state->bufcnt = ctx->bufcnt;
> +	state->digcnt[0] = ctx->digcnt[0];
> +	state->digcnt[1] = ctx->digcnt[1];
> +	return 0;
> +}

Hmm, you're assuming that out is aligned but that is not necessarily
the case.  Ditto for import.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
