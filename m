From: smueller@chronox.de (Stephan Mueller)
Date: Fri, 24 Nov 2017 17:04:19 +0100
Subject: [PATCH v3] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <20171124073739.GB15597@gondor.apana.org.au>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <1966139.WIlnTlQG5u@positron.chronox.de>
 <20171124073739.GB15597@gondor.apana.org.au>
Message-ID: <12422115.UWn9hbrTTi@tauon.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 24. November 2017, 08:37:39 CET schrieb Herbert Xu:

Hi Herbert,

> On Fri, Nov 10, 2017 at 01:20:55PM +0100, Stephan M?ller wrote:
> > The code paths protected by the socket-lock do not use or modify the
> > socket in a non-atomic fashion. The actions pertaining the socket do not
> > even need to be handled as an atomic operation. Thus, the socket-lock
> > can be safely ignored.
> > 
> > This fixes a bug regarding scheduling in atomic as the callback function
> > may be invoked in interrupt context.
> > 
> > In addition, the sock_hold is moved before the AIO encrypt/decrypt
> > operation to ensure that the socket is always present. This avoids a
> > tiny race window where the socket is unprotected and yet used by the AIO
> > operation.
> > 
> > Finally, the release of resources for a crypto operation is moved into a
> > common function of af_alg_free_resources.
> > 
> > Fixes: e870456d8e7c8 ("crypto: algif_skcipher - overhaul memory
> > management") Fixes: d887c52d6ae43 ("crypto: algif_aead - overhaul memory
> > management") Reported-by: Romain Izard <romain.izard.pro@gmail.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> 
> Patch applied.  Thanks.

Thanks a lot.

Would it make sense to feed it to stable?

Ciao
Stephan
