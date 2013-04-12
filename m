From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 12 Apr 2013 06:18:04 +0000
Subject: [PATCH v2 11/11] ARM: OMAP2+: omap_hwmod: Don't call
 _init_mpu_rt_base if no sysc
In-Reply-To: <51661613.4070405@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
 <1363699857-5505-12-git-send-email-santosh.shilimkar@ti.com>
 <51661613.4070405@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC4EC9F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hunter, Jon
> Sent: Thursday, April 11, 2013 7:17 AM
> To: Shilimkar, Santosh
> Cc: Cousson, Benoit; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; tony at atomide.com; Hiremath, Vaibhav
> Subject: Re: [PATCH v2 11/11] ARM: OMAP2+: omap_hwmod: Don't call
> _init_mpu_rt_base if no sysc
> 
> 
> On 03/19/2013 08:30 AM, Santosh Shilimkar wrote:
> > OMAP hwmod layer does the reset of the IPs in early code so that
> > we have SOC in sane state. To do the soft-reset, it needs to
> ioremap()
> > the ip address space to be able to write to sysconfig registers.
> >
> > But there are few hwmod which doesn't have sysconfig registers and
> hence
> > no need to ioremap() them in early init code.
> >
> > So this patch makes prevet calling the _init_mpu_rt_base()
> conditional
> > based on sysc availability.
> >
> > Cc: Benoit Cousson <b-cousson@ti.com>
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> > index 4501038..1a1f0a4 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -2449,7 +2449,8 @@ static int __init _init(struct omap_hwmod *oh,
> void *data)
> >  	if (oh->_state != _HWMOD_STATE_REGISTERED)
> >  		return 0;
> >
> > -	_init_mpu_rt_base(oh, NULL);
> > +	if (oh->class->sysc)
> > +		_init_mpu_rt_base(oh, NULL);
> >
> >  	r = _init_clocks(oh, NULL);
> >  	if (IS_ERR_VALUE(r)) {
> 
> I have not looked into why, but this commit is triggering the following
> panic on am335x-evm. I don't see this on the omap platforms only
> am335x.
> 
> Adding Vaibhav ...
> 
I think I have already fixed this, can you try applying below patches

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg87524.html


Thanks,
Vaibhav



Thanks,
Vaibhav
