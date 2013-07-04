From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 16:41:05 +0100
Subject: [RFC PATCH V2 1/8] regulator: Introduce OMAP regulator to
 control PMIC over VC/VP
In-Reply-To: <1371849949-12649-2-git-send-email-nm@ti.com>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
 <1371849949-12649-2-git-send-email-nm@ti.com>
Message-ID: <20130704154105.GD27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:25:42PM -0500, Nishanth Menon wrote:

> +static const struct omap_pmic_info omap_twl4030_vdd1 = {
> +	.slave_addr = 0x12,
> +	.voltage_reg_addr = 0x00,
> +	.cmd_reg_addr = 0x00,
> +	.i2c_timeout_us = 200,
> +	.slew_rate_uV = 4000,
> +	.step_size_uV = 12500,
> +	.min_uV = 600000,
> +	.max_uV = 1450000,
> +	.voltage_selector_offset = 0,
> +	.voltage_selector_mask = 0x7F,
> +	.voltage_selector_setbits = 0x0,
> +	.voltage_selector_zero = false,
> +};

So, this still has the thing where all the data about the PMIC is
replicated (but now in this driver).  It should be possible to pull all
the above information except possibly the I2C timeout and perhaps the
I2C address (if there's a separate control interface) from the standard
regulator core data structures for the PMIC.  This would allow the
driver to Just Work with any PMIC without needing to add it in two
places.

Other than that this looks good, the only issue I see is where the
driver is getting the data from.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/f4329a32/attachment.sig>
