From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 9 Jul 2015 14:59:56 +0800
Subject: [linux-sunxi] Re: [PATCH v10 4/5] crypto: Add Allwinner Security
 System crypto accelerator
In-Reply-To: <20150709064150.GA4028@Red>
References: <1436209848-16530-1-git-send-email-clabbe.montjoie@gmail.com>
 <1436209848-16530-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150707134936.GA2958@gondor.apana.org.au>
 <20150709064150.GA4028@Red>
Message-ID: <20150709065955.GC32698@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 08:41:50AM +0200, LABBE Corentin wrote:
>
> > > +	/* get the partial hash only if something was written */
> > > +	if (op->mode == SS_OP_SHA1) {
> > > +		for (i = 0; i < 5; i++)
> > > +			op->hash[i] = readl(ss->base + SS_MD0 + i * 4);
> > > +	} else {
> > > +		for (i = 0; i < 4; i++)
> > > +			op->hash[i] = readl(ss->base + SS_MD0 + i * 4);
> > > +	}
> > 
> > You can avoid the op->mode check by storing the hash size in algt.
> > 
> 
> It seems that I can use crypto_ahash_digestsize() that do the same thing.

I don't think so because the partial hash size is not the same
as the final digest size.

> > > +int sun4i_hash_finup(struct ahash_request *areq)
> > > +{
> > > +	int err;
> > > +
> > > +	err = sun4i_hash_update(areq);
> > > +	if (err != 0)
> > > +		return err;
> > > +
> > > +	return sun4i_hash_final(areq);
> > 
> > You can drop finup since the API provides a default finup that's
> > exactly the same as this.  You only need to provide finup if it
> > can optimise on this.
> > 
> > Ditto for digest.
> 
> If I remove digest(), loading the driver crash the kernel with:

You're right.  We don't provide a default digest function for ahash,
we only do it for shash.  So I guess you'll have to keep digest
around for now.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
