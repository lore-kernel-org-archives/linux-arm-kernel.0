From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 2 Feb 2016 11:39:08 -0800
Subject: [PATCH] arm64: asm: Explicitly include linux/personality.h in
 asm/page.h
In-Reply-To: <20160202164817.GM10166@arm.com>
References: <1453983508-20410-1-git-send-email-broonie@kernel.org>
 <20160128124417.GE6078@sirena.org.uk>
 <20160128141425.GA20099@e104818-lin.cambridge.arm.com>
 <20160128144610.GA2380@ulmo> <20160202164817.GM10166@arm.com>
Message-ID: <20160202113908.d699440a0617006c3b987129@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016 16:48:18 +0000 Will Deacon <will.deacon@arm.com> wrote:

> On Thu, Jan 28, 2016 at 03:46:10PM +0100, Thierry Reding wrote:
> > On Thu, Jan 28, 2016 at 02:14:26PM +0000, Catalin Marinas wrote:
> > > On Thu, Jan 28, 2016 at 12:44:17PM +0000, Mark Brown wrote:
> > > > On Thu, Jan 28, 2016 at 12:18:28PM +0000, Mark Brown wrote:
> > > > > asm/page.h uses READ_IMPLIES_EXEC from linux/personality.h but does not
> > > > > explicitly include it causing build failures in -next where whatever was
> > > > > causing it to be implicitly included has changed to remove that
> > > > > inclusion.  Add an explicit inclusion to fix this.
> > > > 
> > > > Argh, sorry - this causes problems further down the line with linking
> > > > vdso.lds due to enums getting into the linker script and upsetting the
> > > > linker (there are several compile errors today so it was masked).
> > > 
> > > You can move the include further down after the #ifndef __ASSEMBLY__
> > 
> > Indeed, here's what I've been using to successfully complete ARM64 test
> > builds:
> > 
> > --- >8 ---
> > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> > index 9b2f5a9d019d..ae615b9d9a55 100644
> > --- a/arch/arm64/include/asm/page.h
> > +++ b/arch/arm64/include/asm/page.h
> > @@ -39,6 +39,7 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#include <linux/personality.h> /* for READ_IMPLIES_EXEC */
> >  #include <asm/pgtable-types.h>
> >  
> >  extern void __cpu_clear_user_page(void *p, unsigned long user);
> 
> I see this has ended up in linux-next, but I'm not sure whether or not
> it's actually queued someplace for 4.6. Any ideas?
> 
> If not, I can take it (or some derivative) through arm64 as a fix for
> -rc3.

It's not actually needed any more because Kirill has tweaked the patch
which triggered this build error.

However I think the change still makes sense as a standalone thing -
your call.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: arm: arch/arm/include/asm/page.h needs personality.h

VM_DATA_DEFAULT_FLAGS uses READ_IMPLIES_EXEC, so page.h should include
personality.h to provide this.

This was needed for "mm: warn about VmData over RLIMIT_DATA".

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/include/asm/page.h |    2 ++
 1 file changed, 2 insertions(+)

diff -puN arch/arm/include/asm/page.h~arm-arch-arm-include-asm-pageh-needs-personalityh arch/arm/include/asm/page.h
--- a/arch/arm/include/asm/page.h~arm-arch-arm-include-asm-pageh-needs-personalityh
+++ a/arch/arm/include/asm/page.h
@@ -17,6 +17,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/personality.h>	/* For READ_IMPLIES_EXEC */
+
 #ifndef CONFIG_MMU
 
 #include <asm/page-nommu.h>
_
