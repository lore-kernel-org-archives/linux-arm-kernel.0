From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 11:39:37 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
Message-ID: <201305231139.38233.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> > The problem is: trying to fix that will mean the result is a larger
> > kernel than if you just do the usual arch-implemented thing of placing
> > an defined faulting instruction at the BUG() site - which defeats the
> > purpose of turning off CONFIG_BUG.
> 
> Is __builtin_unreachable() working well these days?
> 

Hmm, I just tried the trivial patch below, which seemed to do the right thing.
Needs a little more investigation, but that might actually be the correct
solution. I thought that at some point __builtin_unreachable() was the same
as "do {} while (1)", but this is not the case with the gcc I was using --
it just tells gcc that we don't expect to ever get here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..9afff7d 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -108,11 +108,11 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() __builtin_unreachable ()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) __builtin_unreachable(); } while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
