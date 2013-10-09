From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 17:20:45 -0600
Subject: [PATCH 4/7] ARM: tegra: add LP1 support code for Tegra124
In-Reply-To: <1381310411-11391-5-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-5-git-send-email-josephl@nvidia.com>
Message-ID: <5255E4CD.1050509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 03:20 AM, Joseph Lo wrote:
> The LP1 suspend procedure is the same with Tegra30 and Tegra114. Just
> need to update the difference of the register address, then we can
> continue to share the code.

> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S

>  tegra114_sdram_pad_size:
> -	.word	tegra30_sdram_pad_size - tegra114_sdram_pad_address
> +	.word	tegra124_sdram_pad_address - tegra114_sdram_pad_address

Why not put label tegra30_sdram_pad_address_end after the Tegra30 table
and tegra114_sdram_pad_address_end after the Tegra114 table, etc. That
way, you won't have to modify previous chips when you add a new one.

>  	.type	tegra30_sdram_pad_save, %object
>  tegra30_sdram_pad_save:

Shouldn't that name be tegra_xxx not tegra30_xxx, since I think the same
register save area is used for all SoCs?

> -	.rept (tegra30_sdram_pad_size - tegra114_sdram_pad_address) / 4
> +	.rept (tegra124_sdram_pad_address - tegra114_sdram_pad_address) / 4

I assume this is intended to reserve enough space to store all the saved
registers for the largest table of tegra30_sdram_pad_address,
tegra114_sdram_pad_address, tegra124_sdram_pad_address. I count more
entries in the existing Tegra114 table than the new Tegra124 table, so
I'm not sure this part of the change is correct.

Is there no way to do a max(tegra30 size, tegra114 size, tegra124 size)
so you don't have to pick manually which size to reserve here?
