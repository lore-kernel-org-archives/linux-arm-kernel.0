From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 21 Apr 2017 13:36:45 +0200
Subject: [PATCH v2 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170421092935.fszux3qg5hbwwobj@kwain>
References: <20170419071418.18995-1-antoine.tenart@free-electrons.com>
 <20170419071418.18995-3-antoine.tenart@free-electrons.com>
 <20170421073056.GA2041@Red> <20170421092935.fszux3qg5hbwwobj@kwain>
Message-ID: <20170421113645.GA18422@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	memset(ipad + keylen, 0, blocksize - keylen);
> > > +	memcpy(opad, ipad, blocksize);
> > > +
> > > +	for (i = 0; i < blocksize; i++) {
> > > +		ipad[i] ^= 0x36;
> > > +		opad[i] ^= 0x5c;
> > 
> > What are these constant ?
> 
> They are defined in the HMAC RFC, as ipad and opad values. See
> https://www.ietf.org/rfc/rfc2104.txt.
> 

Since many driver use them, I think defining them in include/ should be done (HMAC_IPAD/HMAC_OPAD)
I will send a patch for it.

> > [...]
> > > +struct safexcel_alg_template safexcel_alg_sha256 = {
> > > +	.type = SAFEXCEL_ALG_TYPE_AHASH,
> > > +	.alg.ahash = {
> > > +		.init = safexcel_sha256_init,
> > > +		.update = safexcel_ahash_update,
> > > +		.final = safexcel_ahash_final,
> > > +		.finup = safexcel_ahash_finup,
> > > +		.digest = safexcel_sha256_digest,
> > > +		.export = safexcel_ahash_export,
> > > +		.import = safexcel_ahash_import,
> > > +		.halg = {
> > > +			.digestsize = SHA256_DIGEST_SIZE,
> > > +			.statesize = sizeof(struct safexcel_ahash_export_state),
> > > +			.base = {
> > > +				.cra_name = "sha256",
> > > +				.cra_driver_name = "safexcel-sha256",
> > > +				.cra_priority = 300,
> > > +				.cra_flags = CRYPTO_ALG_ASYNC |
> > > +					     CRYPTO_ALG_KERN_DRIVER_ONLY,
> > 
> > Why do use CRYPTO_ALG_KERN_DRIVER_ONLY ?
> 
> See http://lxr.free-electrons.com/source/include/linux/crypto.h#L97.
> 

Sorry, I had understood that flag as "do not let userspace use me".
Anyway, this flag is totally ignored by the cryptoAPI.
