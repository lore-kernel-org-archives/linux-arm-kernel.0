From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 26 Dec 2014 18:26:27 +0100
Subject: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
In-Reply-To: <1419597294-21487-3-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
Message-ID: <20141226172627.GB24756@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-12-26 13:34:53, Sebastian Reichel wrote:
> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> which can be used to determine the SoCs temperature. This patch provides
> a DT based driver for the temperature sensor based on an older driver
> written by Peter De Schrijver for the Nokia N900 and N9.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

> +	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> +		clk_enable(data->clk_32k);

This needs to be clk_prepare_enable()

> +		regmap_update_bits(data->syscon, SYSCON_TEMP_REG,
> +				   soc_mask, soc_mask);
> +
> +		if (!wait_for_eocz(EOCZ_MIN_RISING_DELAY,
> +		    EOCZ_MAX_RISING_DELAY, 1, data)) {
> +			e = -EIO;
> +			goto err;
> +		}
> +
> +		regmap_update_bits(data->syscon, SYSCON_TEMP_REG, soc_mask, 0);
> +
> +		if (!wait_for_eocz(EOCZ_MIN_FALLING_DELAY,
> +		    EOCZ_MAX_FALLING_DELAY, 0, data)) {
> +			e = -EIO;
> +			goto err;
> +		}
> +
> +		regmap_read(data->syscon, SYSCON_TEMP_REG, &temp_sensor_reg);
> +		data->temperature = temp_sensor_reg & ((1<<7) - 1);
> +		data->last_updated = jiffies;
> +		data->valid = true;
> +
> +err:
> +		clk_disable(data->clk_32k);

And this clk_disable_unprepare().

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
