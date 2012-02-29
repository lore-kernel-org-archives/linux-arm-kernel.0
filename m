From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Feb 2012 20:14:13 +0000
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
Message-ID: <20120229201413.GA16999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 02:43:44PM +0530, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> sp810 controller can change system's working mode to various power save
> states. Introduce an API to accomplish the same.
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

Please don't indent #defines like this, I find it abhorrent that,@least,
the '#' is not in column 1.

Also, please name these constants SCCTRL_xxx so that the prefix matches
the register which they're related to.

So, I'd much prefer these to be:

#define SCCTRL_MODE_STS_MASK			(0xf << 3)
...

Thanks.
