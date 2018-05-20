From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 May 2018 15:08:06 +0100
Subject: [PATCH v1 1/5] ARM: trusted_foundations: Implement L2 cache
 initialization callback
In-Reply-To: <20180520101542.12206-2-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
 <20180520101542.12206-2-digetx@gmail.com>
Message-ID: <20180520140805.GL17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 01:15:38PM +0300, Dmitry Osipenko wrote:
> Implement L2 cache initialization firmware callback that should be invoked
> early in boot to enable cache HW.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/firmware/trusted_foundations.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
> index 3fb1b5a1dce9..198ce5c75ca0 100644
> --- a/arch/arm/firmware/trusted_foundations.c
> +++ b/arch/arm/firmware/trusted_foundations.c
> @@ -18,8 +18,13 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <asm/firmware.h>
> +#include <asm/outercache.h>
>  #include <asm/trusted_foundations.h>
>  
> +#define TF_CACHE_MAINT		0xfffff100
> +
> +#define TF_CACHE_INIT		1
> +
>  #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
>  
>  #define TF_CPU_PM		0xfffffffc
> @@ -63,9 +68,27 @@ static int tf_prepare_idle(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_CACHE_L2X0
> +static void tf_cache_write_sec(unsigned long val, unsigned int reg)
> +{
> +	pr_warn("%s: Ignoring write [0x%x]: 0x%08lx\n", __func__, reg, val);

Why at warning level?  Is this some issue that the user needs to be
warned about?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
