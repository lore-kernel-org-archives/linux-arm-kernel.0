From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Tue, 07 Nov 2017 07:19:32 +0100
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <20171107052235.GA20803@gondor.apana.org.au>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <1977235.9AvJZzduGj@tauon.chronox.de>
 <20171107052235.GA20803@gondor.apana.org.au>
Message-ID: <4677171.2qOLUIFS1s@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. November 2017, 06:22:35 CET schrieb Herbert Xu:

Hi Herbert,

> On Mon, Nov 06, 2017 at 05:06:09PM +0100, Stephan Mueller wrote:
> > Am Freitag, 3. November 2017, 14:20:16 CET schrieb Herbert Xu:
> > > Are you sure about that? In particular is the callback function still
> > > sane without the socket lock if a concurrent recvmsg/sendmsg call is
> > > made?
> > 
> > I reviewed the code again and I cannot find a reason for keeping the lock.
> > All we need to ensure is that the socket exists. This is ensured with the
> > refcount of the socket released by __sock_put().
> 
> OK, I can't see why we need a lock there either.  However, the call
> to __sock_put looks suspicious.  Why isn't this using sock_put?

I simply ported the existing code from algif_aead over -- but I think you are 
right that sock_put is more appropriate.
> 
> Also the sock_hold on the caller side looks buggy.  Surely it needs
> to be made before we even call the encrypt/decrypt functions rather
> than after it returns EINPROGRESS at which point it may well be too
> late?

I would concur. The sock_hold would need to be moved from the EINPROGRESS 
conditional to before the AIO enc/dec operation is invoked.

Where I am not fully sure is whether af_alg_async_cb is called in any case. 
I.e. when we invoke an AIO operation with a cipher that completes 
synchronously (e.g. AES-NI), is this callback triggered?

Ciao
Stephan
