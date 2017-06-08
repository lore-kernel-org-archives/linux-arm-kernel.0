From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 9 Jun 2017 02:06:16 +0300
Subject: [PATCH 19/20] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <20170608152434.5jgcrk6jisdaqap7@localhost>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-20-ynorov@caviumnetworks.com>
 <20170608152434.5jgcrk6jisdaqap7@localhost>
Message-ID: <20170608230616.2mi6w6llskl35bh4@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 04:24:34PM +0100, Catalin Marinas wrote:
> On Sun, Jun 04, 2017 at 03:00:08PM +0300, Yury Norov wrote:
> > From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > 
> > ILP32 VDSO exports following symbols:
> >  __kernel_rt_sigreturn;
> >  __kernel_gettimeofday;
> >  __kernel_clock_gettime;
> >  __kernel_clock_getres.
> > 
> > What shared object to use, kernel selects depending on result of
> > is_ilp32_compat_task() in arch/arm64/kernel/vdso.c, so it substitutes
> > correct pages and spec.
> > 
> > Adjusted to move the data page before code pages in sync with
> > commit 601255ae3c98 ("arm64: vdso: move data page before code pages")
> > 
> > Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> > ---
> >  arch/arm64/Makefile                           |  3 +
> >  arch/arm64/include/asm/vdso.h                 |  6 ++
> >  arch/arm64/kernel/Makefile                    |  1 +
> >  arch/arm64/kernel/asm-offsets.c               |  7 ++
> >  arch/arm64/kernel/signal.c                    |  2 +
> >  arch/arm64/kernel/vdso-ilp32/.gitignore       |  2 +
> >  arch/arm64/kernel/vdso-ilp32/Makefile         | 80 ++++++++++++++++++++++
> >  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     | 33 ++++++++++
> >  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S | 95 +++++++++++++++++++++++++++
> >  arch/arm64/kernel/vdso.c                      | 65 +++++++++++++++---
> >  arch/arm64/kernel/vdso/gettimeofday.S         | 20 +++++-
> >  arch/arm64/kernel/vdso/vdso.S                 |  6 +-
> >  12 files changed, 304 insertions(+), 16 deletions(-)
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
> 
> Does this patch get simpler with Andrew Pinski's vdso in C proposal?
> I have to read the other thread in detail, Will followed up already.

Not much. arch/arm64/kernel/vdso/gettimeofday.S is removed by Andrew,
so it will also disappear here. New gettimeofday.c is just compiled with
mabi=ilp32, and almost don't need modifications. Makefiles will be modified
accordingly. The rest is the same. This is the draft for the changes we
need to apply ilp32 series on top of Andrew's patch (there's few typos
though, so only for reference):
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1409447.html

> > diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> > index 839ce0031bd5..649a9a416500 100644
> > --- a/arch/arm64/include/asm/vdso.h
> > +++ b/arch/arm64/include/asm/vdso.h
> > @@ -29,6 +29,12 @@
> >  
> >  #include <generated/vdso-offsets.h>
> >  
> > +#ifdef CONFIG_ARM64_ILP32
> > +#include <generated/vdso-ilp32-offsets.h>
> > +#else
> > +#define vdso_offset_sigtramp_ilp32
> > +#endif
> 
> BTW, here you could do something like:
> 
> #define vdso_offset_sigtramp_ilp32	({ BUILD_BUG(); 0; })

OK, will change
