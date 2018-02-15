From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 15 Feb 2018 23:51:00 +0800
Subject: [PATCH v2 0/6] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
References: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
Message-ID: <20180215155100.GJ7352@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 08:15:28PM +0100, Corentin Labbe wrote:
> Hello
> 
> The current crypto_engine support only ahash and ablkcipher request.
> My first patch which try to add skcipher was Nacked, it will add too many functions
> and adding other algs(aead, asymetric_key) will make the situation worst.
> 
> This patchset remove all algs specific stuff and now only process generic crypto_async_request.
> 
> The requests handler function pointer are now moved out of struct engine and
> are now stored directly in a crypto_engine_reqctx.
> 
> The original proposal of Herbert [1] cannot be done completly since the crypto_engine
> could only dequeue crypto_async_request and it is impossible to access any request_ctx
> without knowing the underlying request type.
> 
> So I do something near that was requested: adding crypto_engine_reqctx in TFM context.
> Note that the current implementation expect that crypto_engine_reqctx
> is the first member of the context.
> 
> The first patch is a try to document the crypto engine API.
> The second patch convert the crypto engine with the new way,
> while the following patchs convert the 4 existing users of crypto_engine.
> Note that this split break bisection, so probably the final commit will be all merged.
> 
> Appart from virtio, all 4 latest patch were compile tested only.
> But the crypto engine is tested with my new sun8i-ce driver.
> 
> Regards
> 
> [1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
> 
> Changes since V1:
> - renamed crypto_engine_reqctx to crypto_engine_ctx
> - indentation fix in function parameter
> - do not export crypto_transfer_request
> - Add aead support
> - crypto_finalize_request is now static
> 
> Changes since RFC:
> - Added a documentation patch
> - Added patch for stm32-cryp
> - Changed parameter of all crypto_engine_op functions from
> 	crypto_async_request to void*
> - Reintroduced crypto_transfer_xxx_request_to_engine functions
> 
> Corentin Labbe (6):
>   Documentation: crypto: document crypto engine API
>   crypto: engine - Permit to enqueue all async requests
>   crypto: omap: convert to new crypto engine API
>   crypto: virtio: convert to new crypto engine API
>   crypto: stm32-hash: convert to the new crypto engine API
>   crypto: stm32-cryp: convert to the new crypto engine API

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
