From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Jul 2018 11:28:53 +0100
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
Message-ID: <20180702102853.GI18211@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:

> --- /dev/null
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +

Please make the entire header block C++ so it looks intentional.

> +	cmd.data = bypassed ? PMIC4_BOB_MODE_PASS : pmic_mode;

Please just write normal if statements, the ternery operator isn't
really helping legibility.

> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
> +	[REGULATOR_MODE_INVALID] = -EINVAL,
> +	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
> +	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
> +	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
> +};

This mapping is really weird, I'd expect one of the modes to correspond
to the normal operating mode of the regulator.  

> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
> +{
> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> +	};

Same here, based on that it looks like auto mode is a good map for
normal.

> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
> +		return -EINVAL;

Why not use ARRAY_SIZE?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/2b53c489/attachment.sig>
