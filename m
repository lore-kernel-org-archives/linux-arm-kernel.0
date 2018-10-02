From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 2 Oct 2018 15:20:23 +0900
Subject: [PATCH v15 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180930100834.GD6950@dhcp-128-65.nay.redhat.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-5-takahiro.akashi@linaro.org>
 <20180930100834.GD6950@dhcp-128-65.nay.redhat.com>
Message-ID: <20181002062021.GE32578@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 06:08:34PM +0800, Dave Young wrote:
> Hi AKASHI,
> 
> On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> > Memblock list is another source for usable system memory layout.
> > So move powerpc's arch_kexec_walk_mem() to common code so that other
> > memblock-based architectures, particularly arm64, can also utilise it.
> > A moved function is now renamed to kexec_walk_memblock() and integrated
> > into kexec_locate_mem_hole(), which will now be usable for all
> > architectures with no need for overriding arch_kexec_walk_mem().
> > 
> > With this change, arch_kexec_walk_mem() need no longer be a weak function,
> > and was now renamed to kexec_walk_resources().
> > 
> > Since powerpc doesn't support kdump in its kexec_file_load(), the current
> > kexec_walk_memblock() won't work for kdump either in this form, this will
> > be fixed in the next patch.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Acked-by: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Acked-by: James Morse <james.morse@arm.com>
> 
> [snip]
> 
> > +
> >  /**
> >   * arch_kexec_walk_mem - call func(data) on free memory regions
> 
> The function name should be updated as well.

Ah, thank you.
-Takahiro Akashi

> >   * @kbuf:	Context info for the search. Also passed to @func.
> > @@ -510,8 +560,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> >   * and that value will be returned. If all free regions are visited without
> >   * func returning non-zero, then zero will be returned.
> >   */
> > -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > -			       int (*func)(struct resource *, void *))
> > +static int kexec_walk_resources(struct kexec_buf *kbuf,
> > +				int (*func)(struct resource *, void *))
> >  {
> >  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> >  		return walk_iomem_res_desc(crashk_res.desc,
> > @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >  	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
> >  		return 0;
> >  
> > -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> > +	else
> > +		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
> >  
> >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> >  }
> > -- 
> > 2.19.0
> > 
> 
> Thanks
> Dave
