From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Mar 2012 09:21:31 +0100
Subject: [PATCH v4 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <20120316080025.GD7758@S2101-09.ap.freescale.net>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-7-git-send-email-thierry.reding@avionic-design.de>
 <20120316080025.GD7758@S2101-09.ap.freescale.net>
Message-ID: <20120316082131.GB6458@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> On Wed, Mar 14, 2012 at 04:56:29PM +0100, Thierry Reding wrote:
> > This commit adds a generic PWM framework driver for the PWFM controller
> > found on NVIDIA Tegra SoCs. The driver is based on code from the
> > Chromium kernel tree and was originally written by Gary King (NVIDIA)
> > and later modified by Simon Que (Chromium).
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v4:
> >   - merge patch from ChromiumOS kernel to fix a rounding issue
> >   - move DT code to patch 7
> > 
> > Changes in v3:
> >   - use pwm_device.hwpwm instead of recomputing it
> >   - update pwm_ops for changes in patch 2
> > 
> > Changes in v2:
> >   - set pwm_chip.dev field
> >   - rename clk_enb to enable
> >   - introduce NUM_PWM macro instead of hard-coding the number of PWM
> >     devices
> >   - update comment in tegra_pwm_config
> >   - fix coding-style for multi-line comments
> >   - use module_platform_driver
> >   - change license to GPL
> > 
> >  drivers/pwm/Kconfig     |   10 ++
> >  drivers/pwm/Makefile    |    1 +
> >  drivers/pwm/pwm-tegra.c |  256 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 267 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-tegra.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 93c1052..bda6f23 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -9,4 +9,14 @@ menuconfig PWM
> >  
> >  if PWM
> >  
> > +config PWM_TEGRA
> > +	tristate "NVIDIA Tegra PWM support"
> > +	depends on ARCH_TEGRA
> > +	help
> > +	  Generic PWM framework driver for the PWFM controller found on NVIDIA
> > +	  Tegra SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-tegra.
> > +
> >  endif
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 3469c3d..12300f5 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_PWM)		+= core.o
> > +obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > new file mode 100644
> > index 0000000..19540fc
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -0,0 +1,256 @@
> > +/*
> > + * drivers/pwm/pwm-tegra.c
> > + *
> > + * Tegra pulse-width-modulation controller driver
> > + *
> > + * Copyright (c) 2010, NVIDIA Corporation.
> > + * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pwm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define PWM_ENABLE	(1 << 31)
> > +#define PWM_DUTY_WIDTH	8
> > +#define PWM_DUTY_SHIFT	16
> > +#define PWM_SCALE_WIDTH	13
> > +#define PWM_SCALE_SHIFT	0
> > +
> > +#define NUM_PWM 4
> > +
> > +struct tegra_pwm_chip {
> > +	struct pwm_chip		chip;
> > +	struct device		*dev;
> > +
> > +	struct clk		*clk;
> > +
> > +	int			enable[NUM_PWM];
> > +	void __iomem		*mmio_base;
> > +};
> > +
> > +static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
> > +{
> > +	return container_of(chip, struct tegra_pwm_chip, chip);
> > +}
> > +
> > +static inline int pwm_writel(struct tegra_pwm_chip *chip, unsigned int num,
> > +		unsigned long val)
> > +{
> > +	unsigned long offset = num << 4;
> > +	int rc;
> > +
> > +	rc = clk_enable(chip->clk);
> > +	if (WARN_ON(rc))
> > +		return rc;
> > +
> > +	writel(val, chip->mmio_base + offset);
> > +	clk_disable(chip->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +		int duty_ns, int period_ns)
> > +{
> > +	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
> > +	unsigned long long c;
> > +	unsigned long rate, hz;
> > +	u32 val = 0;
> > +
> 
> Every pwm driver I have been looking at has some validation on
> parameters here, something like:
> 
> 	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
> 		return -EINVAL;
> 
> It's not needed for tegra, or the check on those platforms is
> unnecessary?

Yes, I should add similar checks for the Tegra driver. On the other hand
maybe the checks should be pushed into the core. At least those checks that
are truly general sanity checks. Off the top of my head, I can think of the
following general preconditions:

	pwm != NULL
	period_ns > 0
	duty_ns >= 0
	duty_ns <= period_ns

Of course duty_ns >= 0 could be done away with by just making the duty_ns and
period_ns parameters unsigned. But such changes were actually supposed to be
added incrementally once the framework had been merged.

> > +	r = devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
> > +			pdev->name);
> > +	if (!r) {
> > +		dev_err(&pdev->dev, "failed to request memory\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	pwm->mmio_base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> > +	if (!pwm->mmio_base) {
> > +		dev_err(&pdev->dev, "failed to ioremap() region\n");
> > +		return -ENODEV;
> > +	}
> > +
> 
> The helper devm_request_and_ioremap() can help here?

Yes, absolutely.

> > +static struct platform_driver tegra_pwm_driver = {
> > +	.driver = {
> > +		.name = "tegra-pwm",
> > +	},
> > +	.probe = tegra_pwm_probe,
> > +	.remove = __devexit_p(tegra_pwm_remove),
> > +};
> > +
> I would remove this blank line.
> 
> > +module_platform_driver(tegra_pwm_driver);

I don't know; I think it makes the code cluttered.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/c81c92be/attachment.sig>
