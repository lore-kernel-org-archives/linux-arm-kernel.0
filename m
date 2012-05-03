From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 3 May 2012 06:38:34 +0000
Subject: [PATCH 2/5] ARM: OMAP2+: PM: use the power domains registers
 cache for the power states
In-Reply-To: <4FA00343.3020704@ti.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
 <1335877663-32649-3-git-send-email-j-pihet@ti.com> <4FA00343.3020704@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA71233@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 21:07:39, Hunter, Jon wrote:
[...]
> >  int pwrdm_read_pwrst(struct powerdomain *pwrdm)
> >  {
> > -	int ret = -EINVAL;
> > +	int pwrst, ret = -EINVAL;
> >  
> >  	if (!pwrdm)
> >  		return -EINVAL;
> >  
> > -	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
> > +	if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PWRST, &pwrst))
> > +		return pwrst;
> > +
> > +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst) {
> >  		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
> > +		if (ret >= 0)
> > +			pwrdm_cache_write(pwrdm, PWRDM_CACHE_PWRST, ret);
> > +	}
> 
> Do we really want to use the cache for the current state? This is
> updated by hardware. In the above it appears that once we have read it
> once we will just return this value until the cache is invalidated.
> Makes me a little nervous.
> 

I echo the concern here. If a powerdomain transition occurs when h/w conditions
are met, the cached values will go out of sync and this may lead to unexpected
behavior wherever this API is being used.

As Jon pointed out in another patch, the registers which can be updated by h/w should
be handled differently.

Just a wild thought, can PRCM_MPU_IRQ ([4]TRANSITION_EN) be used as a trigger to update
the cache if the transition happened under s/w control?

Regards,
Vaibhav
