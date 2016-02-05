From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 5 Feb 2016 17:19:11 +0000
Subject: [PATCH v3 6/6] arm64: add sysfs cpu_capacity attribute
In-Reply-To: <1454500799-18451-7-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-7-git-send-email-juri.lelli@arm.com>
Message-ID: <56B4D98F.3090103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juri,

On 03/02/16 11:59, Juri Lelli wrote:
> Add a sysfs cpu_capacity attribute with which it is possible to read and
> write (thus over-writing default values) CPUs capacity. This might be
> useful in situation where there is no way to get proper default values
> at boot time.
> 
> The new attribute shows up as:
> 
>  /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Brown <broonie@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index f2513a6..f05cc07 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -40,6 +40,74 @@ bool arch_wants_init_cpu_capacity(void)
>  	return true;
>  }
>  
> +#ifdef CONFIG_PROC_SYSCTL
> +#include <asm/cpu.h>
> +#include <linux/string.h>
> +static ssize_t show_cpu_capacity(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	ssize_t rc;
> +	int cpunum = cpu->dev.id;
> +	unsigned long capacity = arch_scale_cpu_capacity(NULL, cpunum);

Gives me an implicit declaration of function ?arch_scale_cpu_capacity?
error [without the commit fbc899610e1a ("arm64: Update
arch_scale_cpu_capacity() to reflect change to define") on your
git://linux-arm.org/linux-jl.git upstream/default_caps_v3 branch].

Why don't you just return cpu_scale

@@ -49,10 +49,8 @@ static ssize_t show_cpu_capacity(struct device *dev,
 {
        struct cpu *cpu = container_of(dev, struct cpu, dev);
        ssize_t rc;
-       int cpunum = cpu->dev.id;
-       unsigned long capacity = arch_scale_cpu_capacity(NULL, cpunum);

-       rc = sprintf(buf, "%lu\n", capacity);
+       rc = sprintf(buf, "%lu\n", per_cpu(cpu_scale, cpu->dev.id));

        return rc;
 }

to get rid of this dependency?

-- Dietmar

[...]
