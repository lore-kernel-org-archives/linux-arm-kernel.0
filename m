From: jenny.tc@intel.com (Jenny Tc)
Date: Thu, 20 Feb 2014 12:00:32 +0530
Subject: [PATCH v3 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <1392627950-26927-15-git-send-email-k.kozlowski@samsung.com>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
 <1392627950-26927-15-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140220063031.GC2498@jenny-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:05:49AM +0100, Krzysztof Kozlowski wrote:
> +static inline int max14577_init_eoc(struct max14577_charger *chg,
> +		unsigned int uamp)
> +{
> +	unsigned int current_bits = 0xf;
> +	u8 reg_data;
> +
> +	switch (chg->maxim_core->dev_type) {
> +	case MAXIM_DEVICE_TYPE_MAX77836:
> +		if (uamp < 5000)
> +			return -EINVAL; /* Requested current is too low */
> +
> +		if (uamp == 7500)
> +			current_bits = 0x0;

if (uamp <= 7500) ?

> +	/* Initialize Overvoltage-Protection Threshold */
> +	switch (chg->pdata->ovp_uvolt) {
> +	case 7500000:
> +		reg_data = 0x0;
> +		break;
> +	case 6000000:
> +	case 6500000:
> +	case 7000000:
> +		reg_data = 0x1 + (chg->pdata->ovp_uvolt - 6000000) / 500000;
> +		break;

Is it battery OVP or charger source OVP? If it's battery OVP, then  minimum
level as 6V seems to be unsafe even for 4.4V batteries.
