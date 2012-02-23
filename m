From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:03:44 +0000
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
Message-ID: <20120223100344.GL22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 02:43:44PM +0530, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> sp810 controller can change system's working mode to various power save
> states. Introduce an API to accomplish the same.

Where is the documentation for this peripheral?  I've never seen any
documentation on ARMs website for it.

> 
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/include/asm/hardware/sp810.h |   57 +++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
> index e0d1c0c..df0960a 100644
> --- a/arch/arm/include/asm/hardware/sp810.h
> +++ b/arch/arm/include/asm/hardware/sp810.h
> @@ -14,10 +14,25 @@
>  #ifndef __ASM_ARM_SP810_H
>  #define __ASM_ARM_SP810_H
>  
> +#include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
>  
>  /* sysctl registers offset */
>  #define SCCTRL			0x000
> +	#define SYS_MODE_STS_MASK		(0xF << 3)
> +	#define SYS_MODE_STS_SLEEP		(0x0 << 3)
> +	#define SYS_MODE_STS_DOZE		(0x1 << 3)
> +	#define SYS_MODE_STS_SLOW		(0x2 << 3)
> +	#define SYS_MODE_STS_NORMAL		(0x4 << 3)
> +
> +	#define SYS_MODE_MASK			(0x7 << 0)
> +	#define SYS_MODE_SLEEP			(0x0 << 0)
> +	#define SYS_MODE_DOZE			(0x1 << 0)
> +	#define SYS_MODE_SLOW			(0x2 << 0)
> +	#define SYS_MODE_NORMAL			(0x4 << 0)
> +
>  #define SCSYSSTAT		0x004
>  #define SCIMCTRL		0x008
>  #define SCIMSTAT		0x00C
> @@ -65,4 +80,46 @@ static inline void sysctl_soft_reset(void __iomem *base)
>  	writel(0, base + SCSYSSTAT);
>  }
>  
> +static inline int sysctl_change_mode(void __iomem *base, int mode)
> +{
> +	u32 val, mode_sts;
> +	unsigned long finish;
> +
> +	switch (mode) {
> +	case SYS_MODE_SLEEP:
> +		mode_sts = SYS_MODE_STS_SLEEP;
> +		break;
> +	case SYS_MODE_DOZE:
> +		mode_sts = SYS_MODE_STS_DOZE;
> +		break;
> +	case SYS_MODE_SLOW:
> +		mode_sts = SYS_MODE_STS_SLOW;
> +		break;
> +	case SYS_MODE_NORMAL:
> +		mode_sts = SYS_MODE_STS_NORMAL;
> +		break;
> +	default:
> +		pr_err("Wrong system mode\n");
> +		return -EINVAL;
> +	}
> +
> +	val = readl(base + SCCTRL);
> +	if ((val & SYS_MODE_STS_MASK) == mode_sts)
> +		return 0;
> +
> +	val &= ~SYS_MODE_MASK;
> +	val |= mode;
> +	writel(val, base + SCCTRL);
> +
> +	/* read back if mode is set */
> +	finish = jiffies + 2 * HZ;
> +	do {
> +		val = readl(base + SCCTRL);
> +		if ((val & SYS_MODE_STS_MASK) == mode_sts)
> +			return 0;
> +		udelay(1000);
> +	} while (!time_after_eq(jiffies, finish));
> +
> +	return -EFAULT;
> +}
>  #endif	/* __ASM_ARM_SP810_H */
> -- 
> 1.7.8.110.g4cb5d
> 
