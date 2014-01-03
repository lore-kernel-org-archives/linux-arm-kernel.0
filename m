From: thomas.lendacky@amd.com (Tom Lendacky)
Date: Fri, 3 Jan 2014 09:10:30 -0600
Subject: [PATCH 1/5] crypto: Fully restore ahash request before completing
In-Reply-To: <20131230090112.GA8550@gondor.apana.org.au>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
 <201312270121.36578.marex@denx.de>
 <20131230090112.GA8550@gondor.apana.org.au>
Message-ID: <10214668.cztjge9Iie@tlendack-t1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 30, 2013 05:01:13 PM Herbert Xu wrote:
> On Fri, Dec 27, 2013 at 01:21:36AM +0100, Marek Vasut wrote:
> >
> > > > -	complete(data, err);
> > > > +	areq->base.complete = complete;
> > > > +	areq->base.data = data;
> > > > +
> > > > +	complete(&areq->base, err);
> > > 
> > > This looks completely bogus.  While restoring areq isn't wrong per
> > > se, calling complete with &areq->base makes no sense.  The original
> > > completion data is in the variable "data".
> > 
> > Is there some documentation for this so I can understand why this is wrong, 
> > please? I really don't quite get it, sorry. Actually, is there some 
> > documentation for writing crypto API drivers at all please ?
> 
> Well it's wrong because the completion function (req->base.complete)
> is meant to take data (req->base.data) as its first argument.  So
> giving it a pointer to req->base makes no sense.
> 

The crypto_completion_t typdef is defined as:

typedef void (*crypto_completion_t)(struct crypto_async_request *req, int err);

so I believe &areq->base is the proper first argument (which is actually just
the req parameter on the ahash_op_unaligned_done function).

If you are going to restore areq, you really should restore all fields that
were changed - result, base.complete, base.data - and set priv to NULL.

Since the ahash_request_priv structure is freed in ahash_op_unaligned_finish
you'll need to save the value of priv->result in order to restore areq->result
(u8 *result = priv->result; or similar).

Additionally, you should probably also fix up ahash_def_finup_done2 and
ahash_def_finup_done1.

Thanks,
Tom

> Cheers,
> 
