From: bhe@redhat.com (Baoquan He)
Date: Tue, 20 Mar 2018 11:48:28 +0800
Subject: [PATCH v8 01/13] resource: add walk_system_ram_res_rev()
In-Reply-To: <20180320031253.bwxat2dr3sns5uj4@dragonfly>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-2-takahiro.akashi@linaro.org>
 <20180223083619.GA4433@dhcp-128-65.nay.redhat.com>
 <20180320014318.GA2514@localhost.localdomain>
 <20180320031253.bwxat2dr3sns5uj4@dragonfly>
Message-ID: <20180320034828.GB2514@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/18 at 12:12pm, AKASHI Takahiro wrote:
> Baoquan,
> 
> On Tue, Mar 20, 2018 at 09:43:18AM +0800, Baoquan He wrote:
> > On 02/23/18 at 04:36pm, Dave Young wrote:
> > > Hi AKASHI,
> > > 
> > > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > > > This function, being a variant of walk_system_ram_res() introduced in
> > > > commit 8c86e70acead ("resource: provide new functions to walk through
> > > > resources"), walks through a list of all the resources of System RAM
> > > > in reversed order, i.e., from higher to lower.
> > > > 
> > > > It will be used in kexec_file implementation on arm64.
> > > 
> > > I remember there was an old discussion about this, it should be added
> > > in patch log why this is needed.
> > 
> > It's used to load kernel/initrd at the top of system RAM, and this is
> > consistent with user space kexec behaviour.
> > 
> > In x86 64, Vivek didn't do like this since there's no reverse iomem
> > resource iterating function, he just chose a match RAM region bottom up,
> > then put kernel/initrd top down in the found RAM region. This is
> > different than kexec_tools utility. I am considering to change resource
> > sibling as double list, seems AKASHI's way is easier to be accepted by
> > people. So I will use this one to change x86 64 code.
> > 
> > Hi AKASHI,
> > 
> > About arm64 kexec_file patches, will you post recently? Or any other
> > plan?
> 
> A short answer is yes, but my new version won't include this specific patch.
> So please feel free to add it to your own patch set if you want.
> 
> The reason that I'm going to remove it is that we will make a modification
> on /proc/iomem due to a bug fixing and then we will have to have our own 
> "walking" routine.

I see. Saw your post about the /proc/iomem issue and discussions.

Then I will add this patch in and post a patchset.

Thanks
Baoquan

> 
> 
> > Thanks
> > Baoquan
> > 
> > > 
> > > > 
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > ---
> > > >  include/linux/ioport.h |  3 +++
> > > >  kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 60 insertions(+)
> > > > 
> > > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > > index da0ebaec25f0..f12d95fe038b 100644
> > > > --- a/include/linux/ioport.h
> > > > +++ b/include/linux/ioport.h
> > > > @@ -277,6 +277,9 @@ extern int
> > > >  walk_system_ram_res(u64 start, u64 end, void *arg,
> > > >  		    int (*func)(struct resource *, void *));
> > > >  extern int
> > > > +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > > > +			int (*func)(struct resource *, void *));
> > > > +extern int
> > > >  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
> > > >  		    void *arg, int (*func)(struct resource *, void *));
> > > >  
> > > > diff --git a/kernel/resource.c b/kernel/resource.c
> > > > index e270b5048988..bdaa93407f4c 100644
> > > > --- a/kernel/resource.c
> > > > +++ b/kernel/resource.c
> > > > @@ -23,6 +23,8 @@
> > > >  #include <linux/pfn.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/resource_ext.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/vmalloc.h>
> > > >  #include <asm/io.h>
> > > >  
> > > >  
> > > > @@ -486,6 +488,61 @@ int walk_mem_res(u64 start, u64 end, void *arg,
> > > >  				     arg, func);
> > > >  }
> > > >  
> > > > +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > > > +				int (*func)(struct resource *, void *))
> > > > +{
> > > > +	struct resource res, *rams;
> > > > +	int rams_size = 16, i;
> > > > +	int ret = -1;
> > > > +
> > > > +	/* create a list */
> > > > +	rams = vmalloc(sizeof(struct resource) * rams_size);
> > > > +	if (!rams)
> > > > +		return ret;
> > > > +
> > > > +	res.start = start;
> > > > +	res.end = end;
> > > > +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > > > +	i = 0;
> > > > +	while ((res.start < res.end) &&
> > > > +		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> > > > +		if (i >= rams_size) {
> > > > +			/* re-alloc */
> > > > +			struct resource *rams_new;
> > > > +			int rams_new_size;
> > > > +
> > > > +			rams_new_size = rams_size + 16;
> > > > +			rams_new = vmalloc(sizeof(struct resource)
> > > > +							* rams_new_size);
> > > > +			if (!rams_new)
> > > > +				goto out;
> > > > +
> > > > +			memcpy(rams_new, rams,
> > > > +					sizeof(struct resource) * rams_size);
> > > > +			vfree(rams);
> > > > +			rams = rams_new;
> > > > +			rams_size = rams_new_size;
> > > > +		}
> > > > +
> > > > +		rams[i].start = res.start;
> > > > +		rams[i++].end = res.end;
> > > > +
> > > > +		res.start = res.end + 1;
> > > > +		res.end = end;
> > > > +	}
> > > > +
> > > > +	/* go reverse */
> > > > +	for (i--; i >= 0; i--) {
> > > > +		ret = (*func)(&rams[i], arg);
> > > > +		if (ret)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +out:
> > > > +	vfree(rams);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> > > >  
> > > >  /*
> > > > -- 
> > > > 2.16.2
> > > > 
> > > 
> > > Thanks
> > > Dave
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
