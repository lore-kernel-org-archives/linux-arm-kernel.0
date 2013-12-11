From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Dec 2013 00:00:53 +0100
Subject: [PATCH 09/12] pcie: SPEAr13xx: Add designware pcie support
In-Reply-To: <f5c9cbbd116d462c428afc2e8afefd95aad8c6ec.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <f5c9cbbd116d462c428afc2e8afefd95aad8c6ec.1386752447.git.mohit.kumar@st.com>
Message-ID: <201312120000.54545.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Mohit Kumar wrote:
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <mach/spear.h>

This won't actually build: you cannot access mach/*.h header files
from outside of mach-spear!

> +struct spear13xx_pcie {
> +	void __iomem		*phy_base;
> +	void __iomem		*app_base;
> +	struct clk		*clk;
> +	struct pcie_port	pp;
> +	int			id;
> +	int			is_gen1;
> +};

The pcie driver shouldn't have direct access to the phy registers,
use a phy driver for that.

> +static int workaround_linkup_spear1340(struct spear13xx_pcie *spear13xx_pcie)
> +{
> 
> +}
> +
> +static int spear13xx_pcie_establish_link(struct pcie_port *pp)
> +{

These should move into the phy driver.

> +	/* txdetectrx workaround for SPEAr1310 */
> +	if (of_machine_is_compatible("st,spear1310"))
> +		writeb(0x00, spear13xx_pcie->phy_base + 0x16);

Don't use of_machine_is_compatible() to test for features or bugs of a
particular device. Instead use a binary property in the specific
device node, or key it off of the device's "compatible" value if
there are a lot of differences. You seem to have a couple of these
to test for one or the other PHY implementation, those will
go away when you have a proper driver for them.

	Arnd
