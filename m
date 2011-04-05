From: khilman@ti.com (Kevin Hilman)
Date: Tue, 05 Apr 2011 11:27:33 -0700
Subject: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout during
	bootup
In-Reply-To: <1302018015-8858-2-git-send-email-avinashhm@ti.com> (Avinash
	H. M.'s message of "Tue, 5 Apr 2011 21:10:14 +0530")
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
	<1302018015-8858-2-git-send-email-avinashhm@ti.com>
Message-ID: <87mxk4zh7u.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Avinash.H.M" <avinashhm@ti.com> writes:

> The i2c module has a special reset sequence. The sequence is
> - Disable the I2C.
> - Write to SOFTRESET bit.
> - Enable the I2C.
> - Poll on the RESETDONE bit.
> This sequence must be followed for i2c reset in omap2, omap3. The sequence is
> implemented as a function and the i2c_class is updated with the correct
> 'reset' pointer.
>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>

[...]

> +
> +/**
> + * omap_i2c_reset- reset the omap i2c module.
> + * @oh: struct omap_hwmod *
> + *
> + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> + * sequence is:
> + * - Disable the I2C.
> + * - Write to SOFTRESET bit.
> + * - Enable the I2C.
> + * - Poll on the RESETDONE bit.
> + * The sequence is implemented in below function. This is called for 2420,
> + * 2430 and omap3.
> + */
> +int omap_i2c_reset(struct omap_hwmod *oh)
> +{
> +	u32 v;
> +	int c = 0;
> +
> +	/* Disable I2C */
> +	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> +	v = v & ~I2C_EN;
> +	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> +
> +	/* Write to the SOFTRESET bit */
> +	v = oh->_sysc_cache;
> +	v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> +
> +	oh->_sysc_cache = v;
> +	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);

Direct SYSCONFIG access isn't right here.   This should go through
omap_hwmod.

What is probably needed is exposing _ocp_softreset to device code
via something like omap_hwmod_ocp_softreset() and calling that here.

Kevin
