From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 1 Oct 2015 22:44:05 +0300
Subject: [PATCH v5 17/23] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <560B5FB5.6080605@mentor.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <1443564860-31208-18-git-send-email-ynorov@caviumnetworks.com>
 <560B5FB5.6080605@mentor.com>
Message-ID: <20151001194405.GB31021@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 11:06:13PM -0500, Nathan Lynch wrote:
> On 09/29/2015 05:14 PM, Yury Norov wrote:
> > From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > 
> > Adjusted to move the move data page before code pages in sync with
> > commit 601255ae3c98fdeeee3a8bb4696425e4f868b4f1
> 
> This commit message needs more information about how the ilp32 VDSO uses
> the existing arm64 code.  I had to really hunt through the Makefile to
> figure out what's going on.
> 
> The commit message should also identify the APIs that are supported.
> The subject line mentions signal return, but gettimeofday, clock_gettime
> and clock_getres are being added here too, and it is not obvious.
> 
> 
> > Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> > Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > 
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
> >  copy arch/arm64/{include/asm/vdso.h => kernel/vdso-ilp32/vdso-ilp32.S} (56%)
> >  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
> 
> How are you invoking git-format-patch?  The copy detection in this case
> is not conducive to review.
> 
> It looks like the existing arm64 vdso Makefile has been copied to
> vdso-ilp32/ and adjusted for paths and naming.  While the gettimeofday
> assembly implementation is reused, the build logic is duplicated.  x86
> produces VDSOs for multiple ABIs with a single Makefile; is a similar
> approach not appropriate for arm64?
> 
> 
> > diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
> > new file mode 100644
> > index 0000000..ac8029b
> > --- /dev/null
> > +++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
> > @@ -0,0 +1,98 @@
> 
> [...]
> 
> > +#include <linux/const.h>
> > +#include <asm/page.h>
> > +#include <asm/vdso.h>
> > +
> > +/*OUTPUT_FORMAT("elf32-littleaarch64", "elf32-bigaarch64", "elf32-littleaarch64")
> > +OUTPUT_ARCH(aarch64)
> > +*/
> 
> If these lines aren't needed then omit them.
> 
> [...]
> 
> 
> > +/*
> > + * This controls what symbols we export from the DSO.
> > + */
> > +VERSION
> > +{
> > +	LINUX_2.6.39 {
> > +	global:
> > +		__kernel_rt_sigreturn;
> > +		__kernel_gettimeofday;
> > +		__kernel_clock_gettime;
> > +		__kernel_clock_getres;
> > +	local: *;
> > +	};
> > +}
> 
> Something that came up during review of arch/arm's VDSO code: consider
> using version and names that match x86, i.e. LINUX_2.6, __vdso_gettimeofday.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267940.html
> 
> Using LINUX_2.6.39 for this code is nonsensical.
> 
> 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index b239b9b..bed6cf1 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -40,6 +40,12 @@ extern char vdso_start, vdso_end;
> >  static unsigned long vdso_pages;
> >  static struct page **vdso_pagelist;
> >  
> > +#ifdef CONFIG_ARM64_ILP32
> > +extern char vdso_ilp32_start, vdso_ilp32_end;
> > +static unsigned long vdso_ilp32_pages;
> > +static struct page **vdso_ilp32_pagelist;
> > +#endif
> > +
> >  /*
> >   * The vDSO data page.
> >   */
> > @@ -117,24 +123,29 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
> >  }
> >  #endif /* CONFIG_AARCH32_EL0 */
> >  
> > -static struct vm_special_mapping vdso_spec[2];
> > -
> > -static int __init vdso_init(void)
> > +static inline int __init vdso_init_common(char *vdso_start, char *vdso_end,
> 
> No inline please.
> 
> 
> > +					  unsigned long *vdso_pagesp,
> > +					  struct page ***vdso_pagelistp,
> > +					  struct vm_special_mapping* vdso_spec)
> >  {
> 
> [...]
> 
> >  int arch_setup_additional_pages(struct linux_binprm *bprm,
> >  				int uses_interp)
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
> > -	void *ret;
> > +	void* ret;
> 
> Gratuitous (and incorrect) style change.
> 
> 
> > +	unsigned long pages = vdso_pages;
> > +	struct vm_special_mapping* spec = vdso_spec;
> 
> Incorrect style:                  *spec

Hi Nathan,

If Philipp Philipp Tomsich will not answer soon, I'll fix all this.

BR,
Yury.
