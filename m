From: bp@alien8.de (Borislav Petkov)
Date: Wed, 27 Sep 2017 18:19:01 +0200
Subject: [PATCH v10 3/7] edac, soc: thunderx: Add wrapper for EDAC LMC PCI
 device
In-Reply-To: <20170925123502.17289-4-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
 <20170925123502.17289-4-jglauber@cavium.com>
Message-ID: <20170927161901.4hto7mrc2s4yuugn@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 02:34:58PM +0200, Jan Glauber wrote:
> Cavium SOCs contain a memory controller that is presented as a
> PCI device. This PCI device will be used by an EDAC driver and
> by a PMU driver.
> 
> To allow both subsystems to access the device a small wrapper is
> introduced that multi-plexes PCI probe and removal calls of the
> device to the EDAC driver.
> 
> The same mechanism will be used later to call the PMU driver.
> 
> The ThunderX EDAC driver is limited to only build as module
> with this patch. The reason is that with multiple users of the
> multi-plexer all users must be either builtin or modules.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---

...

> diff --git a/drivers/soc/cavium/cavium_lmc.c b/drivers/soc/cavium/cavium_lmc.c
> new file mode 100644
> index 000000000000..87248e83c55b
> --- /dev/null
> +++ b/drivers/soc/cavium/cavium_lmc.c
> @@ -0,0 +1,49 @@
> +/*
> + * These PCI devices contain RAS functionality and PMU counters. To allow
> + * independent RAS and PMU drivers this driver registers for the PCI devices
> + * and multi-plexes probe and removal.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright: Cavium, Inc. (C) 2017
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/soc/cavium/lmc.h>
> +
> +static int cvm_lmc_probe(struct pci_dev *pdev,
> +			 const struct pci_device_id *ent)
> +{
> +	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
> +		thunderx_edac_lmc_probe(pdev, ent);

You could save yourself the if (IS_ENABLED()) here by adding stubs in
the lmc.h header for those functions for the !CONFIG_EDAC_THUNDERX case.

One thing I'm not clear on though, is the design of the whole thing:
cvm_lmc_probe() probes the EDAC driver during its own probe, which
means, thunderx_edac needs to be loaded first. And the other things that
get loaded, do the same.

What I was expecting is those small cavium_lmc.c and cavium_ocx.c
wrappers to probe and register the respective PCI device and then its
*users* - EDAC and PMU drivers to go and request the PCI device from
them:

cavium_lmc_get_pci_dev()
cavium_ocx_get_pci_dev()

and so on. Those will be exported to modules. And the small stubs can
also be built-in too.

This way you can do reference counting and whatever else.

If the above calls fail, neither EDAC nor PMU will load properly but you
solve the multiplexing issue by having those wrappers arbitrate access
to the PCI devices.

Because right now the wrappers are simply weakly hiding the calls into
EDAC and that's exactly what I was opposing to.

Hmmm?

> +	return 0;
> +}
> +
> +static void cvm_lmc_remove(struct pci_dev *pdev)
> +{
> +	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
> +		thunderx_edac_lmc_remove(pdev);
> +}
> +
> +static const struct pci_device_id cvm_lmc_pci_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa022) },

        { PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDER_LMC) },

You already have that PCI device id define.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
