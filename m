From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 4 Jul 2015 15:33:55 +0800
Subject: crypto: marvell/CESA: Issues with non cache-line aligned buffers
In-Reply-To: <20150703114305.15611807@bbrezillon>
References: <20150703114305.15611807@bbrezillon>
Message-ID: <20150704073355.GA6451@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 11:43:05AM +0200, Boris Brezillon wrote:
>
> We also noticed that the cra_alignmask fields were all set to 0 in the
> CESA driver, but modifying them (setting them to ARCH_DMA_MINALIGN - 1)
> does not seem to guarantee any alignment.
> ITOH, the xxx_walk_xxx API seem to check these misalignment issues and
> allocate new buffers to prevent such cases, but AFAICT, this is not
> automatically done by the crypto framework, and it's the
> responsibility of each driver to ensure the correct alignment.
> Herbert, could you confirm that ?

Correct.  The crypto API does provide limited help for things like
the key and the tfm context, but as far as the input/output data is
concerned it is up to the driver to deal with them.

Note that I don't think we have a suitable helper for DMA-aligned
processing of SG lists.  The ablkcipher_walk_* interface is mostly
identical to the blkcipher_walk_* interface.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
