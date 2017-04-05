From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 5 Apr 2017 10:43:23 -0700
Subject: [PATCH] crypto: arm64/sha: use %c constraint code in ASM_EXPORT
In-Reply-To: <CAKv+Gu-7tX6THETVA+M0UrC6rJ4id2AsHi2XfhDEmxCJ_tdwKw@mail.gmail.com>
References: <20170405165603.87264-1-mka@chromium.org>
 <CAKv+Gu-7tX6THETVA+M0UrC6rJ4id2AsHi2XfhDEmxCJ_tdwKw@mail.gmail.com>
Message-ID: <20170405174323.GC145051@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hoi Ard!

El Wed, Apr 05, 2017 at 06:08:37PM +0100 Ard Biesheuvel ha dit:

> On 5 April 2017 at 17:56, Matthias Kaehlcke <mka@chromium.org> wrote:
> > From: Greg Hackmann <ghackmann@google.com>
> >
> > The current definition of ASM_EXPORT doesn't work properly with clang,
> > according to https://bugs.llvm.org//show_bug.cgi?id=27250#c3 it relies on
> > gcc specific behavior. Change the constraint from an intermediate to an
> > output expression which works with both gcc and clang.
> >
> > From: Greg Hackmann <ghackmann@google.com>
> > Commit-message-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Greg Hackmann <ghackmann@google.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/crypto/sha1-ce-glue.c | 2 +-
> >  arch/arm64/crypto/sha2-ce-glue.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > index aefda9868627..c71e94ba0e43 100644
> > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/module.h>
> >
> >  #define ASM_EXPORT(sym, val) \
> > -       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> > +       asm(".globl " #sym "; .set " #sym ", %c0" :: "I"(val));
> >
> >  MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
> >  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> > diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> > index 7cd587564a41..381b5fb2dcb2 100644
> > --- a/arch/arm64/crypto/sha2-ce-glue.c
> > +++ b/arch/arm64/crypto/sha2-ce-glue.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/module.h>
> >
> >  #define ASM_EXPORT(sym, val) \
> > -       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> > +       asm(".globl " #sym "; .set " #sym ", %c0" :: "I"(val));
> >
> >  MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
> >  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> 
> I am fine with this change, although I would really like to add a
> better reference to the commit log. It is *very* difficult to find any
> documentation regarding non-trivial uses of inline asm constraints,
> and if %c0 is the correct syntax, surely we can quote something better
> than a LLVM bugzilla entry? Also, where does the distinction between
> 'intermediate' vs 'output' expression come from?

To be honest assembly is not really my area of expertise and I relayed
the information from the LLVM bug. The link to the gcc doc on
x86(!) operand modifiers posted by Robin Murphy (thanks!) should be
helpful to provide a more accurate commit message.

Thanks

Matthias
