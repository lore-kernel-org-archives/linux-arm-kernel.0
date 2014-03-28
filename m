From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 21:00:31 +0000
Subject: [PATCH 41/75] ARM: l2c: provide generic hook to intercept
 writes to secure registers
In-Reply-To: <20140328205158.GC28265@joshc.qualcomm.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYXc-0007Fd-8A@rmk-PC.arm.linux.org.uk>
 <20140328205158.GC28265@joshc.qualcomm.com>
Message-ID: <20140328210031.GS7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:51:58PM -0500, Josh Cartwright wrote:
> On Fri, Mar 28, 2014 at 03:17:56PM +0000, Russell King wrote:
> > @@ -60,13 +60,30 @@ static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
> >  }
> >  
> >  /*
> > + * By default, we write directly to secure registers.  Platforms must
> > + * override this if they are running non-secure.
> > + */
> > +static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
> > +{
> > +	if (val == readl_relaxed(base + reg))
> > +		return;
> > +	if (outer_cache.write_sec)
> > +		outer_cache.write_sec(val, reg);
> > +	else
> > +		writel_relaxed(val, base + reg);
> > +}
> > +
> > +/*
> [..]
> > @@ -97,7 +114,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
> >  
> >  	/* Only write the aux register if it needs changing */
> >  	if (readl_relaxed(base + L2X0_AUX_CTRL) != aux)
> 
> It looks like this conditional can be dropped, since l2c_write_sec is
> just going to perform the same check.

Yea, I changed l2c_write_sec() today because wanted to add it to a couple
of other places and didn't check the existing users.  Good catch.  Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
