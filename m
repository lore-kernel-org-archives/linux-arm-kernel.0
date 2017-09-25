From: dyoung@redhat.com (Dave Young)
Date: Mon, 25 Sep 2017 16:30:41 +0800
Subject: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20170925080313.GA5970@dhcp-128-65.nay.redhat.com>
References: <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
 <20170922075807.GM17186@linaro.org>
 <20170925080313.GA5970@dhcp-128-65.nay.redhat.com>
Message-ID: <20170925083041.GB5970@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/17 at 04:03pm, Dave Young wrote:
> HI AKASHI,
> On 09/22/17 at 04:58pm, AKASHI Takahiro wrote:
> > Hi Dave,
> > 
> [snip]
> 
> > > >  /*
> > > >   * Apply purgatory relocations.
> > > >   *
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index dd056fab9e35..4a2b24d94e04 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -134,6 +134,26 @@ struct kexec_file_ops {
> > > >  #endif
> > > >  };
> > > >  
> > > > +int kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > > +			     unsigned long buf_len);
> > > > +void *kexec_kernel_image_load(struct kimage *image);
> > > > +int kexec_kernel_post_load_cleanup(struct kimage *image);
> > > > +int kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > > +			    unsigned long buf_len);
> > > > +
> > > > +#ifndef arch_kexec_kernel_image_probe
> > > > +#define arch_kexec_kernel_image_probe kexec_kernel_image_probe
> > > > +#endif
> > > > +#ifndef arch_kexec_kernel_image_load
> > > > +#define arch_kexec_kernel_image_load kexec_kernel_image_load
> > > > +#endif
> > > > +#ifndef arch_kimage_file_post_load_cleanup
> > > > +#define arch_kimage_file_post_load_cleanup kexec_kernel_post_load_cleanup
> > > > +#endif
> > > > +#ifndef arch_kexec_kernel_verify_sig
> > > > +#define arch_kexec_kernel_verify_sig kexec_kernel_verify_sig
> > > > +#endif
> > > > +
> > > >  /**
> > > >   * struct kexec_buf - parameters for finding a place for a buffer in memory
> > > >   * @image:	kexec image in which memory to search.
> > > > @@ -276,12 +296,6 @@ int crash_shrink_memory(unsigned long new_size);
> > > >  size_t crash_get_memory_size(void);
> > > >  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
> > > >  
> > > > -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > > -					 unsigned long buf_len);
> > > > -void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> > > > -int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
> > > > -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > > -					unsigned long buf_len);
> > > 
> > > I thought we can keep using the __weak function in common code and drop
> > > the arch functions, no need the #ifndef arch_kexec_kernel_image_probe
> > > and the function renaming stuff.  But I did not notice the powerpc
> > > _probe function checks KEXEC_ON_CRASH, that should be checked earlier
> > > and we can fail out early if not supported, but I have no idea
> > > how to do it gracefully for now.
> > > 
> > > Also for x86 _load function it cleanups image->arch.elf_headers, it can
> > > not be dropped simply.
> > 
> > Yeah, arm64 post_load_cleanup function also has some extra stuff.
> > See my patch #7/8.
> 
> But the x86 cleanup was dropped silently, can you add it in x86
> post_load_cleanup as well?
> 
> > 
> > > Consider the above two issues, maybe you can keep the powerpc
> > > version of _probe() and x86 version of _load(), and still copy the common code
> > > to kexec_file.c weak functions.
> > 
> > It was exactly what I made before submitting v3, but I changed
> > my mind a bit. My intension is to prevent the code being duplicated
> > even though it has only a few lines of code.
> > 
> > I agree that '#ifndef arch_kexec_kernel_image_probe' in kexec.h would be
> > quite ugly, but similar usages can be spotted in the kernel source.
> > 
> > That said if you don't like it at all, I defer to you.
> 
> I understand your concern, maybe still use a weak function for 
> arch_kexec_kernel_image_*, and they call the kexec_kernel_image_* in
> kexec_file.c common code.
> 
> Like in general code:
> 
> int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>                                          unsigned long buf_len)
> {
> 	return kexec_kernel_image_probe(image, buf, buf_len);

in this way, we maybe move kexec_kernel_image_probe to
_kexec_kernel_image_probe, add a underscore prefix to mean that is used
internally.

> }
> 
> In architechture code it can add other code and call
> kexec_kernel_image_*
> 
> It looks a bit better than the #ifdef way. 
> 
> [snip]
> 
> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> 
> Thanks
> Dave
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
