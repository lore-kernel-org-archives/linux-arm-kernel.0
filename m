From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Sep 2011 12:11:30 +0200
Subject: [PATCH 1/2] Adding platform level cpuidle driver for i.MX SoCs.
In-Reply-To: <20110909143339.GD32138@S2100-06.ap.freescale.net>
References: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
	<20110826072704.GB31404@pengutronix.de>
	<20110909143339.GD32138@S2100-06.ap.freescale.net>
Message-ID: <20110912101130.GQ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 10:33:40PM +0800, Shawn Guo wrote:
> On Fri, Aug 26, 2011 at 09:27:04AM +0200, Sascha Hauer wrote:
> > On Thu, Aug 25, 2011 at 09:33:14PM -0500, Robert Lee wrote:
> > > Signed-off-by: Robert Lee <rob.lee@linaro.org>
> > > ---
> > > --- /dev/null
> > > +++ b/arch/arm/plat-mxc/cpuidle.c
> > > @@ -0,0 +1,112 @@
> > > +/*
> > > + * This file is licensed under the terms of the GNU General Public
> > > + * License version 2.  This program is licensed "as is" without any
> > > + * warranty of any kind, whether express or implied.
> > > + */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/cpuidle.h>
> > > +#include <asm/proc-fns.h>
> > > +#include <mach/hardware.h>
> > > +#include <mach/system.h>
> > > +#include <mach/cpuidle.h>
> > > +
> > > +
> > > +#ifndef MXC_OVERRIDE_DEFAULT_CPUIDLE_PARAMS
> > 
> > Either there is a possibility to overwrite the cpuidle parameters
> > or there is none, but we don't need a define for this. I'm not
> > convinced we need this possibility at all though.
> > 
> > > +
> > > +#define MXC_X_MACRO(a, b, c) {c}
> > > +static struct imx_cpuidle_params default_cpuidle_params[] = \
> > > +	MXC_CPUIDLE_TABLE;
> > > +#undef MXC_X_MACRO
> > 
> > Hell! This is one of the worst unnecessary preprocessor abuses I've ever
> > seen. Do not show this in public again.
> > 
> > > +
> > > +static struct imx_cpuidle_params *imx_cpuidle_params = default_cpuidle_params;
> > > +
> > > +#else
> > > +
> > > +static struct imx_cpuidle_params *imx_cpuidle_params;
> > > +
> > > +#endif
> > > +
> > > +
> > > +
> > > +/* in case you want to override the mach level params at the board level */
> > > +void imx_cpuidle_board_params(struct imx_cpuidle_params *cpuidle_params)
> > > +{
> > > +	imx_cpuidle_params = cpuidle_params;
> > > +}
> > > +
> > > +static int imx_enter_idle(struct cpuidle_device *dev,
> > > +			       struct cpuidle_state *state)
> > > +{
> > > +	struct timeval before, after;
> > > +	int idle_time, i;
> > > +
> > > +	/* We only need to pass an index to the mach level so here we
> > > +	 * find the index of the name contained in the cpuidle_state
> > > +	 * to pass. */
> > > +	for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++)
> > 
> > A define for MXC_NUM_CPUIDLE_STATES looks wrong, it is not constant for
> > different SoCs.
> > 
> > > +		if (state == &dev->states[i])
> > > +			break;
> > > +
> > > +	local_irq_disable();
> > > +	local_fiq_disable();
> > > +
> > > +	do_gettimeofday(&before);
> > > +
> > > +	imx_cpu_do_idle(i);
> > 
> > We are currently working on running a single image on as many SoCs we
> > can. Take a step back and imagine what the linker says when it finds
> > 6 different functions named imx_cpu_do_idle()
> > 
> > > +
> > > +	do_gettimeofday(&after);
> > > +
> > > +	local_fiq_enable();
> > > +	local_irq_enable();
> > > +
> > > +	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
> > > +			(after.tv_usec - before.tv_usec);
> > > +
> > > +	return idle_time;
> > > +}
> > > +
> > > +static struct cpuidle_driver imx_cpuidle_driver = {
> > > +	.name =         "imx_idle",
> > > +	.owner =        THIS_MODULE,
> > > +};
> > > +
> > > +static DEFINE_PER_CPU(struct cpuidle_device, imx_cpuidle_device);
> > > +
> > > +static int __init imx_cpuidle_init(void)
> > > +{
> > > +	struct cpuidle_device *device;
> > > +	int i;
> > > +
> > > +	#define MXC_X_MACRO(a, b, c) #a
> > > +	char *mxc_cpuidle_state_name[] = MXC_CPUIDLE_TABLE;
> > > +	#undef MXC_X_MACRO
> > > +
> > > +	#define MXC_X_MACRO(a, b, c) b
> > > +	char *mxc_cpuidle_state_desc[] = MXC_CPUIDLE_TABLE;
> > > +	#undef MXC_X_MACRO
> > > +
> > > +	if (imx_cpuidle_params == NULL)
> > > +		return -ENODEV;
> > > +
> > > +	cpuidle_register_driver(&imx_cpuidle_driver);
> > > +
> > > +	device = &per_cpu(imx_cpuidle_device, smp_processor_id());
> > > +	device->state_count = MXC_NUM_CPUIDLE_STATES;
> > > +
> > > +	for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++) {
> > > +		device->states[i].enter = imx_enter_idle;
> > > +		device->states[i].exit_latency = imx_cpuidle_params[i].latency;
> > > +		device->states[i].flags = CPUIDLE_FLAG_TIME_VALID;
> > > +		strcpy(device->states[i].name, mxc_cpuidle_state_name[i]);
> > > +		strcpy(device->states[i].desc, mxc_cpuidle_state_desc[i]);
> > > +	}
> > > +
> > > +	if (cpuidle_register_device(device)) {
> > > +		printk(KERN_ERR "imx_cpuidle_init: Failed registering\n");
> > > +		return -ENODEV;
> > > +	}
> > > +	return 0;
> > 
> > This should really be a platform driver.
> > 
> I do not understand the reason behind this comment.  The cpuidle is
> not really a platform device which typically has IO and IRQ such
> hardware resources requiring a platform driver to talk to.
> 
> Looking at the following cpuidle drivers, only davinci implemented it
> as a platform driver.
> 
>     arch/arm/mach-at91/cpuidle.c
>     arch/arm/mach-davinci/cpuidle.c
>     arch/arm/mach-exynos4/cpuidle.c
>     arch/arm/mach-kirkwood/cpuidle.c
>     arch/arm/mach-omap2/cpuidle34xx.c
>     arch/arm/mach-shmobile/cpuidle.c
> 
> Also, I'm seeing imx cpufreq sitting on the mainline is not a platform
> driver either.  I really did not think of any good reason for cpuidle
> to be a platform driver necessarily.

The reason may not be really of technical nature. A platform driver only
changes the thinking:

- A driver makes sure that the author knows that the hardware may or may
  not be present.
- A driver makes sure that it may run on different types of hardware if
  passed different platform specific data.
- A driver motivates the author to view the code as a single seperated
  topic and to put all related code into the driver.

In the 'real' device driver world all points above are clear to driver
authors, but when it comes to SoC internal stuff people tend to forget
this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
