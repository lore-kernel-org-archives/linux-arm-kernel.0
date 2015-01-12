From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 19:40:31 +0000
Subject: [PATCH] arm64: mm: dump: add missing includes
In-Reply-To: <20150112163825.GM12302@n2100.arm.linux.org.uk>
References: <1421077226-5530-1-git-send-email-mark.rutland@arm.com>
 <20150112163825.GM12302@n2100.arm.linux.org.uk>
Message-ID: <20150112194030.GA6397@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 04:38:25PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 12, 2015 at 03:40:26PM +0000, Mark Rutland wrote:
> > The arm64 dump code is currently relying on some definitions which are
> > pulled in via transitive dependencies. On next-20150112 at least one of
> > these (PCI_IOBASE) is no longer pulled in with a defconfig build,
> > resulting in the following build failure:
> > 
> > arch/arm64/mm/dump.c:55:20: error: ?PCI_IOBASE? undeclared here (not in a function)
> >   { (unsigned long) PCI_IOBASE,  "PCI I/O start" },
> >                     ^
> > It seems we have implicit dependencies on the following definitions:
> > 
> > * PCI_IOBASE            (asm/io.h)
> > * MODULES_VADDR         (asm/memory.h)
> > * MODULES_END           (asm/memory.h)
> > * PAGE_OFFSET           (asm/memory.h)
> > * PTE_*                 (asm/pgtable-hwdef.h)
> > * ENOMEM                (asm/errno.h)
> > * device_initcall       (linux/init.h)
> > 
> > This patch ensures we explicitly include the relevant headers for the
> > above items, fixing the observed build issue and hopefully preventing
> > future issues as headers are refactored.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> > Cc: Laura Abbott <lauraa@codeaurora.org>
> > Cc: Steve Capper <steve.capper@linaro.org>
> > Cc: Will Deacon <Will.Deacon@arm.com>
> > ---
> >  arch/arm64/mm/dump.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> > index cf33f33..df69e43 100644
> > --- a/arch/arm64/mm/dump.c
> > +++ b/arch/arm64/mm/dump.c
> > @@ -15,12 +15,17 @@
> >   */
> >  #include <linux/debugfs.h>
> >  #include <linux/fs.h>
> > +#include <linux/init.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> >  #include <linux/seq_file.h>
> >  
> > +#include <asm/errno.h>
> >  #include <asm/fixmap.h>
> > +#include <asm/io.h>
> > +#include <asm/memory.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/pgtable-hwdef.h>
> 
> Don't forget to use linux/*.h includes instead of asm/*.h includes where
> appropriate.  That being errno.h and io.h.

Sure thing for errno.h.

I discovered a problem in the way we handle PCI I/O space here, and
my solution for that [1] removes the need for io.h.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315444.html
