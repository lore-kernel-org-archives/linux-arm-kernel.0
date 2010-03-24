From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 13:26:55 +0000
Subject: [PATCH 5/8] MXC: mach-mx31_3ds: Add support for SD card slot
	in the personality board.
In-Reply-To: <1269370438.3276.173.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
	<1269370228.3276.169.camel@realization>
	<1269370305.3276.171.camel@realization>
	<1269370438.3276.173.camel@realization>
Message-ID: <20100324132654.GB26910@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 07:53:58PM +0100, Alberto Panizzo wrote:

> +static void mx31_3ds_setpower(struct device *dev, unsigned int vdd)
> +{
> +	int voltage = 0;
> +
> +	if (vdd <= ilog2(MMC_VDD_165_195))
> +		voltage = 1800000;
> +	else if (vdd == ilog2(MMC_VDD_20_21))
> +		voltage = 2000000;
> +	else
> +		voltage = 2000000 + (vdd - 7) * 100000;
> +
> +	pr_debug("%s: vdd = %d -> REGU_VMMC2 = %d\n", __func__, vdd, voltage);
> +
> +	regulator_set_voltage(vmmc_reg, voltage, voltage);

This code looks wrong - the MMC core is requesting voltage ranges but
these are being non-linearly translated into specific voltages.  I
rather suspect that the standard mmc_regulator_set_ocr() function ought
to be able to cope with this, in conjunction with a regulator constraint
limiting the minimum voltage to 1.8V.  If not, some comments explaining
what's going on would really help.

> +static struct regulator_consumer_supply gpo3_consumers[] = {
> +	{
> +		.dev	= &mxcsdhc_device0.dev,

Use dev_name, not dev.
