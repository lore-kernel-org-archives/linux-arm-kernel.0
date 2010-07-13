From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 11:00:12 +0100
Subject: [PATCH 3/3] ux500: add ab8500-regulators machine specific data
In-Reply-To: <1279002090-11234-4-git-send-email-sundar.iyer@stericsson.com>
References: <1279002090-11234-1-git-send-email-sundar.iyer@stericsson.com>
	<1279002090-11234-4-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100713100012.GC12686@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 11:51:30AM +0530, Sundar Iyer wrote:

> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
> +	{ .dev = NULL, .supply = "vaux1", },
> +};

All these supplies with NULL devices are bogus, supplies are in terms of
the device being supplied not the labels on the board.  If you've got a
supply with no device and the name of the supply on either the regulator
or the board you're most likely doing it wrong.  The only exception is
for supplies used in cpufreq since we don't have a struct device we can
use there.

> +struct regulator_init_data ab8500_vaux2_regulator = {
> +	.supply_regulator_dev = NULL,
> +	.constraints = {
> +		.name = "ab8500-vaux2",
> +		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
> +		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,

I'm not convinced that these #defines help anything, they're used in
exactly one place so don't add much to either legibility or ease of
maintinance.
