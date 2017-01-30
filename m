From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 31 Jan 2017 03:09:15 +0530
Subject: [PATCH v2 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170130140326.GU27312@n2100.armlinux.org.uk>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
 <20170122032212.13456-1-afzal.mohd.ma@gmail.com>
 <20170130140326.GU27312@n2100.armlinux.org.uk>
Message-ID: <20170130213915.GA2976@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 30, 2017 at 02:03:26PM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 22, 2017 at 08:52:12AM +0530, afzal mohammed wrote:

> > The exception base address is now dynamically estimated for no-MMU,
> > display it. As it is the case, now limit VECTORS_BASE usage to MMU
> > scenario.

> > +#define VECTORS_BASE		UL(0xffff0000)
> > +
> >  #else /* CONFIG_MMU */
> >  
> >  /*
> > @@ -111,8 +113,6 @@
> >  
> >  #endif /* !CONFIG_MMU */
> >  
> > -#define VECTORS_BASE		UL(0xffff0000)
> 
> I think adding a definition for VECTORS_BASE in asm/memory.h for nommu:
> 
> extern unsigned long vectors_base;
> #define VECTORS_BASE	vectors_base

Above was required to be enclosed by below,

 #ifndef __ASSEMBLY__
 #endif

Putting it inside the existing #ifndef __ASSEMBLY__ (which encloses
other externs) in asm/memory.h would put it alongside not so related
definitions as compared to the existing location.

And the existing #ifndef __ASSEMBLY__ in asm/memory.h is a bit down
that makes the above stand separately,

> > +#ifdef CONFIG_MMU
> >  			MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
> > +#else
> > +			MLK(vectors_base, vectors_base + PAGE_SIZE),
> > +#endif
> 
> will mean that this conditional becomes unnecessary.

> > -#endif
> > +#else /* CONFIG_MMU */
> > +extern unsigned long vectors_base;
> > +#endif /* CONFIG_MMU */
> 
> and you don't need this here either.

but the above improvements make the patch simpler.

Regards
afzal
