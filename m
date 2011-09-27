From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 27 Sep 2011 18:03:13 -0400
Subject: [PATCH] dma/imx-sdma+imx-dma: explicitly #include <linux/module.h>
In-Reply-To: <1317018379-8897-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1317018379-8897-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4E824821.8040105@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-26 02:26 AM, Uwe Kleine-K?nig wrote:
> This is needed after commit
> 
> 	include: replace linux/module.h with "struct module" wherever possible
> 
> (currently 25215aa in next).
> 
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> maybe it's sensible for Paul to take that before his commit?

Thanks, I'll blend it into the commit adding module.h to the other
drivers/dma files.  It seems the imx boards don't have a defconfig
in the arch/arm/configs that enables this (CONFIG_IMX_[S]DMA).

What is really interesting (at least to me anyway) is that I
didn't get one iMX build in some 6000+ ARM randconfig builds....

I would have thought it would have showed up at least a couple
times, given that number of builds.  Maybe randconfig doesn't
deal so well with "choice" Kconfig items?

~/git/module.h/linux-2.6.git$ ls -1 ../build-10*arm |wc -l
6399
~/git/module.h/linux-2.6.git$ grep CONFIG_ARCH_[A-Z0-9]*=y ../build-10*arm*/.config | sed 's/.*CON/CON/'|sort |uniq
CONFIG_ARCH_EBSA110=y
CONFIG_ARCH_H7201=y
CONFIG_ARCH_H7202=y
CONFIG_ARCH_H720X=y
CONFIG_ARCH_VERSATILE=y
~/git/module.h/linux-2.6.git$ 

No ARCH_MXC, no ARCH_MXS, PXA, or any of the other 20+ variants.
Definitely not a random spread there, with all 6000 builds falling
in just 5 buckets.

Paul.


> 
> Best regards
> Uwe
> 
>  drivers/dma/imx-dma.c  |    1 +
>  drivers/dma/imx-sdma.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index d99f71c..3732de8 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/dmaengine.h>
> +#include <linux/module.h>
>  
>  #include <asm/irq.h>
>  #include <mach/dma-v1.h>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index b5cc27d..86fb6e5 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -34,6 +34,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/module.h>
>  
>  #include <asm/irq.h>
>  #include <mach/sdma.h>
