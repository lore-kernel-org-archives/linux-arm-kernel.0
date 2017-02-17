From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 17 Feb 2017 09:46:23 -0800
Subject: [PATCH] arm64: traps: Mark __le16, __le32,
 __user variables properly
In-Reply-To: <20170217173101.GH21222@n2100.armlinux.org.uk>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170217173101.GH21222@n2100.armlinux.org.uk>
Message-ID: <148735358362.27221.13132782733927847712@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2017-02-17 09:31:01)
> On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 659b2e6b6cf7..23959cb70ded 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -84,7 +84,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> >                       if (p >= bottom && p < top) {
> >                               unsigned long val;
> >  
> > -                             if (__get_user(val, (unsigned long *)p) == 0)
> > +                             if (__get_user(val, (unsigned long __user *)p) == 0)
> >                                       sprintf(str + i * 17, " %016lx", val);
> >                               else
> >                                       sprintf(str + i * 17, " ????????????????");
> > @@ -113,7 +113,7 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
> >       for (i = -4; i < 1; i++) {
> >               unsigned int val, bad;
> >  
> > -             bad = __get_user(val, &((u32 *)addr)[i]);
> > +             bad = __get_user(val, &((u32 __user *)addr)[i]);
> >  
> >               if (!bad)
> >                       p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
> 
> For the majority of causes, these are _not_ user addresses, they are
> kernel addresses.  The use of get_user() at these locations is a way
> to safely access these kernel addresses when something has gone wrong
> without causing a further oops.

Understood. It looks like a custom version of probe_kernel_read() (where
we force the pointer to __user BTW). Is that to only set_fs() once
instead of many times? Maybe we need a ____probe_kernel_read() that
forces it to __user under the covers and doesn't do any set_fs() and
also indicates we know what we're doing?

> 
> Annotating them with __user to shut up sparse is incorrect.  The point
> with sparse is _not_ to end up with a warning free kernel, but for it
> to warn where things are not quite right in terms of semantics.  These
> warnings should stay.
> 
> So, the warnings about lack of __user should stay.
> 

Ok. I usually compile things with 'make -s' and C=2 and then if sparse
complains I want to keep it quiet so I don't have to worry about looking
through the warnings. So in my workflow I _do_ want a warning free
kernel.
