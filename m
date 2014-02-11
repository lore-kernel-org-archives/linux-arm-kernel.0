From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 11 Feb 2014 22:18:28 +0100
Subject: [PATCH] ARM: tegra: don't timeout if CPU is powergated
In-Reply-To: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
References: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
Message-ID: <20140211211827.GC1895@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 01:44:13AM +0100, Stefan Agner wrote:
> When booting secondary CPU(s) which are not yet powergated, a wrong
> check lead to a timeout after 100 jiffies. With this patch, we only
> delay powergating if CPUs are still not powered yet.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> I happend to come accross this while working on Colibri T30 support.
> Obviously, the downstream U-Boot doesn't powergate all CPUs, so
> the Linux kernel always timed out when booting CPU 1 through 3...
> 
>  arch/arm/mach-tegra/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index eb72ae7..929d104 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -114,7 +114,7 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  		/* Wait for the power to come up. */
>  		timeout = jiffies + msecs_to_jiffies(100);
> -		while (tegra_pmc_cpu_is_powered(cpu)) {
> +		while (!tegra_pmc_cpu_is_powered(cpu)) {
>  			if (time_after(jiffies, timeout))
>  				return -ETIMEDOUT;
>  			udelay(10);

This is indeed what I'd expect the code to look like. Since the code
enables power to the CPU, the logical thing to do would be to then wait
for it to be powered up.

I don't quite understand when exactly this will fail, since the whole
block above is conditional on !tegra_pmc_cpu_is_powered() condition, so
the only way that this can happen is when the first check fails, then
the CPU is powered on and the PMC recognizes the CPU as powered before
the while (...) is executed.

Thinking about it I've seen an issue on Cardhu where occasionally only
three of the four CPUs actually came up (I've only noticed this since
the DRM panel patches because three penguins looks kind of weird =).
This bug would explain that issue.

Any way, the new code makes much more sense than the old one, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/d690f873/attachment.sig>
