From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 Dec 2016 10:44:29 +0100
Subject: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20161209102236.17655-4-quentin.schulz@free-electrons.com>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
Message-ID: <20161210094429.yp26sfoz54oqy3dz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just some minor comments.

On Fri, Dec 09, 2016 at 11:22:36AM +0100, Quentin Schulz wrote:
> +	/*
> +	 * Since the thermal sensor needs the IP to be in touchscreen mode and
> +	 * there is no register to know if the IP has finished its transition
> +	 * between the two modes, a delay is required when switching modes. This
> +	 * slows down ADC readings while the latter are critical data to the

The latter between what and what?

> +	 * user. Disabling CONFIG_THERMAL_OF in kernel configuration allows the
> +	 * user to avoid registering the thermal sensor (thus unavailable) and

Isn't it obvious that it's not going to be available if you do not
register it?

> +	 * does not switch between modes thus "quicken" the ADC readings.
> +	 * The thermal sensor should be enabled by default since the SoC
> +	 * temperature is usually more critical than ADC readings.

This last sentence should be in the Kconfig help. You cannot expect
that all your users will read all the source code they want to compile
:)

Overall, I think this comment is kind of missing the point, maybe
something like:

/*
 * Since the controller needs to be in touchscreen mode for its
 * thermal sensor to operate properly, and that switching between the
 * two modes needs a delay, always registering in the thermal
 * framework will significantly slow down the conversion rate of the
 * ADCs.
 *
 * Therefore, instead of depending on THERMAL_OF in Kconfig, we only
 * register the sensor if that option is enabled, eventually leaving
 * that choice to the user.
 */

Would be much clearer.

> +	 */
> +
> +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> +	/*
> +	 * This driver is a child of an MFD which has a node in the DT but not
> +	 * its children. Therefore, the resulting devices of this driver do not

Wrong indentation for the comment, and saying why the MFD children
don't have a node in the DT (backward compatibility) would be nice.

> +	 * have an of_node variable.
> +	 * However, its parent (the MFD driver) has an of_node variable and
> +	 * since devm_thermal_zone_of_sensor_register uses its first argument to
> +	 * match the phandle defined in the node of the thermal driver with the
> +	 * of_node of the device passed as first argument and the third argument
> +	 * to call ops from thermal_zone_of_device_ops, the solution is to use
> +	 * the parent device as first argument to match the phandle with its
> +	 * of_node, and the device from this driver as third argument to return
> +	 * the temperature.
> +	 */
> +		tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> +							   info,
> +							   &sun4i_ts_tz_ops);

I don't think tzd is used anywhere else in your function, it can be
made local to this block.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161210/bd1b17fb/attachment.sig>
