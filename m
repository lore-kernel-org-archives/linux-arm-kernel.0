From: msalter@redhat.com (Mark Salter)
Date: Tue, 11 Aug 2015 17:17:25 -0400
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <alpine.LFD.2.20.1508111558210.1515@knanqh.ubzr>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
 <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
 <20150805112713.GY7557@n2100.arm.linux.org.uk>
 <1439315290.3153.11.camel@redhat.com>
 <20150811181008.GA7557@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1508111501130.1515@knanqh.ubzr>
 <20150811195638.GC7557@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1508111558210.1515@knanqh.ubzr>
Message-ID: <1439327845.3153.17.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-11 at 16:20 -0400, Nicolas Pitre wrote:
> On Tue, 11 Aug 2015, Russell King - ARM Linux wrote:
> 
> > On Tue, Aug 11, 2015 at 03:41:52PM -0400, Nicolas Pitre wrote:
> > > I'd agree.  But first I'd like to know why the fedora kernel is using 
> > > CONFIG_UACCESS_WITH_MEMCPY?  If it's just because it sounded cool 
> > > then 
> > > that's a bad reason.
> > > 
> > > That code was created to work around inneficiency in the Orion CPU 
> > > core 
> > > that didn't coalesce writes from STRT instructions, and by using 
> > > plain 
> > > STR and/or STM the actual throughput was more than doubled.  This was 
> > > fixed in later cores. However Orion users (if they still exist) might 
> > > like the added performance. I don't have Orion-based targets anymore 
> > > (they took the way of the recycling facility a while ago).
> > 
> > Irrespective of that, what has been found is that the implementation is
> > unsafe - it is taking a semaphore when page faults are disabled.  In
> > other words, notwithstanding the above, it's buggy no matter if it's
> > an Orion CPU core, or highmem, or what.  Any place in the kernel which
> > uses pagefault_disable() and then calls into this code will be buggy.
> > 
> > It needs fixing or removing.
> 
> Absolutely. I'm not disputing that. I'm only asking so we can wisely 
> choose between fixing or removing.  Personally I'd be inclined towards 
> the later, unless the following is sufficient to fix it:
> 
> diff --git a/arch/arm/lib/uaccess_with_memcpy.c 
> b/arch/arm/lib/uaccess_with_memcpy.c
> index 3e58d71001..4b39af2dfd 100644
> --- a/arch/arm/lib/uaccess_with_memcpy.c
> +++ b/arch/arm/lib/uaccess_with_memcpy.c
> @@ -96,7 +96,7 @@ __copy_to_user_memcpy(void __user *to, const void 
> *from, unsigned long n)
>  	}
>  
>  	/* the mmap semaphore is taken only if not in an atomic context 
> */
> -	atomic = in_atomic();
> +	atomic = faulthandler_disabled();
>  
>  	if (!atomic)
>  		down_read(&current->mm->mmap_sem);

Yeah, that fixes the problem I was seeing.

> 
> > Even if it is fixed, making it _depend_ on CPU_FEROCEON sounds like a
> > good idea if non-orion stuff isn't supposed to be enabling it.  Or
> > something like that.
> 
> It is not clear to me exactly which cores are affected.  That's why the 
> Kconfig entry was left open to all, in case it could benefit others.
> In theory it shouldn't be harmful to anyone notwithstanding the caveat
> mentioned in the help text.

This was on a calxeda highbank.

With CONFIG_UACCESS_WITH_MEMCPY, the dd copy test reported 1.8GB/s
Without CONFIG_UACCESS_WITH_MEMCPY, 2.1GB/s
