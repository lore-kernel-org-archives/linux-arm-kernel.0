From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Date: Wed, 21 Nov 2012 13:35:25 -0500
Subject: [PATCH 022/493] ARM: remove CONFIG_HOTPLUG ifdefs
In-Reply-To: <20121121114419.GB3290@n2100.arm.linux.org.uk>
Message-ID: <20121121183525.BF1118013C@viridian.itc.virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
> 
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index b9f38e3..38279fe 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -66,10 +66,8 @@ SECTIONS
> >  		ARM_EXIT_DISCARD(EXIT_TEXT)
> >  		ARM_EXIT_DISCARD(EXIT_DATA)
> >  		EXIT_CALL
> > -#ifndef CONFIG_HOTPLUG
> >  		*(.ARM.exidx.devexit.text)
> >  		*(.ARM.extab.devexit.text)
> > -#endif
> 
> This to me looks wrong.  Do we want to unconditionally discard devexit
> debugging?
> 

Whoa, yeah, that's not right.  I got it backwards.

The right fix gets rid of all those devexit lines as devexit will be
going away.

Should I just redo this patch or send an additional one that removes
those 2 lines?


> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index d1ea7ce..856b58d 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -74,13 +74,8 @@
> >   * are handled as text/data or they can be discarded (which
> >   * often happens at runtime)
> >   */
> > -#ifdef CONFIG_HOTPLUG
> >  #define DEV_KEEP(sec)    *(.dev##sec)
> >  #define DEV_DISCARD(sec)
> 
> I hope there will be a follow-on patch to remove the DEV_KEEP() and
> DEV_DISCARD() stuff entirely?
> 

Yes, once hotplug is truly gone these can also go away.

-- 
Bill
