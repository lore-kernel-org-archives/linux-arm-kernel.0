From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 29 Nov 2017 17:38:52 +1100
Subject: [PATCH] crypto/arm64: aes-ce-cipher - move assembler code to .S
 file
In-Reply-To: <20171121134017.21247-1-ard.biesheuvel@linaro.org>
References: <20171121134017.21247-1-ard.biesheuvel@linaro.org>
Message-ID: <20171129063852.GM21575@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 01:40:17PM +0000, Ard Biesheuvel wrote:
> Most crypto drivers involving kernel mode NEON take care to put the code
> that actually touches the NEON register file in a separate compilation
> unit, to prevent the compiler from reordering code that preserves or
> restores the NEON context with code that may corrupt it. This is
> necessary because we currently have no way to express the restrictions
> imposed upon use of the NEON in kernel mode in a way that the compiler
> understands.
> 
> However, in the case of aes-ce-cipher, it did not seem unreasonable to
> deviate from this rule, given how it does not seem possible for the
> compiler to reorder cross object function calls with asm blocks whose
> in- and output constraints reflect that it reads from and writes to
> memory.
> 
> Now that LTO is being proposed for the arm64 kernel, it is time to
> revisit this. The link time optimization may replace the function
> calls to kernel_neon_begin() and kernel_neon_end() with instantiations
> of the IR that make up its implementation, allowing further reordering
> with the asm block.
> 
> So let's clean this up, and move the asm() blocks into a separate .S
> file.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
