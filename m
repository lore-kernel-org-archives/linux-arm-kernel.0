From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Tue, 15 Feb 2011 22:00:20 +0530
Subject: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
In-Reply-To: <20110215171652.601c9c68.jhnikula@gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
Message-ID: <bf1e2a72d8f16365df684cd5add00eee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Jarkko Nikula
> Sent: Tuesday, February 15, 2011 8:47 PM
> To: Shweta Gulati
> Cc: Nishanth Menon; Thara Gopinath; linux-omap at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on
> TWL
>
> On Tue, 15 Feb 2011 13:28:58 +0530
> Shweta Gulati <shweta.gulati@ti.com> wrote:
>
> > This patch is based on LO PM Branch and Smartreflex has been
> > tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> > OMAP2430 SDP.
> >
> I saw this was working on N900 (kind of special instrumentation
> setup) after enabling /sys/kernel/debug/voltage/[vdd_core |
> vdd_mpu]/smartreflex/autocomp. Few comments below.
>
> > @@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
> >  		omap3_core_volt_info.vp_vddmax =
> OMAP3630_VP2_VLIMITTO_VDDMAX;
> >  	}
> ...
> > +	if (!twl_sr_enable_autoinit)
> > +		omap3_twl_set_sr_bit(true);
> ...
> > +int __init omap3_twl_set_sr_bit(bool enable)
> > +{
> > +	u8 temp;
> > +	int ret;
> > +	if (twl_sr_enable_autoinit)
> > +		pr_warning("%s: unexpected multiple calls\n", __func__);
> > +
> > +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> > +					TWL4030_DCDC_GLOBAL_CFG);
> > +	if (ret)
> > +		goto err;
> > +
> > +	if (enable)
> > +		temp |= SMARTREFLEX_ENABLE;
> > +	else
> > +		temp &= ~SMARTREFLEX_ENABLE;
> > +
> > +	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> > +				TWL4030_DCDC_GLOBAL_CFG);
>
> Would it make more sense to set only the flag here and do the register
> writes when omap3_twl_init is executing? Then it's not so strict when
> the board code calls this function.
What if board code calls this function after twl_init is executed? Then
you will not clear the bit right?
Intention of this function is to make sure the bit is set/cleared when it
is called.

vishwa
>
> > +	if (!ret) {
> > +		twl_sr_enable_autoinit = true;
> > +		return 0;
>
> Should this be twl_sr_enable_autoinit = enable (if going to do
> register write here)?
>
> --
> Jarkko
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
