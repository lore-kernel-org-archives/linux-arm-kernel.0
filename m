From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 20 May 2016 13:37:52 -0700
Subject: [PATCH] soc: Move brcmstb to bcm/brcmstb
In-Reply-To: <1463769495-10072-1-git-send-email-f.fainelli@gmail.com>
References: <1463769495-10072-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <573F75A0.5090206@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Looks good.

On 16-05-20 11:38 AM, Florian Fainelli wrote:
> Unify the different Broadcom SoCs directory and have everybody live
> under drivers/soc/bcm/*.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/soc/Kconfig                     |  1 -
>   drivers/soc/Makefile                    |  1 -
>   drivers/soc/bcm/Kconfig                 | 15 +++++++++++++++
>   drivers/soc/bcm/Makefile                |  1 +
>   drivers/soc/{ => bcm}/brcmstb/Makefile  |  0
>   drivers/soc/{ => bcm}/brcmstb/biuctrl.c |  0
>   drivers/soc/{ => bcm}/brcmstb/common.c  |  0
>   drivers/soc/brcmstb/Kconfig             | 10 ----------
>   8 files changed, 16 insertions(+), 12 deletions(-)
>   rename drivers/soc/{ => bcm}/brcmstb/Makefile (100%)
>   rename drivers/soc/{ => bcm}/brcmstb/biuctrl.c (100%)
>   rename drivers/soc/{ => bcm}/brcmstb/common.c (100%)
>   delete mode 100644 drivers/soc/brcmstb/Kconfig
>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index cb58ef0d9b2c..91d5c05d395f 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -1,7 +1,6 @@
>   menu "SOC (System On Chip) specific Drivers"
>
>   source "drivers/soc/bcm/Kconfig"
> -source "drivers/soc/brcmstb/Kconfig"
>   source "drivers/soc/fsl/qe/Kconfig"
>   source "drivers/soc/mediatek/Kconfig"
>   source "drivers/soc/qcom/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 380230f03874..b75e3bd0a01e 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,7 +3,6 @@
>   #
>
>   obj-y				+= bcm/
> -obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
>   obj-$(CONFIG_ARCH_DOVE)		+= dove/
>   obj-$(CONFIG_MACH_DOVE)		+= dove/
>   obj-y				+= fsl/
> diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
> index 3066edea184d..97156aeed286 100644
> --- a/drivers/soc/bcm/Kconfig
> +++ b/drivers/soc/bcm/Kconfig
> @@ -1,3 +1,5 @@
> +menu "Broadcom SoC drivers"
> +
>   config RASPBERRYPI_POWER
>   	bool "Raspberry Pi power domain driver"
>   	depends on ARCH_BCM2835 || COMPILE_TEST
> @@ -7,3 +9,16 @@ config RASPBERRYPI_POWER
>   	help
>   	  This enables support for the RPi power domains which can be enabled
>   	  or disabled via the RPi firmware.
> +
> +config SOC_BRCMSTB
> +	bool "Broadcom STB SoC drivers"
> +	depends on ARM
> +	select SOC_BUS
> +	help
> +	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
> +	  This option alone enables only some support code, while the drivers
> +	  can be enabled individually within this menu.
> +
> +	  If unsure, say N.
> +
> +endmenu
> diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
> index 63aa3eb23087..dc4fced72d21 100644
> --- a/drivers/soc/bcm/Makefile
> +++ b/drivers/soc/bcm/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_RASPBERRYPI_POWER)	+= raspberrypi-power.o
> +obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
> diff --git a/drivers/soc/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
> similarity index 100%
> rename from drivers/soc/brcmstb/Makefile
> rename to drivers/soc/bcm/brcmstb/Makefile
> diff --git a/drivers/soc/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
> similarity index 100%
> rename from drivers/soc/brcmstb/biuctrl.c
> rename to drivers/soc/bcm/brcmstb/biuctrl.c
> diff --git a/drivers/soc/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> similarity index 100%
> rename from drivers/soc/brcmstb/common.c
> rename to drivers/soc/bcm/brcmstb/common.c
> diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
> deleted file mode 100644
> index 7fec3b4c80a1..000000000000
> --- a/drivers/soc/brcmstb/Kconfig
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -menuconfig SOC_BRCMSTB
> -	bool "Broadcom STB SoC drivers"
> -	depends on ARM
> -	select SOC_BUS
> -	help
> -	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
> -	  This option alone enables only some support code, while the drivers
> -	  can be enabled individually within this menu.
> -
> -	  If unsure, say N.
>
