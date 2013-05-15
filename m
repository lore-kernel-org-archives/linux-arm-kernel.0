From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 May 2013 16:48:55 -0600
Subject: [PATCH 2/6] ARM: tegra: skip SCU and PL310 code when CPU is not
 Cortex-A9
In-Reply-To: <1368613644-11863-3-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-3-git-send-email-josephl@nvidia.com>
Message-ID: <519410D7.9060201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 04:27 AM, Joseph Lo wrote:
> For supporting single image on all Tegra series, we need to skip some HW
> support code for Cortex-A9 only.

> diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S

> +	check_cpu_part_num 0xc09, r9, r10
> +	movweq	r4, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
> +	movteq	r4, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
> +	moveq	r5, #0
> +	streq	r5, [r4, #L2X0_CTRL]

Do those conditional instructions need a Thumb iteq wrapped around them
in order to compile in Thumb2 mode? Same comment for the other change,
although IIRC iteq only supports 4 instructions at a time, so maybe a
branch would be better there. Using branches might also reduce the size
of the diff, and make the change more obvious.
