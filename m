From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Dec 2010 23:39:42 +0000
Subject: [PATCH 20/21] ARM: tegra: Allow overriding arch_reset
In-Reply-To: <1291590548-7341-21-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
	<1291590548-7341-21-git-send-email-ccross@android.com>
Message-ID: <20101205233942.GB22824@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 05, 2010 at 03:09:07PM -0800, Colin Cross wrote:
> diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
> index 84d5d46..70c95ac 100644
> --- a/arch/arm/mach-tegra/include/mach/system.h
> +++ b/arch/arm/mach-tegra/include/mach/system.h
> @@ -24,16 +24,30 @@
>  #include <mach/hardware.h>
>  #include <mach/iomap.h>
>  
> +extern void (*tegra_reset)(char mode, const char *cmd);
> +
>  static inline void arch_idle(void)
>  {
>  }
>  
> -static inline void arch_reset(char mode, const char *cmd)
> +static inline void tegra_assert_system_reset(void)
>  {
>  	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
> -	u32 reg = readl(reset);
> +	u32 reg;
> +
> +	reg = readl(reset);
>  	reg |= 0x04;
>  	writel(reg, reset);
>  }
>  
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	if (tegra_reset)
> +		tegra_reset(mode, cmd);
> +	else
> +		tegra_assert_system_reset();
> +
> +	do { } while (1);
> +}
> +

How about:

extern void (*arch_reset)(char mode, const char *cmd);

and then in a tegra private .c file:

static void tegra_assert_system_reset(char mode, const char *cmd)
{
...
}

void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
