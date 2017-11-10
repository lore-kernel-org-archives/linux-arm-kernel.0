From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 10 Nov 2017 22:10:58 +1100
Subject: [PATCH v2] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <2510520.gYBNS8MAsP@positron.chronox.de>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <4677171.2qOLUIFS1s@positron.chronox.de>
 <20171107063212.GA25491@gondor.apana.org.au>
 <2510520.gYBNS8MAsP@positron.chronox.de>
Message-ID: <20171110111058.GA25914@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:05:48AM +0100, Stephan M?ller wrote:
>  
>  	if (msg->msg_iocb && !is_sync_kiocb(msg->msg_iocb)) {
>  		/* AIO operation */
> +		sock_hold(sk);
>  		areq->iocb = msg->msg_iocb;
>  		aead_request_set_callback(&areq->cra_u.aead_req,
>  					  CRYPTO_TFM_REQ_MAY_BACKLOG,
>  					  af_alg_async_cb, areq);
>  		err = ctx->enc ? crypto_aead_encrypt(&areq->cra_u.aead_req) :
>  				 crypto_aead_decrypt(&areq->cra_u.aead_req);
> +
> +		/* AIO operation in progress */
> +		if (err == -EINPROGRESS) {
> +			/* Remember output size that will be generated. */
> +			areq->outlen = outlen;
> +
> +			return -EIOCBQUEUED;
> +		}

Since we're allowing backlogs, what about EBUSY?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
