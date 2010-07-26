From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Jul 2010 15:33:01 +0900
Subject: [PATCH v3 4/8] ARM: Samsung: Add common Aquila and GONI code
In-Reply-To: <1279902083-21250-5-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
	<1279902083-21250-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <00b701cb2c8c$6c932fa0$45b98ee0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
Hi Sylwester,

Hmm...no comments here?

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

I wonder we need really above multiple sign for this, just only one c file?

> ---
>  arch/arm/mach-s5pv210/Kconfig              |    5 ++++
>  arch/arm/mach-s5pv210/Makefile             |    2 +
>  arch/arm/mach-s5pv210/common-aquila-goni.c |   35
> ++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/common-aquila-goni.h |    2 +
>  4 files changed, 44 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/common-aquila-goni.c
>  create mode 100644 arch/arm/mach-s5pv210/common-aquila-goni.h
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 12a2c6b..039ba8c 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -90,6 +90,11 @@ config MACH_SMDKC110
> 
>  endmenu
> 
> +config COMMON_AQUILA_GONI

do we _really_ need this?

> +	bool
> +	help
> +	  Compile common code for Samsung Aquila and Samsung GONI
> machines
> +
>  config S5PC110_DEV_ONENAND
>  	bool
>  	help
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index 05048c5..a4c0bc9 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -22,6 +22,8 @@ obj-$(CONFIG_MACH_SMDKV210)	+= mach-
> smdkv210.o
>  obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
>  obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
> 
> +obj-$(CONFIG_COMMON_AQUILA_GONI)	+= common-aquila-goni.o
> +
>  # device support
> 
>  obj-y				+= dev-audio.o
> diff --git a/arch/arm/mach-s5pv210/common-aquila-goni.c b/arch/arm/mach-
> s5pv210/common-aquila-goni.c
> new file mode 100644
> index 0000000..4d72531
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/common-aquila-goni.c

Just setup-fimc.c is enough...
I don't know why we need common-aquila-goni now.

And your following patches in this patch-set perfectly same except just
name.
[PATCH v3 5/8] ARM: s5pv210: enable FIMC on Aquila
[PATCH v3 6/8] ARM: s5pv210: enable FIMC on Goni

Hmm...

> @@ -0,0 +1,35 @@
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <plat/fimc.h>
> +
> +#include "common-aquila-goni.h"
> +
> +void __init s5pv210_common_fimc_clk_init(void)
> +{
> +	int i;
> +	struct clk *clk_fimc, *parent;
> +
> +	struct device *fimc_devs[] = {
> +		&s5p_device_fimc0.dev,
> +		&s5p_device_fimc1.dev,
> +		&s5p_device_fimc2.dev
> +	};
> +
> +	parent = clk_get(NULL, "mout_epll");
> +	if (IS_ERR(parent))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(fimc_devs); i++) {
> +		if (fimc_devs[i]) {
> +			clk_fimc = clk_get(fimc_devs[i], "sclk_fimc");
> +
> +			if (IS_ERR(clk_fimc))
> +				continue;
> +
> +			clk_set_parent(clk_fimc, parent);
> +			clk_set_rate(clk_fimc, 133000000);

Is this for direct fifo mode?

> +			clk_enable(clk_fimc);
> +		}
> +	}
> +	clk_put(parent);
> +}
> diff --git a/arch/arm/mach-s5pv210/common-aquila-goni.h b/arch/arm/mach-
> s5pv210/common-aquila-goni.h
> new file mode 100644
> index 0000000..f666462
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/common-aquila-goni.h
> @@ -0,0 +1,2 @@
> +
> +extern void s5pv210_common_fimc_clk_init(void);
> --

I do not think that we need common-aquila-goni.[ch] now to us.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
