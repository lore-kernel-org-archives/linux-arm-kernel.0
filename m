From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 13:23:12 +0000
Subject: [PATCH V2 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <1387318102-11070-2-git-send-email-b20788@freescale.com>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <1387318102-11070-2-git-send-email-b20788@freescale.com>
Message-ID: <20131217132312.GB3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:08:22PM -0500, Anson Huang wrote:

>  	if (new_freq > old_freq) {
> +		if (regulator_is_enabled(pu_reg)) {
> +			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);

As I pointed out while reviewing the regulator driver this is racy,
nothing stops the regulator state being changed after you read it and if
you skip setting the voltage then when something comes along and enables
the regulator later it will be enabled with a possibly incorrect
voltage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/d02ae8c5/attachment.sig>
