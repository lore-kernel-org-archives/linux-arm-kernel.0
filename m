From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 16 May 2015 16:04:22 +0200
Subject: [PATCH 2/7] rtc: arm: imx: snvs: change use syscon to access
 register
In-Reply-To: <1431696990-23078-3-git-send-email-Frank.Li@freescale.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-3-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150516140422.GL3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/05/2015 at 21:36:25 +0800, Frank.Li at freescale.com wrote :
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs included rtc, on/off key, power-off module
> change to syscon to access register
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/rtc/rtc-snvs.c | 124 +++++++++++++++++++++----------------------------
>  1 file changed, 54 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index 0479e80..4e85fbe 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -18,14 +18,16 @@
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>  #include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  /* These register offsets are relative to LP (Low Power) range */
Shouldn't you remove that comment ?

> -#define SNVS_LPCR		0x04
> -#define SNVS_LPSR		0x18
> -#define SNVS_LPSRTCMR		0x1c
> -#define SNVS_LPSRTCLR		0x20
> -#define SNVS_LPTAR		0x24
> -#define SNVS_LPPGDR		0x30
> +#define SNVS_LPCR		0x38
> +#define SNVS_LPSR		0x4c
> +#define SNVS_LPSRTCMR		0x50
> +#define SNVS_LPSRTCLR		0x54
> +#define SNVS_LPTAR		0x58
> +#define SNVS_LPPGDR		0x64
>  
>  #define SNVS_LPCR_SRTC_ENV	(1 << 0)
>  #define SNVS_LPCR_LPTA_EN	(1 << 1)
> @@ -37,31 +39,35 @@
>  
>  struct snvs_rtc_data {
>  	struct rtc_device *rtc;
> -	void __iomem *ioaddr;
> +	struct regmap *snvs;
>  	int irq;
>  	spinlock_t lock;

This lock can probably be removed, if I'm not mistaken the only use left
is its initialization.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
