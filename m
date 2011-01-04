From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 4 Jan 2011 15:05:29 +0530
Subject: [PATCH v4] davinci: Support various speedgrades for
	MityDSP-L138 and MityARM-1808 SoMs
In-Reply-To: <1294060905-14254-1-git-send-email-michael.williamson@criticallink.com>
References: <1294060905-14254-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024816DB2A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 18:51:45, Michael Williamson wrote:
> For the MityDSP-L138/MityARM-1808 SoMs, the speed grade can be determined
> from the part number string read from the factory configuration block on
> the on-board I2C PROM.  Configure the maximum CPU speed based on this
> information.
> 
> This patch was tested using a MityDSP-L138 and MityARM-1808 at various
> speedgrades.  Also, for code coverage, a bogus configuration was tested
> as well as a configuration having an unknown part number.

Thanks for the extensive testing. This looks good to me, except,
a whitespace nit below. But otherwise:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

> +#ifdef CONFIG_CPU_FREQ
> +static void mityomapl138_cpufreq_init(const char *partnum)
> +{
> +	int i, ret;
> +
> +	for (i = 0; partnum && i < ARRAY_SIZE(mityomapl138_pn_info); i++) {
> +		/*
> +		 * the part number has additional characters beyond what is
> +		 * stored in the table.  This information is not needed for
> +		 * determining the speed grade, and would require several
> +		 * more table entries.  Only check the first N characters
> +		 * for a match.
> +		 */
> +		if (!strncmp(partnum, mityomapl138_pn_info[i].part_no,
> +			strlen(mityomapl138_pn_info[i].part_no))) {
> +			da850_max_speed = mityomapl138_pn_info[i].max_freq;
> +			break;

The indentation here makes it look like strlen is part of if()
body. May be you can indent it substantially to the right. I will
leave it to your judgment.

Thanks,
Sekhar
