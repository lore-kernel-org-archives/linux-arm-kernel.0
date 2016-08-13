From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 13 Aug 2016 17:54:03 +0300
Subject: [PATCH 18/19] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <mvminx3ud0m.fsf@hawking.suse.de>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-19-git-send-email-ynorov@caviumnetworks.com>
 <mvminx3ud0m.fsf@hawking.suse.de>
Message-ID: <20160813145403.GB24335@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 04:54:17PM +0200, Andreas Schwab wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
> 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 2a0de6f..e48ea34 100644
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
> > @@ -110,24 +116,29 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
> >  }
> >  #endif /* CONFIG_AARCH32_EL0 */
> >  
> > -static struct vm_special_mapping vdso_spec[2];
> > -
> > -static int __init vdso_init(void)
> > +static int __init vdso_init_common(char *vdso_start, char *vdso_end,
> 
> Using the same name for the parameter as for the global variable is
> dangerous ....
> 
> > +					  unsigned long *vdso_pagesp,
> > +					  struct page ***vdso_pagelistp,
> > +					  struct vm_special_mapping* vdso_spec)
> >  {
> >  	int i;
> > +	unsigned long vdso_pages;
> > +	struct page **vdso_pagelist;
> >  
> > -	if (memcmp(&vdso_start, "\177ELF", 4)) {
> > +	if (memcmp(vdso_start, "\177ELF", 4)) {
> 
> ... because forgetting to remove & can be fatal, and your compiler may
> not even warn you.
> 
> Andreas.

Fixed. See here: https://github.com/norov/linux/tree/ilp32-4.8
Thanks.

Yury.
