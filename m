From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 10:36:32 +0000
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
In-Reply-To: <1386924222-23169-1-git-send-email-vkale@apm.com>
References: <1386924222-23169-1-git-send-email-vkale@apm.com>
Message-ID: <20131213103632.GC19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 08:43:42AM +0000, Vinayak Kale wrote:
> Print the cpu frequency field in /proc/cpuinfo.

Why? ["x86 does this" isn't a valid answer :)].

> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/kernel/setup.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index bd9bbd0..bca982b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/cpufreq.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/elf.h>
> @@ -278,9 +279,19 @@ static const char *hwcap_str[] = {
>  	NULL
>  };
>  
> +static unsigned int get_cpufreq_khz(unsigned int cpu)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	return cpufreq_quick_get(cpu);
> +#else
> +	return 0;
> +#endif
> +}

That's going to be hilarious fun when cpufreq isn't compiled in.
Just use the existing sysfs interfaces exposed by the cpufreq governers if
you need to know this stuff.

Will
