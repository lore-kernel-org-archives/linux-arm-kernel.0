From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 8 Apr 2015 15:25:14 +0200
Subject: [PATCH v3 01/16] crypto: sha1: implement base layer for SHA-1
In-Reply-To: <20150408131916.GA29646@gondor.apana.org.au>
References: <1428396724-19962-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428396724-19962-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150408131916.GA29646@gondor.apana.org.au>
Message-ID: <CAKv+Gu9gQqQEEXgJ=JhVf=7SURx9BfRiaJkakhGv1S9FsqujaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2015 at 15:19, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 07, 2015 at 10:51:49AM +0200, Ard Biesheuvel wrote:
>>
>> +typedef void (sha1_block_fn)(int blocks, u8 const *src, u32 *state,
>> +                          const u8 *head, void *p);
>
> Does this really need five arguments? First of all we can get rid
> of head by just calling this function twice.

Not having to call the function twice is the whole point. In the arm64
case, all the SHA-256 round keys can be kept in registers (it has 32
16-byte SIMD registers), and that is what motivates this pattern. By
passing a head block, a pointer to the source and the generic pointer
(which arm64 uses to finalize the block, we can process all data in a
single invocation of the block transform)

>  The last argument
> appears to only be used by arm64 where it is simply another way
> of saying (sctx->count + len) % SHA_BLOCK_SIZE != 0.  So why not
> get rid of it and just use the conditional?
>

Do note that these are only used by static inline functions, so the
unused arguments are all eliminated from the binary anyway. In fact,
looking at the generated code, the function calls don't use function
pointers at all anymore,
but just call the block transform directly, so the typedef is only
used as a prototype, really.

-- 
Ard.
