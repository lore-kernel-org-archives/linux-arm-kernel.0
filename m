From: smueller@chronox.de (Stephan Mueller)
Date: Mon, 06 Nov 2017 17:06:09 +0100
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <20171103132016.GB8330@gondor.apana.org.au>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <5260911.ZuXsrgFD2R@positron.chronox.de>
 <20171103132016.GB8330@gondor.apana.org.au>
Message-ID: <1977235.9AvJZzduGj@tauon.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. November 2017, 14:20:16 CET schrieb Herbert Xu:

Hi Herbert,

> > 
> > The code paths protected by the socket-lock do not use or modify the
> > socket in a non-atomic fashion. The actions pertaining the socket do not
> > even need to be handled as an atomic operation. Thus, the socket-lock
> > can be safely ignored.
> 
> Are you sure about that? In particular is the callback function still
> sane without the socket lock if a concurrent recvmsg/sendmsg call is
> made?

I reviewed the code again and I cannot find a reason for keeping the lock. All 
we need to ensure is that the socket exists. This is ensured with the refcount 
of the socket released by __sock_put().

Would you mind helping me where you think the lock is needed.
> 
> Your fixes header is wrong too as the locks weren't introduced in that
> commit, they just got moved around.

Correct, the initial introduction was in 
e870456d8e7c8d57c059ea479b5aadbb55ff4c3a (algif_skcipher) and 
d887c52d6ae43aeebd249b5f2f1333e60236aa60 (algif_aead)

Thanks a lot.

Ciao
Stephan
