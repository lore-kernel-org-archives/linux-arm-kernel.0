From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 11:10:14 -0600
Subject: [PATCH] arm: tegra: fuse: export chip id and revision
In-Reply-To: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
References: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
Message-ID: <513E0FF6.1050909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 06:37 AM, Danny Huang wrote:
> Expose tegra chip id and revision in /proc/cpu/chipinfo for user mode
> usage.

I agree with Shawn's comments, but I have a few other comments here too
for the record.

Nit: "Tegra" and "ID" above should be capitalized as I've done so in
this sentence.

> diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c

> +static int __init tegra_chip_info(void)
> +{
> +	proc_entry = create_proc_entry("cpu/chipinfo", S_IRUGO, NULL);
> +	if (proc_entry)
> +		proc_entry->read_proc = show_chip_info;
> +	return 0;
> +}
> +
> +late_initcall(tegra_chip_info);

Please don't introduce any more initcalls. Especially initcalls that are
not conditional on the run-time (rather than compile-time) SoC. This
code may be compiled into a kernel that supports SoCs other than Tegra.
However, tegra_chip_info() shouldn't run on those SoCs.

It'd probably be simplest to just perform this initialization as part of
the already-existing tegra_init_fuse(). If not, please call this
initialization function from one of the initialization functions in
arch/arm/mach-tegra/common.c. Both those cases only execute on Tegra.
