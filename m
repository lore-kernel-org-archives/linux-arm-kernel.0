From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 17:50:10 +0100
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <20150309173736.GB8656@n2100.arm.linux.org.uk>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <356997090.ZkRbrlLqgW@wuerfel> <20150309173736.GB8656@n2100.arm.linux.org.uk>
Message-ID: <201503131750.10885.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015, Russell King - ARM Linux wrote:
> On Wed, Mar 04, 2015 at 03:38:29PM +0100, Arnd Bergmann wrote:
> > On Wednesday 04 March 2015 15:12:02 Robert Jarzmik wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > 
> > > 
> > > I'm not sure I understand this patch fully, so take with caution my comment.
> > > If I'm not mistaken, the former behavior was for pxa3xx:
> > >  - cpu_is_xscale() -> false
> > >  - cpu_is_xsc3() -> true
> > >  => this implied PMD_BIT4 was set
> > > 
> > > With your patch :
> > >  - cpu_is_xscale() -> true
> > >  - cpu_is_xsc3() -> true
> > >  => this implied PMD_BIT4 is not set
> > > 
> > > I like the new meaning for cpu_is_*(), but is the change of PMD_BIT4 the goal of
> > > this patch (the piece in [1]) ?
> > 
> > > > -     if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> > > > +     if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ &&
> > > > +         !cpu_is_xscale() && !cpu_is_xsc3())
> > > >               prot |= PMD_BIT4;
> > > >  
> > > >       pgd += pgd_index(addr);
> > 
> > I tried to not change the behavior here, and I think you missed this part:
> > 
> > -#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
> > +#if !defined(CONFIG_CPU_XSCALE)
> >  #define        cpu_is_xscale() 0
> >  #else
> > -#define        cpu_is_xscale() 1
> >  ...
> > 
> > This means that previously, cpu_is_xscale() returned true for pxa3xx,
> > while now it returns false, and I added the "&& !cpu_is_xsc3()" to
> > keep the logic the same as before.
> 
> Please don't do stuff like this.  It's really easy for it to be buggy.
> 
> Before your change, cpu_is_xscale() returns true for _any_ Xscale CPU,
> whether it's v1, v2 or v3.  After your change, it only returns true for
> v1 and v2 CPUs.  So now the macro is mis-named, and is misleading.
> 
> Either rename the macro, or keep the existing behaviour, or do something
> smarter like:
> 
> #define cpu_is_xscale() (cpu_is_xsc1_2() || cpu_is_xsc3())
> 
> defining cpu_is_xsc1_2() to be your new version of cpu_is_xscale().

I've made a new version with a cpu_is_xscale_family() macro, will post
that as a reply here.

I'm still undecided about what it should return for mohawk though, as
the previous behavior was not well-defined in that case. I ended up
picking the other approach in the second version, but would be thankful
for any kind of guidance regarding whether mohawk should or should not
clear PMD_BIT4.

	Arnd
