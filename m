From: rob.lee@linaro.org (Rob Lee)
Date: Fri, 26 Aug 2011 09:56:31 -0500
Subject: [PATCH 1/2] Adding platform level cpuidle driver for i.MX SoCs.
In-Reply-To: <20110826072704.GB31404@pengutronix.de>
References: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
	<20110826072704.GB31404@pengutronix.de>
Message-ID: <CAMXH7KH=1D7UhHoEdOcgZ9kXvneWrk04dTRuU-d2X-mXCHqUJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha and all,

Just FYI, this is my first submission to the community so I'm sure that I
have much to learn about community style beyond what is given in
the CodingStyle and Submit* documents.  Please give
"community newbie" level details in your feedback.

My comments are below.

On 26 August 2011 02:27, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Thu, Aug 25, 2011 at 09:33:14PM -0500, Robert Lee wrote:
> > Signed-off-by: Robert Lee <rob.lee@linaro.org>
> > ---
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/cpuidle.c
> > @@ -0,0 +1,112 @@
> > +/*
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. ?This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/cpuidle.h>
> > +#include <asm/proc-fns.h>
> > +#include <mach/hardware.h>
> > +#include <mach/system.h>
> > +#include <mach/cpuidle.h>
> > +
> > +
> > +#ifndef MXC_OVERRIDE_DEFAULT_CPUIDLE_PARAMS
>
> Either there is a possibility to overwrite the cpuidle parameters
> or there is none, but we don't need a define for this. I'm not
> convinced we need this possibility at all though.
>

This was simply to avoid the unnecessary memory usage by creating
the default values if someone decided to override the default cpuidle
parameters for their build.

> > +
> > +#define MXC_X_MACRO(a, b, c) {c}
> > +static struct imx_cpuidle_params default_cpuidle_params[] = \
> > + ? ? MXC_CPUIDLE_TABLE;
> > +#undef MXC_X_MACRO
>
> Hell! This is one of the worst unnecessary preprocessor abuses I've ever
> seen. Do not show this in public again.
>

Based on your response, it appears that standard C X-macros are not Linux
kernel community friendly.

> > +
> > +static struct imx_cpuidle_params *imx_cpuidle_params = default_cpuidle_params;
> > +
> > +#else
> > +
> > +static struct imx_cpuidle_params *imx_cpuidle_params;
> > +
> > +#endif
> > +
> > +
> > +
> > +/* in case you want to override the mach level params at the board level */
> > +void imx_cpuidle_board_params(struct imx_cpuidle_params *cpuidle_params)
> > +{
> > + ? ? imx_cpuidle_params = cpuidle_params;
> > +}
> > +
> > +static int imx_enter_idle(struct cpuidle_device *dev,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_state *state)
> > +{
> > + ? ? struct timeval before, after;
> > + ? ? int idle_time, i;
> > +
> > + ? ? /* We only need to pass an index to the mach level so here we
> > + ? ? ?* find the index of the name contained in the cpuidle_state
> > + ? ? ?* to pass. */
> > + ? ? for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++)
>
> A define for MXC_NUM_CPUIDLE_STATES looks wrong, it is not constant for
> different SoCs.
>

The CPUIDLE states will be constant among a family of SoCs such as mach-mx5, but
the way I've written the driver, I've assumed a mach level defines a
family which now
that I think about it, obviously isn't the case for mach-imx.

If you have time, please give your thoughts on the organization of the mach
directories with regards to mach-imx and mach-mx5 keeping in mind that
i.MX6 will be coming soon.  This will help me in trying to make this driver
more acceptable and I can pass this info on to others to discuss and learn
from as well.

> > + ? ? ? ? ? ? if (state == &dev->states[i])
> > + ? ? ? ? ? ? ? ? ? ? break;
> > +
> > + ? ? local_irq_disable();
> > + ? ? local_fiq_disable();
> > +
> > + ? ? do_gettimeofday(&before);
> > +
> > + ? ? imx_cpu_do_idle(i);
>
> We are currently working on running a single image on as many SoCs we
> can. Take a step back and imagine what the linker says when it finds
> 6 different functions named imx_cpu_do_idle()
>

Understood.  The thought was that the imx_cpu_do_idle() would live in the
mach level system.c file which could then make necessary SoC family
specific calls as needed.  The imx_cpu_do_idle() added to system.c
in the second patch is an example, but in that case it was unnecessary
to make SoC specific calls.

> > +
> > + ? ? do_gettimeofday(&after);
> > +
> > + ? ? local_fiq_enable();
> > + ? ? local_irq_enable();
> > +
> > + ? ? idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
> > + ? ? ? ? ? ? ? ? ? ? (after.tv_usec - before.tv_usec);
> > +
> > + ? ? return idle_time;
> > +}
> > +
> > +static struct cpuidle_driver imx_cpuidle_driver = {
> > + ? ? .name = ? ? ? ? "imx_idle",
> > + ? ? .owner = ? ? ? ?THIS_MODULE,
> > +};
> > +
> > +static DEFINE_PER_CPU(struct cpuidle_device, imx_cpuidle_device);
> > +
> > +static int __init imx_cpuidle_init(void)
> > +{
> > + ? ? struct cpuidle_device *device;
> > + ? ? int i;
> > +
> > + ? ? #define MXC_X_MACRO(a, b, c) #a
> > + ? ? char *mxc_cpuidle_state_name[] = MXC_CPUIDLE_TABLE;
> > + ? ? #undef MXC_X_MACRO
> > +
> > + ? ? #define MXC_X_MACRO(a, b, c) b
> > + ? ? char *mxc_cpuidle_state_desc[] = MXC_CPUIDLE_TABLE;
> > + ? ? #undef MXC_X_MACRO
> > +
> > + ? ? if (imx_cpuidle_params == NULL)
> > + ? ? ? ? ? ? return -ENODEV;
> > +
> > + ? ? cpuidle_register_driver(&imx_cpuidle_driver);
> > +
> > + ? ? device = &per_cpu(imx_cpuidle_device, smp_processor_id());
> > + ? ? device->state_count = MXC_NUM_CPUIDLE_STATES;
> > +
> > + ? ? for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++) {
> > + ? ? ? ? ? ? device->states[i].enter = imx_enter_idle;
> > + ? ? ? ? ? ? device->states[i].exit_latency = imx_cpuidle_params[i].latency;
> > + ? ? ? ? ? ? device->states[i].flags = CPUIDLE_FLAG_TIME_VALID;
> > + ? ? ? ? ? ? strcpy(device->states[i].name, mxc_cpuidle_state_name[i]);
> > + ? ? ? ? ? ? strcpy(device->states[i].desc, mxc_cpuidle_state_desc[i]);
> > + ? ? }

Upon looking at my code again, I want to change these strcpy's to a more
buffer overrun friendly copy.

> > +
> > + ? ? if (cpuidle_register_device(device)) {
> > + ? ? ? ? ? ? printk(KERN_ERR "imx_cpuidle_init: Failed registering\n");
> > + ? ? ? ? ? ? return -ENODEV;
> > + ? ? }
> > + ? ? return 0;
>
> This should really be a platform driver.
>
>
> I'm glad I'm on holiday for the next two weeks.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
