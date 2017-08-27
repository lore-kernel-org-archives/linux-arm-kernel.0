From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Aug 2017 04:05:01 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170827003328.28370-3-afaerber@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
Message-ID: <20170827020501.GB13622@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

n Sun, Aug 27, 2017 at 02:33:27AM +0200, Andreas F?rber wrote:
> Based on QNAP's arch/arm/mach-rtk119x/driver/rtk_rtc_drv.c code and
> mach-rtk119x/driver/dc2vo/fpga/include/mis_reg.h register definitions.
> 
> The base year 2014 was observed on all of Zidoo X9S, ProBox2 Ava and
> Beelink Lake I.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Dropped open/release in favor of probe/remove (Alexandre)
>  * read_time: Reordered register accesses (Alexandre)
>  * read_time/set_time: Refactored day calculations to avoid time64_t (Alexandre)
>  * read_time: Retry if seconds change (Alexandre)
>  * probe: Added missing RTCACR initialization code
>  * set_time: Fixed year check (off by 1900)
>  * set_time: Fixed new seconds (off by factor two)
>  * Cleaned up debug output (Andrew)
>  * Added spinlocks around register accesses
>  * Added masks for register fields
>  
>  drivers/rtc/Kconfig       |   8 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-rtd119x.c | 254 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rtd119x.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 22efa21b1d81..d5a46f311ecb 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1765,6 +1765,14 @@ config RTC_DRV_CPCAP
>  	   Say y here for CPCAP rtc found on some Motorola phones
>  	   and tablets such as Droid 4.
>  
> +config RTC_DRV_RTD119X
> +	bool "Realtek RTD129x RTC"
> +	depends on ARCH_REALTEK || COMPILE_TEST
> +	default ARCH_REALTEK
> +	help
> +	  If you say yes here, you get support for the RTD1295 SoC
> +	  Real Time Clock.
> +
>  comment "HID Sensor RTC drivers"
>  
>  config RTC_DRV_HID_SENSOR_TIME
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index acd366b41c85..55a0a5ca45b0 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -131,6 +131,7 @@ obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
>  obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
>  obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
>  obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
> +obj-$(CONFIG_RTC_DRV_RTD119X)	+= rtc-rtd119x.o
>  obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
>  obj-$(CONFIG_RTC_DRV_RV8803)	+= rtc-rv8803.o
>  obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
> diff --git a/drivers/rtc/rtc-rtd119x.c b/drivers/rtc/rtc-rtd119x.c
> new file mode 100644
> index 000000000000..27fa68a5af30
> --- /dev/null
> +++ b/drivers/rtc/rtc-rtd119x.c
> @@ -0,0 +1,254 @@
> +/*
> + * Realtek RTD129x RTC
> + *
> + * Copyright (c) 2017 Andreas F?rber
> + *
> + * SPDX-License-Identifier: GPL-2.0+
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/spinlock.h>
> +
> +#define RTD_RTCSEC		0x00
> +#define RTD_RTCMIN		0x04
> +#define RTD_RTCHR		0x08
> +#define RTD_RTCDATE1		0x0c
> +#define RTD_RTCDATE2		0x10
> +#define RTD_RTCACR		0x28
> +#define RTD_RTCEN		0x2c
> +#define RTD_RTCCR		0x30
> +
> +#define RTD_RTCSEC_RTCSEC_MASK		0x7f
> +
> +#define RTD_RTCMIN_RTCMIN_MASK		0x3f
> +
> +#define RTD_RTCHR_RTCHR_MASK		0x1f
> +
> +#define RTD_RTCDATE1_RTCDATE1_MASK	0xff
> +
> +#define RTD_RTCDATE2_RTCDATE2_MASK	0x7f
> +
> +#define RTD_RTCACR_RTCPWR		BIT(7)
> +
> +#define RTD_RTCEN_RTCEN_MASK		0xff
> +
> +#define RTD_RTCCR_RTCRST		BIT(6)
> +
> +struct rtd119x_rtc {
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct rtc_device *rtcdev;
> +	unsigned base_year;
> +	spinlock_t lock;

Where is this lock initialised? I would expect a call to
spin_lock_init() somewhere.

I also wonder what this lock is protecting, which rtc->ops_lock does
not protect?

    Andrew
