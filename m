From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 30 Dec 2013 17:01:13 +0800
Subject: [PATCH 1/5] crypto: Fully restore ahash request before completing
In-Reply-To: <201312270121.36578.marex@denx.de>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
 <20131220120408.GA31738@gondor.apana.org.au>
 <201312270121.36578.marex@denx.de>
Message-ID: <20131230090112.GA8550@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 27, 2013 at 01:21:36AM +0100, Marek Vasut wrote:
>
> > > -	complete(data, err);
> > > +	areq->base.complete = complete;
> > > +	areq->base.data = data;
> > > +
> > > +	complete(&areq->base, err);
> > 
> > This looks completely bogus.  While restoring areq isn't wrong per
> > se, calling complete with &areq->base makes no sense.  The original
> > completion data is in the variable "data".
> 
> Is there some documentation for this so I can understand why this is wrong, 
> please? I really don't quite get it, sorry. Actually, is there some 
> documentation for writing crypto API drivers at all please ?

Well it's wrong because the completion function (req->base.complete)
is meant to take data (req->base.data) as its first argument.  So
giving it a pointer to req->base makes no sense.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
