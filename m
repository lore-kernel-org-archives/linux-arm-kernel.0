From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Apr 2012 19:42:13 +0200
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <CAMXH7KH41kWMPu_dEpetZc8OUD3C0-mtxGbXX0Vqd4EODPWJUg@mail.gmail.com>
References: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
 <1334620214-25803-2-git-send-email-rob.lee@linaro.org>
 <20120417074301.GM20478@pengutronix.de>
 <CAMXH7KH41kWMPu_dEpetZc8OUD3C0-mtxGbXX0Vqd4EODPWJUg@mail.gmail.com>
Message-ID: <20120417174213.GD3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 08:54:03AM -0500, Rob Lee wrote:
> On Tue, Apr 17, 2012 at 2:43 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Mon, Apr 16, 2012 at 06:50:12PM -0500, Robert Lee wrote:
> >> Add common cpuidle init functionality that can be used by various
> >> imx platforms.
> >>
> >> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> >> ---
> >> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> >> index e81290c..7c9e05f 100644
> >> --- a/arch/arm/plat-mxc/Makefile
> >> +++ b/arch/arm/plat-mxc/Makefile
> >> @@ -16,6 +16,8 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
> >> ?obj-$(CONFIG_MXC_USE_EPIT) += epit.o
> >> ?obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> >> ?obj-$(CONFIG_CPU_FREQ_IMX) ? ?+= cpufreq.o
> >> +obj-$(CONFIG_CPU_IDLE) ? ?+= cpuidle.o
> >> +
> >> ?ifdef CONFIG_SND_IMX_SOC
> >> ?obj-y += ssi-fiq.o
> >> ?obj-y += ssi-fiq-ksym.o
> >> diff --git a/arch/arm/plat-mxc/cpuidle.c b/arch/arm/plat-mxc/cpuidle.c
> >> new file mode 100644
> >> index 0000000..d1c9301
> >> --- /dev/null
> >> +++ b/arch/arm/plat-mxc/cpuidle.c
> >> @@ -0,0 +1,89 @@
> >> +/*
> >> + * Copyright 2012 Freescale Semiconductor, Inc.
> >> + * Copyright 2012 Linaro Ltd.
> >> + *
> >> + * The code contained herein is licensed under the GNU General Public
> >> + * License. You may obtain a copy of the GNU General Public License
> >> + * Version 2 or later at the following locations:
> >> + *
> >> + * http://www.opensource.org/licenses/gpl-license.html
> >> + * http://www.gnu.org/copyleft/gpl.html
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/io.h>
> >> +#include <linux/cpuidle.h>
> >> +#include <linux/hrtimer.h>
> >> +#include <linux/err.h>
> >> +#include <linux/slab.h>
> >> +
> >> +static struct cpuidle_device __percpu * imx_cpuidle_devices;
> >> +static struct cpuidle_driver *drv;
> >> +
> >> +void __init imx_cpuidle_set_driver(struct cpuidle_driver *p)
> >> +{
> >> + ? ? drv = p;
> >> +}
> >
> > You like it complicated, eh? Why do you introduce a function which sets
> > a variable...
> >
> 
> This complication is used to deal with the timing of various levels of
> init calls.  More explanation below.
> 
> >> +
> >> +void imx_cpuidle_devices_uninit(void)
> >> +{
> >> + ? ? int cpu_id;
> >> + ? ? struct cpuidle_device *dev;
> >> +
> >> + ? ? for_each_possible_cpu(cpu_id) {
> >> + ? ? ? ? ? ? dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
> >> + ? ? ? ? ? ? cpuidle_unregister_device(dev);
> >> + ? ? }
> >> +
> >> + ? ? free_percpu(imx_cpuidle_devices);
> >> +}
> >> +
> >> +static int __init imx_cpuidle_init(void)
> >
> > ... instead of passing it directly to the function which uses it?
> >
> 
> If I called imx_cpuidle_init directly from imx5 or imx6q init
> routines, it would be getting called before the coreinit_call of core
> cpuidle causing a failure.  There were various other directions to
> take and all seemed less desirable than this one.
> 
> One alternative would be to add a function to return the pointer to
> the cpuidle driver object based on the machine type.  Functionality
> exists to identify imx5 as a machine type but not imx6q, so I couldn't
> use that machine based method without adding that extra code.
> 
> Another alternative would be to add a general platform lateinit_call
> function to each platforms that support cpuidle.

Just put the initcall into mm-imx5.c and check the cpu type. Then you
also don't have to make imx5_idle global.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
