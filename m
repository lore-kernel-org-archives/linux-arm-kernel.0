From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 7 Nov 2017 14:32:12 +0800
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <4677171.2qOLUIFS1s@positron.chronox.de>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <1977235.9AvJZzduGj@tauon.chronox.de>
 <20171107052235.GA20803@gondor.apana.org.au>
 <4677171.2qOLUIFS1s@positron.chronox.de>
Message-ID: <20171107063212.GA25491@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 07:19:32AM +0100, Stephan M?ller wrote:
> 
> Where I am not fully sure is whether af_alg_async_cb is called in any case. 
> I.e. when we invoke an AIO operation with a cipher that completes 
> synchronously (e.g. AES-NI), is this callback triggered?

It's the same with any other callback in the crypto API.  The
completion function is called if the return value is EINPROGRESS
or EBUSY.

In fact the algif_aead/algif_skcipher code already frees the SG lists
and areq on a sync return.  So perhaps you can merge this with the
completion function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
