From: collinsd@codeaurora.org (David Collins)
Date: Mon, 9 Jul 2018 16:44:14 -0700
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180702102853.GI18211@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <20180702102853.GI18211@sirena.org.uk>
Message-ID: <9bbfb628-018d-2d89-257b-9cc4e716cb46@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 07/02/2018 03:28 AM, Mark Brown wrote:
> On Fri, Jun 22, 2018 at 05:46:14PM -0700, David Collins wrote:
> 
>> --- /dev/null
>> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>> @@ -0,0 +1,746 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
>> +
> 
> Please make the entire header block C++ so it looks intentional.

Sure, I'll change this.

I was trying to follow the guideline that kernel C source files should use
C style comments while at the same time following the SPDX guideline that
C++ style comments are needed for the SPDX line in C source files [1].


>> +	cmd.data = bypassed ? PMIC4_BOB_MODE_PASS : pmic_mode;
> 
> Please just write normal if statements, the ternery operator isn't
> really helping legibility.

I'll change this.


>> +static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>> +	[REGULATOR_MODE_INVALID] = -EINVAL,
>> +	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
>> +	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
>> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
>> +	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
>> +};
> 
> This mapping is really weird, I'd expect one of the modes to correspond
> to the normal operating mode of the regulator.  

My thinking here was to have a consistent mapping for consumers to use
between REGULATOR_MODE_* and physical regulator modes for both LDO and
SMPS type regulators:

REGULATOR_MODE_STANDBY --> Retention (if supported)
REGULATOR_MODE_IDLE    --> Low power mode (if supported)
                           LPM for LDO and PFM for SMPS
REGULATOR_MODE_NORMAL  --> Auto HW switching between low and high power
                           mode (if supported)
REGULATOR_MODE_FAST    --> High power mode
                           HPM for LDO and PWM for SMPS

This allows a consumer to request NORMAL in typical use cases and FAST in
use cases that require low voltage ripple.  If NORMAL is not supported,
then it automatically gets upgraded to FAST by the regulator framework.

I could change it so that REGULATOR_MODE_NORMAL maps to LDO HPM mode.
However, doing so would make it so that REGULATOR_MODE_FAST requests would
fail for LDOs.  Thus, consumers would need to know if their supply is an
LDO or an SMPS (which seems undesirable).

Would it be acceptable to have both NORMAL and FAST map to LDO HPM?


>> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
>> +{
>> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
>> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
>> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>> +	};
> 
> Same here, based on that it looks like auto mode is a good map for
> normal.

LDO type regulators physically do not support AUTO mode.  That is why I
specified REGULATOR_MODE_INVALID in the mapping.


>> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
>> +		return -EINVAL;
> 
> Why not use ARRAY_SIZE?

I'll change this.


Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst?h=v4.18-rc4#n74

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
