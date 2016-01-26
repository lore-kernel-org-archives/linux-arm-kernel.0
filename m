From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 26 Jan 2016 18:44:27 +0800
Subject: [PATCH 1/4] crypto: sunxi - don't print uninitialized data
In-Reply-To: <1453740845-1980433-1-git-send-email-arnd@arndb.de>
References: <1453740845-1980433-1-git-send-email-arnd@arndb.de>
Message-ID: <20160126104427.GA19583@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 05:53:48PM +0100, Arnd Bergmann wrote:
> gcc correctly warns that the printk output contains a variable that
> is not initialized in some cases:
> 
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In function 'sun4i_ss_cipher_poll':
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:254:76: warning: 'todo' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15: note: 'todo' was declared here
> 
> This adds an explicit initialization to zero in the exact case where it
> was missing, to avoid leaking stack data to the console and to shut up
> that warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is actually a bogus warning because todo is always initialised
but gcc can't see that because it's behind multiple conditionals.

It would be great if we can restructure the code so that gcc can see
this while at the same time also improving the readability of the
loop.

Otherwise just initialise it at the top or use uninitialised_var.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
