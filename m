From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Dec 2012 11:20:26 -0700
Subject: [PATCH 2/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <1354503607-13707-3-git-send-email-josephl@nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-3-git-send-email-josephl@nvidia.com>
Message-ID: <50BCED6A.7000702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2012 08:00 PM, Joseph Lo wrote:
> Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> functions were used for CPU powered-down state maintenance.

> diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c

> +static bool tegra20_cpu_rail_off_ready(void)

> +	if ((cpu_rst_status & 0x2) != 0x2)
> +		return false;
> +
> +	return true;
> +}

Perhaps simplify that to:

return cpu_rst_status & 2;

or perhaps if that generates an int->bool performance warning:

return !!(cpu_rst_status & 2);

or:

return (cpu_rst_status >> 1) & 1;
