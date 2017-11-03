From: smueller@chronox.de (Stephan Mueller)
Date: Fri, 03 Nov 2017 14:34:44 +0100
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <20171103132016.GB8330@gondor.apana.org.au>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <5260911.ZuXsrgFD2R@positron.chronox.de>
 <20171103132016.GB8330@gondor.apana.org.au>
Message-ID: <1516308.8nf3SO2l11@tauon.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. November 2017, 14:20:16 CET schrieb Herbert Xu:

Hi Herbert,

> On Sun, Oct 29, 2017 at 09:39:30PM +0100, Stephan M?ller wrote:
> > Am Mittwoch, 25. Oktober 2017, 17:26:31 CET schrieb Romain Izard:
> > 
> > Hi Romain,
> > 
> > the patch below should cover the issue you see. Would you mind testing it?
> > 
> > Thanks
> > Stephan
> > 
> > ---8<---
> > 
> > The code paths protected by the socket-lock do not use or modify the
> > socket in a non-atomic fashion. The actions pertaining the socket do not
> > even need to be handled as an atomic operation. Thus, the socket-lock
> > can be safely ignored.
> 
> Are you sure about that? In particular is the callback function still
> sane without the socket lock if a concurrent recvmsg/sendmsg call is
> made?

resultlen receives its data from the async_request -> no socket

af_alg_free_areq_sgls(areq) does not require a socket, but it uses the socket 
to find the data structures -> I do not see that the socket is operated on 
though. The socket will always be alive as the sk_refcnt is not yet 
decremented by __sock_put.

sock_kfree_s uses an atomic operation

__sock_put uses an atomic operation

iocb->ki_complete does not use the socket

Where would you think that the lock is needed?
> 
> Your fixes header is wrong too as the locks weren't introduced in that
> commit, they just got moved around.

Neither the skcipher_async_cb nor aead_async_cb up to and including 4.13 
contain any lock.

Ciao
Stephan
