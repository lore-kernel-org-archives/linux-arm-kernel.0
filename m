From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 23 Nov 2015 21:01:49 +0800
Subject: [PATCH] crypto: atmel: fix 64-bit warnings
In-Reply-To: <4444008.DmhAgm3J77@wuerfel>
References: <4444008.DmhAgm3J77@wuerfel>
Message-ID: <20151123130149.GC7866@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 10:22:06AM +0100, Arnd Bergmann wrote:
> The atmel AES driver assumes that 'int' and 'size_t' are the same
> type in multiple locations, which the compiler warns about when
> building it for 64-bit systems:
> 
> In file included from ../drivers/crypto/atmel-aes.c:17:0:
> drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
> include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
> drivers/crypto/atmel-aes.c:448:11: note: in expansion of macro 'min'
> 
> drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
> include/linux/kern_levels.h:4:18: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t {aka long unsigned int}' [-Wformat=]
> 
> This changes the format strings to use the %z modifier when printing
> a size_t, and makes sure that we use the correct size_t type where
> needed. In case of sg_dma_len(), the type of the result depends
> on CONFIG_NEED_SG_DMA_LENGTH, so we have to use min_t to get it to
> work in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
