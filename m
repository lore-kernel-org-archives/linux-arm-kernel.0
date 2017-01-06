From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Jan 2017 14:48:21 +0000
Subject: [PATCH 10/18] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <20161221185640.GA16562@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-11-git-send-email-ynorov@caviumnetworks.com>
 <20161205153801.GE14429@e104818-lin.cambridge.arm.com>
 <20161221185640.GA16562@yury-N73SV>
Message-ID: <20170106144820.GE12863@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 12:26:40AM +0530, Yury Norov wrote:
> On Mon, Dec 05, 2016 at 03:38:01PM +0000, Catalin Marinas wrote:
> > On Fri, Oct 21, 2016 at 11:33:09PM +0300, Yury Norov wrote:
> > > binfmt_ilp32.c is needed to handle ILP32 binaries
> > > 
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > Signed-off-by: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
> > > ---
> > >  arch/arm64/include/asm/elf.h     |  6 +++
> > >  arch/arm64/kernel/Makefile       |  1 +
> > >  arch/arm64/kernel/binfmt_ilp32.c | 97 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 104 insertions(+)
> > >  create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
> > > 
> > > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > > index f259fe8..be29dde 100644
> > > --- a/arch/arm64/include/asm/elf.h
> > > +++ b/arch/arm64/include/asm/elf.h
> > > @@ -175,10 +175,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
> > >  
> > >  #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
> > >  
> > > +#ifndef USE_AARCH64_GREG
> > >  /* AArch32 registers. */
> > >  #define COMPAT_ELF_NGREG		18
> > >  typedef unsigned int			compat_elf_greg_t;
> > >  typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> > > +#else /* AArch64 registers for AARCH64/ILP32 */
> > > +#define COMPAT_ELF_NGREG	ELF_NGREG
> > > +#define compat_elf_greg_t	elf_greg_t
> > > +#define compat_elf_gregset_t	elf_gregset_t
> > > +#endif
> > 
> > I think you only need compat_elf_gregset_t definition here and leave the
> > other two undefined.
> 
> I checked everything here again, and found that almost all compat defines
> may be moved to corresponding binfmt files. If everything is OK, I'll
> incorporate next patch to the series

It seems fine at a quick look but I'll have to see the final patch.

-- 
Catalin
