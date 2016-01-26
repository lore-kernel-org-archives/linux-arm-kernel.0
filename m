From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 12:49:36 +0100
Subject: [PATCH 1/2] crypto: jitterentropy - always select CRYPTO_RNG
In-Reply-To: <20160126103018.GA19508@gondor.apana.org.au>
References: <1453740644-1980309-1-git-send-email-arnd@arndb.de>
 <20160126103018.GA19508@gondor.apana.org.au>
Message-ID: <29082633.aRvKnNisWH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 January 2016 18:30:18 Herbert Xu wrote:
> On Mon, Jan 25, 2016 at 05:50:34PM +0100, Arnd Bergmann wrote:
> > When building the jitterentropy driver by itself, we get a link error
> > when CRYPTO_RNG is not enabled as well:
> > 
> > crypto/built-in.o: In function `jent_mod_init':
> > jitterentropy-kcapi.c:(.init.text+0x98): undefined reference to `crypto_register_rng'
> > crypto/built-in.o: In function `jent_mod_exit':
> > jitterentropy-kcapi.c:(.exit.text+0x60): undefined reference to `crypto_unregister_rng'
> > 
> > This moves the 'select CRYPTO_RNG' from CRYPTO_DRBG to CRYPTO_JITTERENTROPY
> > to ensure the API is always there when it's used, not just when DRBG is
> > also enabled.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  crypto/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 7240821137fd..99109b93604a 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -1586,13 +1586,13 @@ config CRYPTO_DRBG_CTR
> >  config CRYPTO_DRBG
> >       tristate
> >       default CRYPTO_DRBG_MENU
> > -     select CRYPTO_RNG
> 
> I think we should leave this there as DRBG itself is an RNG and
> it just uses JITTERENTROPY which happens to be an RNG.

Good idea. Should I resend a modified version or do you want to just
adapt it yourself?

	Arnd
