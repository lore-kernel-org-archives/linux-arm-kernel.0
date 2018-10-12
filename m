From: rick.p.edgecombe@intel.com (Edgecombe, Rick P)
Date: Fri, 12 Oct 2018 22:54:00 +0000
Subject: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
In-Reply-To: <a89e6d7bbcfba2ebaad927fac0da131ded59aa28.camel@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-5-rick.p.edgecombe@intel.com>
 <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
 <20181012143254.idy65qbvaaw5k3ge@linux-8ccs>
 <a89e6d7bbcfba2ebaad927fac0da131ded59aa28.camel@intel.com>
Message-ID: <3b72b2c535aabb7e0bd13bbfd8f182a7dd8f321b.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-10-12 at 22:01 +0000, Edgecombe, Rick P wrote:
> On Fri, 2018-10-12 at 16:32 +0200, Jessica Yu wrote:
> > +++ Dave Hansen [11/10/18 16:47 -0700]:
> > > On 10/11/2018 04:31 PM, Rick Edgecombe wrote:
> > > > +	if (check_inc_mod_rlimit(size))
> > > > +		return NULL;
> > > > +
> > > >  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> > > >  				module_alloc_base + MODULES_VSIZE,
> > > >  				gfp_mask, PAGE_KERNEL_EXEC, 0,
> > > > @@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
> > > >  		return NULL;
> > > >  	}
> > > > 
> > > > +	update_mod_rlimit(p, size);
> > > 
> > > Is there a reason we couldn't just rename all of the existing per-arch
> > > module_alloc() calls to be called, say, "arch_module_alloc()", then put
> > > this new rlimit code in a generic helper that does:
> > > 
> > > 
> > > 	if (check_inc_mod_rlimit(size))
> > > 		return NULL;
> > > 
> > > 	p = arch_module_alloc(...);
> > > 
> > > 	...
> > > 
> > > 	update_mod_rlimit(p, size);
> > > 
> > 
> > I second this suggestion. Just make module_{alloc,memfree} generic,
> > non-weak functions that call the rlimit helpers in addition to the
> > arch-specific arch_module_{alloc,memfree} functions.
> > 
> > Jessica
> 
> Ok, thanks. I am going to try another version of this with just a system wide
> BPF JIT limit based on the problems Jann brought up. I think it would be nice
> to
> have a module space limit, but as far as I know the only way today un-
> privlidged 
> users could fill the space is from BPF JIT. Unless you see another purpose
> long
> term?

Err, nevermind. Going to try to include both limits. I'll incorporate this
refactor into the next version.
