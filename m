From: premi@ti.com (Premi, Sanjeev)
Date: Wed, 24 Aug 2011 14:03:22 +0530
Subject: [PATCH v2 2/2] omap_twl: Prevent SR to enable for
	am3517/am3505devices
In-Reply-To: <24b1eaea368d2a7a692dc5455aa8b255@mail.gmail.com>
References: <1314105680-17426-1-git-send-email-abhilash.kv@ti.com>
	<24b1eaea368d2a7a692dc5455aa8b255@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930256C4F095@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of 
> Sripathy, Vishwanath
> Sent: Tuesday, August 23, 2011 7:14 PM
> To: Koyamangalath, Abhilash; linux-omap at vger.kernel.org
> Cc: paul at pwsan.com; linux at arm.linux.org.uk; Cousson, Benoit; 
> tony at atomide.com; linux-kernel at vger.kernel.org; Hiremath, 
> Vaibhav; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH v2 2/2] omap_twl: Prevent SR to enable 
> for am3517/am3505devices
> 
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> > arm-kernel-bounces at lists.infradead.org] On Behalf Of Abhilash K V
> > Sent: Tuesday, August 23, 2011 6:51 PM
> > To: linux-omap at vger.kernel.org
> > Cc: paul at pwsan.com; linux at arm.linux.org.uk; b-cousson at ti.com;
> > tony at atomide.com; linux-kernel at vger.kernel.org; Vaibhav Hiremath;
> > Abhilash K V; linux-arm-kernel at lists.infradead.org
> > Subject: [PATCH v2 2/2] omap_twl: Prevent SR to enable for
> > am3517/am3505devices
> >
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > In case of AM3517 & AM3505, Smart Reflex is not applicable so
> > we must not enable it. So add check for absence of SR feature
> > in omap3_twl_init() and return -ENODEV if absence, else continue.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> > ---
> >  arch/arm/mach-omap2/id.c              |    2 +-
> >  arch/arm/mach-omap2/omap_twl.c        |    8 ++++++++
> >  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
> >  3 files changed, 11 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 37efb86..da71098 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -202,7 +202,7 @@ static void __init omap3_check_features(void)
> >  	if (cpu_is_omap3630())
> >  		omap_features |= OMAP3_HAS_192MHZ_CLK;
> >  	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> > -		omap_features |= OMAP3_HAS_IO_WAKEUP;
> > +		omap_features |= (OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_SR);
> >
> >  	omap_features |= OMAP3_HAS_SDRC;
> >
> > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-
> > omap2/omap_twl.c
> > index 07d6140..47e27b5 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -269,6 +269,14 @@ int __init omap3_twl_init(void)
> >  	if (!cpu_is_omap34xx())
> >  		return -ENODEV;
> >
> > +	/*
> > +	 * In case of AM3517/AM3505 we should not be going down
> > +	 * further, since SR is not applicable there.
> > +	 */
> > +	if (!omap3_has_sr()) {
> > +		return -ENODEV;
> > +	}
> I do not understand what has vp_max and vp_min configuration 
> to do with
> SR. This parameter indicates the maximum and minimum voltage 
> supported by
> respective PM IC.

[sp] omap3_twl_init() shouldn't be executed for AM35x.
     Considering that we are using "SR" as feature, the check
     should be "PMIC" centric not "SR" centric.

~sanjeev

> 
> Vishwa
> 
> > +
> >  	if (cpu_is_omap3630()) {
> >  		omap3_mpu_volt_info.vp_vddmin =
> > OMAP3630_VP1_VLIMITTO_VDDMIN;
> >  		omap3_mpu_volt_info.vp_vddmax =
> > OMAP3630_VP1_VLIMITTO_VDDMAX;
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> > omap/include/plat/cpu.h
> > index 67b3d75..294e015 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -491,6 +491,7 @@ extern u32 omap_features;
> >  #define OMAP4_HAS_MPU_1GHZ		BIT(8)
> >  #define OMAP4_HAS_MPU_1_2GHZ		BIT(9)
> >  #define OMAP4_HAS_MPU_1_5GHZ		BIT(10)
> > +#define OMAP3_HAS_SR			BIT(11)
> >
> >
> >  #define OMAP3_HAS_FEATURE(feat,flag)			\
> > @@ -507,6 +508,7 @@ OMAP3_HAS_FEATURE(isp, ISP)
> >  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> >  OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> >  OMAP3_HAS_FEATURE(sdrc, SDRC)
> > +OMAP3_HAS_FEATURE(sr, SR)
> >
> >  /*
> >   * Runtime detection of OMAP4 features
> > --
> > 1.7.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
