From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Sun, 25 Apr 2010 17:29:28 +0200
Subject: [PATCH] net/ipsec: don't treat EINPROGRESS as a regular error
In-Reply-To: <20100425011821.GA5284@gondor.apana.org.au>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
	<20100418191719.GA2508@Chamillionaire.breakpoint.cc>
	<4BCE125F.30200@gmail.com>
	<20100424144215.GA9057@Chamillionaire.breakpoint.cc>
	<20100425011821.GA5284@gondor.apana.org.au>
Message-ID: <20100425152928.GA14489@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Herbert Xu | 2010-04-25 09:18:21 [+0800]:

>This should only be possible when we use the MAY_BACKLOG flag,
>as otherwise EINPROGRESS should never be used on the completion
>function unless it's a real error.
Urgh, right. I think I lost it.

>Which algorithm is generating EINPROGRESS in this case?
The call stack looks like the following:

  crypto_authenc_givencrypt_done()
   \crypto_authenc_ahash
    \crypto_ahash_digest()
     \mv_hash_digest()
      \crypto_enqueue_request() <= -EINPROGRESS
  crypto_authenc_givencrypt_done() err is EINPROGRESS
   \aead_request_complete()
    \xfrm_output_resume()

So I get in xfrm_output_one() with err == -EINPROGRESS. Now, that one
gets survided. The segfault happens later when xfrm_output_one() is
called with err = 0 for the same skb. The segfaults happens during 
   x = dst->xfrm;
is executed.

>Thanks,
>-- 

Sebastian
