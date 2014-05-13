From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 May 2014 09:28:55 +0100
Subject: [PATCH v6 06/15] ARM: hisi: enable MCPM implementation
In-Reply-To: <1399795571-17231-7-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140513082527.GA3696@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 04:06:02PM +0800, Haojian Zhuang wrote:
> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
> framework to manage power on HiP04 SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/mach-hisi/Makefile   |   1 +
>  arch/arm/mach-hisi/platmcpm.c | 309 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 310 insertions(+)
>  create mode 100644 arch/arm/mach-hisi/platmcpm.c
> 
> diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
> index 2ae1b59..e7a8640 100644
> --- a/arch/arm/mach-hisi/Makefile
> +++ b/arch/arm/mach-hisi/Makefile
> @@ -3,4 +3,5 @@
>  #
>  
>  obj-y	+= hisilicon.o
> +obj-$(CONFIG_MCPM)		+= platmcpm.o
>  obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> new file mode 100644
> index 0000000..6208bc6
> --- /dev/null
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -0,0 +1,309 @@

[...]

> +static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	unsigned long data, mask;
> +
> +	if (!relocation || !sysctrl)
> +		return -ENODEV;
> +	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
> +		return -EINVAL;
> +
> +	spin_lock_irq(&boot_lock);
> +	writel_relaxed(hip04_boot.bootwrapper_phys, relocation);
> +	writel_relaxed(hip04_boot.bootwrapper_magic, relocation + 4);
> +	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
> +	writel_relaxed(0, relocation + 12);
> +
> +	if (hip04_cluster_down(cluster)) {
> +		data = CLUSTER_DEBUG_RESET_BIT;
> +		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
> +		do {
> +			mask = CLUSTER_DEBUG_RESET_STATUS;
> +			data = readl_relaxed(sysctrl + \
> +					     SC_CPU_RESET_STATUS(cluster));
> +		} while (data & mask);
> +		hip04_set_snoop_filter(cluster, 1);

Did you find the answer regarding whether it's safe to enable snoops to
a powered-down CPU?

Does HiP04 use CCI, or some different interconnect?  As Nico pointed out,
the above code would definitely not be safe for CCI.

[...]

Cheers
---Dave
