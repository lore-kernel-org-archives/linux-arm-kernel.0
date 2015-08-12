From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 11 Aug 2015 22:18:26 -0400 (EDT)
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <1439327845.3153.17.camel@redhat.com>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
 <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
 <20150805112713.GY7557@n2100.arm.linux.org.uk>
 <1439315290.3153.11.camel@redhat.com>
 <20150811181008.GA7557@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1508111501130.1515@knanqh.ubzr>
 <20150811195638.GC7557@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1508111558210.1515@knanqh.ubzr>
 <1439327845.3153.17.camel@redhat.com>
Message-ID: <alpine.LFD.2.20.1508112116320.1515@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, Mark Salter wrote:

> On Tue, 2015-08-11 at 16:20 -0400, Nicolas Pitre wrote:
> > On Tue, 11 Aug 2015, Russell King - ARM Linux wrote:
> > 
> > > It needs fixing or removing.
> > 
> > Absolutely. I'm not disputing that. I'm only asking so we can wisely 
> > choose between fixing or removing.  Personally I'd be inclined towards 
> > the later, unless the following is sufficient to fix it:
> > 
> > diff --git a/arch/arm/lib/uaccess_with_memcpy.c 
> > b/arch/arm/lib/uaccess_with_memcpy.c
> > index 3e58d71001..4b39af2dfd 100644
> > --- a/arch/arm/lib/uaccess_with_memcpy.c
> > +++ b/arch/arm/lib/uaccess_with_memcpy.c
> > @@ -96,7 +96,7 @@ __copy_to_user_memcpy(void __user *to, const void 
> > *from, unsigned long n)
> >  	}
> >  
> >  	/* the mmap semaphore is taken only if not in an atomic context 
> > */
> > -	atomic = in_atomic();
> > +	atomic = faulthandler_disabled();
> >  
> >  	if (!atomic)
> >  		down_read(&current->mm->mmap_sem);
> 
> Yeah, that fixes the problem I was seeing.

Good!  Then I'll add it to RMK's patch system.  May I add a tested-by 
tag with your name?

> This was on a calxeda highbank.

Any idea why this option was set?

> With CONFIG_UACCESS_WITH_MEMCPY, the dd copy test reported 1.8GB/s
> Without CONFIG_UACCESS_WITH_MEMCPY, 2.1GB/s

Therefore this is of no benefit to you.


Nicolas
