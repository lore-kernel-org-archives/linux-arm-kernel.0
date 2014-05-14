From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 14 May 2014 09:36:39 +0800
Subject: [PATCH resend 13/15] arm64/crypto: add voluntary preemption to
 Crypto Extensions SHA1
In-Reply-To: <1398959486-8222-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140514013639.GA29126@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> +               /*
> +                * Pass current's thread info pointer to sha1_ce_transform()
> +                * below if we want it to play nice under preemption.
> +                */
> +               if ((IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY) ||
> +                    IS_ENABLED(CONFIG_PREEMPT)) && !in_interrupt())
> +                       ti = current_thread_info();

Instead of in_interrupt you should test CRYPTO_TFM_REQ_MAY_SLEEP.
It's not a matter of correctness but it may avoid unnecessary
breaks in the loop.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
