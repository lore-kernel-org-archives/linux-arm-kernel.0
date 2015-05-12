From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 07:13:38 +0200
Subject: [PATCH 1/3] ARM: cache-l2c: Add flag to skip cache unlocking
In-Reply-To: <20150511222955.GK2067@n2100.arm.linux.org.uk>
References: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1431382651-15894-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150511222955.GK2067@n2100.arm.linux.org.uk>
Message-ID: <1431407618.2411.86.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-11 at 23:29 +0100, Russell King - ARM Linux wrote:
> On Tue, May 12, 2015 at 12:17:29AM +0200, Sjoerd Simons wrote:
> >  extern struct outer_cache_fns outer_cache;
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index e309c8f..fff7888 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -136,7 +136,8 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
> >  	l2x0_saved_regs.aux_ctrl = aux;
> >  	l2c_configure(base);
> >  
> > -	l2c_unlock(base, num_lock);
> > +	if (!outer_cache.skip_unlock)
> > +		l2c_unlock(base, num_lock);
> 
> I think we can do better here.  If the non-secure lockdown access bit has
> been set, then proceed with the unlock:
> 
> 	if (readl_relaxed(base + L2X0_AUX_CTRL) & L310_AUX_CTRL_NS_LOCKDOWN)
> 		l2c_unlock(base, num_lock);
> 
> I don't see any need to add a flag for this.  This also eliminates your
> second patch.

Main reason I added the flag like this was to simplify the changes as
l2c_enable has no real knowledge about which type of cache it's running
on. 

But sure i will have a look at re-jigging the code such that the
situation is automatically detected rather then requiring the machine
specific code to flag it explicitely 

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
