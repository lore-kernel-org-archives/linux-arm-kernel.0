From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 13 Sep 2017 09:46:47 +0900
Subject: [PATCH 3/9] kexec_file: factor out crashdump elf header function
 from x86
In-Reply-To: <20170912055521.GA8787@dhcp-128-65.nay.redhat.com>
References: <20170908031616.17916-1-takahiro.akashi@linaro.org>
 <20170908031616.17916-4-takahiro.akashi@linaro.org>
 <20170912055521.GA8787@dhcp-128-65.nay.redhat.com>
Message-ID: <20170913004645.GI17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 12, 2017 at 01:55:21PM +0800, Dave Young wrote:
> Hi,
> On 09/08/17 at 12:16pm, AKASHI Takahiro wrote:
> [snip]
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -162,6 +162,25 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> >  			       int (*func)(u64, u64, void *));
> >  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> >  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
> > +#ifdef CONFIG_CRASH_CORE
> > +extern int prepare_elf_headers(struct kimage *image, void **addr,
> > +				unsigned long *sz);
> > +
> > +/* This primarily represents number of split ranges due to exclusion */
> > +#define CRASH_MAX_RANGES        16
> > +
> > +struct crash_mem_range {
> > +	u64 start, end;
> > +};
> > +
> > +struct crash_mem {
> > +	unsigned int nr_ranges;
> > +	struct crash_mem_range ranges[CRASH_MAX_RANGES];
> > +};
> > +
> > +extern int exclude_mem_range(struct crash_mem *mem,
> > +		unsigned long long mstart, unsigned long long mend);
> > +#endif /* CONFIG_CRASH_CORE */
> 
> Maybe I did not say it clear when reviewing the v1.
> 
> I suggested to move the code from to kexec_file.c because the

(from crash_core.c)

> CONFIG_CRASH_CORE originally was introduced for the common code for
> vmcoreinfo stuff when Hari worked on sharing code between powerpc
> fadump and kdump.
> 
> I'm not sure we need the #ifdef CONFIG_CRASH_CORE here for these
> kexec file load functions. Since they are already in kexec_file.c
> so I think no need to add the #ifdef

Right. CRASH_CORE is always selected, in arch/Kconfig, by KEXEC_CORE
which is selected by KEXEC_FILE.
(In this sense, CRASH_CORE has no use any more.)

Thanks,
-Takahiro AKASHI

> >  #endif /* CONFIG_KEXEC_FILE */
> Thanks
> Dave
