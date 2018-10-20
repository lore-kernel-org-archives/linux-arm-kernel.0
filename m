From: ebiggers@kernel.org (Eric Biggers)
Date: Fri, 19 Oct 2018 22:26:58 -0700
Subject: [RFC PATCH v2 06/12] crypto: arm/chacha20 - refactor to allow
 varying number of rounds
In-Reply-To: <CAKv+Gu96nz-kMp8VwPZAoHC5jHvhZ4_jRYTDKS=XNmrqDW5i8A@mail.gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <20181015175424.97147-7-ebiggers@kernel.org>
 <CAKv+Gu96nz-kMp8VwPZAoHC5jHvhZ4_jRYTDKS=XNmrqDW5i8A@mail.gmail.com>
Message-ID: <20181020052657.GB876@sol.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sat, Oct 20, 2018 at 11:35:22AM +0800, Ard Biesheuvel wrote:
> On 16 October 2018 at 01:54, Eric Biggers <ebiggers@kernel.org> wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > In preparation for adding XChaCha12 support, rename/refactor the NEON
> > implementation of ChaCha20 to support different numbers of rounds.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> > ---
> >  arch/arm/crypto/Makefile                      |  4 +-
> >  ...hacha20-neon-core.S => chacha-neon-core.S} | 36 ++++++------
> >  ...hacha20-neon-glue.c => chacha-neon-glue.c} | 56 ++++++++++---------
> >  3 files changed, 52 insertions(+), 44 deletions(-)
> >  rename arch/arm/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (96%)
> >  rename arch/arm/crypto/{chacha20-neon-glue.c => chacha-neon-glue.c} (73%)
> >
> > diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> > index bd5bceef0605f..005482ff95047 100644
> > --- a/arch/arm/crypto/Makefile
> > +++ b/arch/arm/crypto/Makefile
> > @@ -9,7 +9,7 @@ obj-$(CONFIG_CRYPTO_SHA1_ARM) += sha1-arm.o
> >  obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
> >  obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
> >  obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
> > -obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha20-neon.o
> > +obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
> >
> 
> I take it you are preserving the Kconfig symbol name to prevent
> breaking existing configs?

Yes, that's the intent.  Though perhaps we should just change it.

> 
> If so, we might consider doing something like
> 
> config CRYPTO_CHACHA20_NEON
>     tristate
> 
> config CRYPTO_CHACHA_NEON
>     default CRYPTO_CHACHA20_NEON
>     ... the existing kconfig symbol description ...
> 
> and drop the former at some point in the future?
> 

The problem is that only symbols with a prompt string can be set explicitly,
e.g. in a kconfig file.  So it's not possible to migrate a symbol to a new one
without breakage, unless both are to remain separately promptable.  It seems
there should be a way, but last I checked I don't think there was...

- Eric
