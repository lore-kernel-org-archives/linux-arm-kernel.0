From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 09:51:14 +0000
Subject: [PATCH v3 4/6] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <1351178560-19188-5-git-send-email-t.figa@samsung.com>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <1351178560-19188-5-git-send-email-t.figa@samsung.com>
Message-ID: <20121112095114.GD28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 05:22:38PM +0200, Tomasz Figa wrote:
> +static int exynos_do_idle(void)
> +{
> +        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
> +        return 0;
> +}

This looks fine as an API - it has a defined purpose.

> +
> +static int exynos_cpu_boot(int cpu)
> +{
> +	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> +	return 0;
> +}

Same for this (though, what _exactly_ is 'cpu', is it the physical CPU
number or the logical CPU number?)

> +
> +static int exynos_cpu_boot_reg(int cpu, void __iomem **ptr)
> +{
> +	*ptr = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> +	return 0;
> +}

This is really bad.  What's it trying to do?  What is the significance
of the 'ptr' returned?  What if a platform doesn't have a boot register?
