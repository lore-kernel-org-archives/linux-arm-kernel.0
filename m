From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Jun 2012 14:07:36 -0400 (EDT)
Subject: [PATCH v5 3/9] arm: mach-mvebu: add source files
In-Reply-To: <20120627153652.GE29702@lunn.ch>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340805290-9051-4-git-send-email-gregory.clement@free-electrons.com>
 <20120627153652.GE29702@lunn.ch>
Message-ID: <alpine.LFD.2.02.1206281354030.31003@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jun 2012, Andrew Lunn wrote:

> > diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
> > new file mode 100644
> > index 0000000..14331ba
> > --- /dev/null
> > +++ b/arch/arm/mach-mvebu/system-controller.c
> > @@ -0,0 +1,100 @@
> > +/*
> > + * System controller support for Armada 370 and XP platforms.
> > + *
> > + * Copyright (C) 2012 Marvell
> > + *
> > + * Lior Amsalem <alior@marvell.com>
> > + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> > + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + *
> > + * The Armada 370 and Armada XP SoCs both have a range of
> > + * miscellaneous registers, that do not belong to a particular device,
> > + * but rather provide system-level features. This basic
> > + * system-controller driver provides a device tree binding for those
> > + * registers, and implements utility functions offering various
> > + * features related to those registers.
> > + *
> > + * For now, the feature set is limited to restarting the platform by a
> > + * soft-reset, but it might be extended in the future.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/of_address.h>
> > +#include <linux/io.h>
> > +
> > +static void __iomem *system_controller_base;
> > +
> > +struct mvebu_system_controller {
> > +	u32 rstoutn_mask_offset;
> > +	u32 system_soft_reset_offset;
> > +
> > +	u32 rstoutn_mask_reset_out_en;
> > +	u32 system_soft_reset;
> > +};
> > +static struct mvebu_system_controller *mvebu_sc;
> > +
> > +const struct mvebu_system_controller armada_370_xp_system_controller = {
> > +	.rstoutn_mask_offset = 0x60,
> > +	.system_soft_reset_offset = 0x64,
> > +	.rstoutn_mask_reset_out_en = 0x1,
> > +	.system_soft_reset = 0x1,
> > +};
> > +
> > +const struct mvebu_system_controller orion_system_controller = {
> > +	.rstoutn_mask_offset = 0x108,
> > +	.system_soft_reset_offset = 0x10c,
> > +	.rstoutn_mask_reset_out_en = 0x4,
> > +	.system_soft_reset = 0x1,
> > +};
> > +
> > +static struct of_device_id of_system_controller_table[] = {
> > +	{.compatible = "marvell,orion-system-controller",
> > +	 .data = (void *) &orion_system_controller},
> > +	{.compatible = "marvell,armada-370-xp-system-controller",
> > +	 .data = (void *) &armada_370_xp_system_controller},
> > +	{ /* end of list */ },
> > +};
> > +
> > +void mvebu_restart(char mode, const char *cmd)
> > +{
> > +	if (!system_controller_base) {
> > +		pr_warn("Cannot restart, system-controller not available\n");
> 
> Does pr_warn() get shown by default? I would of probably gone for
> BUG_ON() or WARN_ON(), to make it clearer what has happened. It may
> not be a kernel bug, but a DT description bug, but it still a bug...

In this case, this is unlikely to be a data corrupting critical bug, 
therefore it is not appropriate to use BUG() which purpose is to kill 
the kernel.  And if the panic timeout used to reboot the kernel is set 
then you'll enter an infinite loop.

BUG()/BUG_ON() must be used only when there is no hope for the kernel to 
move on sensibly and that serious data corruption is at risk.  External 
data such as DT should ideally be validated with proper diagnostic 
messages rather than triggering BUG().


Nicolas
