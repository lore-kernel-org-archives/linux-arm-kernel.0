From: avinashhm@ti.com (Avinash.H.M.)
Date: Mon, 9 May 2011 18:18:42 +0530
Subject: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
In-Reply-To: <alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
	<alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
Message-ID: <20110509124842.GA25211@avinash-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 03:58:56PM -0600, Paul Walmsley wrote:

Hi Paul ,

> > 
> > The patch is based on
> >  * git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >  * master branch.
> >  * 9be20f0 commit. ( Linux-omap rebuilt: Updated to -rc5 )
> 
> Please base all your patches against mainline commits.  I suggest using 
> v2.6.39-rc6.

OK Paul. I will rebase against mainline, -rc6.

> 
> Also some comments:
> 
> > Changes from previous versions:
> > from v1:
> > 	- moved i2c specific things from hwmod files to i2c files.
> > 	- fixed comments from Paul.
> > 	- http://www.spinics.net/lists/linux-omap/msg49483.html
> > 
> > +
> > +/**
> > + * omap_i2c_reset- reset the omap i2c module.
> 
> Please put a space before the dash.

OK. I ll correct.

> 
> > + * @oh: struct omap_hwmod *
> > + *
> > + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> > + * sequence is:
> > + * - Disable the I2C.
> > + * - Write to SOFTRESET bit.
> > + * - Enable the I2C.
> > + * - Poll on the RESETDONE bit.
> > + * The sequence is implemented in below function. This is called for 2420,
> > + * 2430 and omap3.
> > + */
> > +int omap_i2c_reset(struct omap_hwmod *oh)
> > +{
> You're missing kerneldoc here.  Please add it.

OK. I ll add the kerneldoc.

> 
> > +void omap_hwmod_softreset(struct omap_hwmod *oh)
> > +{
> > +	u32 v;
> > +
> > +	/* Write to the SOFTRESET bit in SYSCONFIG */
> > +	v = oh->_sysc_cache;
> > +	v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> > +
> > +	oh->_sysc_cache = v;
> > +	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> > +}
> 
> This is a public function, so you need to validate your oh argument and 
> return an error if something isn't right.  Similarly, you should use the 
> existing function _set_softreset() to set the bit, because it also does 
> some errorchecking.
> 


I agree. I ll use _set_softreset to set the bit and check for the
argument sanity.

> > +
> >  /**
> >   * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
> >   * @oh: struct omap_hwmod *
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c

thanks for reviewing.

- Avinash
> 
> 
> - Paul
