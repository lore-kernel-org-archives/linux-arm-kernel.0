From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 23 Sep 2013 14:37:22 +0200
Subject: [PATCH] DT: if dt is available don't use s3c_arch_init
In-Reply-To: <1379931289-29384-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379931289-29384-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <2025079.MVbFYJdokX@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Monday 23 of September 2013 12:14:49 Mateusz Krawczuk wrote:
> It prevents from executing platform code, when booting from device tree.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
> index aa9511b..0ace02d 100644
> --- a/arch/arm/plat-samsung/init.c
> +++ b/arch/arm/plat-samsung/init.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
> +#include <linux/of.h>
>  #include <linux/serial_core.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> @@ -152,6 +153,8 @@ static int __init s3c_arch_init(void)
>  {
>  	int ret;
> 
> +	if (of_have_populated_dt())
> +		return 0;

I'm not sure if this is the correct thing to do here (note platforms that 
still want this initialization to be handled, even when booting with DT).

The DT case is already handled several lines below in if (cpu == NULL) 
check and if your platform requires this initialization not to happen you 
should assure it has cpu == NULL.

Best regards,
Tomasz
