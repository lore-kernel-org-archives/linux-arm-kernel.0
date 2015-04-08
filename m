From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 8 Apr 2015 21:30:50 +0800
Subject: [PATCH v3 01/16] crypto: sha1: implement base layer for SHA-1
In-Reply-To: <CAKv+Gu9gQqQEEXgJ=JhVf=7SURx9BfRiaJkakhGv1S9FsqujaQ@mail.gmail.com>
References: <1428396724-19962-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428396724-19962-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150408131916.GA29646@gondor.apana.org.au>
 <CAKv+Gu9gQqQEEXgJ=JhVf=7SURx9BfRiaJkakhGv1S9FsqujaQ@mail.gmail.com>
Message-ID: <20150408133050.GB29646@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 03:25:14PM +0200, Ard Biesheuvel wrote:
>
> Not having to call the function twice is the whole point. In the arm64
> case, all the SHA-256 round keys can be kept in registers (it has 32
> 16-byte SIMD registers), and that is what motivates this pattern. By
> passing a head block, a pointer to the source and the generic pointer
> (which arm64 uses to finalize the block, we can process all data in a
> single invocation of the block transform)

Does this really make any difference? With IPsec the partial code
path is never even going to get executed.

> Do note that these are only used by static inline functions, so the
> unused arguments are all eliminated from the binary anyway. In fact,
> looking at the generated code, the function calls don't use function
> pointers at all anymore,
> but just call the block transform directly, so the typedef is only
> used as a prototype, really.

It's not just the generated code.  The next guy that comes along
and writes a SHA implementation is going to go WTH is this p
argument.  I'm not going to add crap to the generic layer just
because ARM needs it.  In fact ARM doesn't even need it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
