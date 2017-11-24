From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 Nov 2017 18:37:39 +1100
Subject: [PATCH v3] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <1966139.WIlnTlQG5u@positron.chronox.de>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <2510520.gYBNS8MAsP@positron.chronox.de>
 <20171110111058.GA25914@gondor.apana.org.au>
 <1966139.WIlnTlQG5u@positron.chronox.de>
Message-ID: <20171124073739.GB15597@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 01:20:55PM +0100, Stephan M?ller wrote:
> The code paths protected by the socket-lock do not use or modify the
> socket in a non-atomic fashion. The actions pertaining the socket do not
> even need to be handled as an atomic operation. Thus, the socket-lock
> can be safely ignored.
> 
> This fixes a bug regarding scheduling in atomic as the callback function
> may be invoked in interrupt context.
> 
> In addition, the sock_hold is moved before the AIO encrypt/decrypt
> operation to ensure that the socket is always present. This avoids a
> tiny race window where the socket is unprotected and yet used by the AIO
> operation.
> 
> Finally, the release of resources for a crypto operation is moved into a
> common function of af_alg_free_resources.
> 
> Fixes: e870456d8e7c8 ("crypto: algif_skcipher - overhaul memory management")
> Fixes: d887c52d6ae43 ("crypto: algif_aead - overhaul memory management")
> Reported-by: Romain Izard <romain.izard.pro@gmail.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
