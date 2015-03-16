From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 16 Mar 2015 16:11:35 +0100
Subject: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1426518695.26437.55.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-16 at 15:20 +0100, Gabriel FERNANDEZ wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
 
> +config PCI_ST
> +	bool "ST PCIe controller"

You add a bool Kconfig symbol. A week or two ago I saw some patches fly
by that - I think - allowed PCIe controllers to be built modular.

> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
> +	select PCIE_DW
> +	help
> +	  Enable PCIe controller support on ST Socs. This controller is based
> +	  on Designware hardware and therefore the driver re-uses the
> +	  Designware core functions to implement the driver.

> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile

> +obj-$(CONFIG_PCI_ST) += pci-st.o

If you keep that symbol bool this objectfile will never be part of a
module.

> diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
> new file mode 100644
> index 0000000..470000d
> --- /dev/null
> +++ b/drivers/pci/host/pci-st.c

> +#include <linux/module.h>

For built-in code this include is, probably, not needed.

> +MODULE_DEVICE_TABLE(of, st_pcie_of_match);

For built-in code that macro will always be preprocessed away.

> +/* ST PCIe driver does not allow module unload */
> +static int __init pcie_init(void)
> +{
> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> +}
> +device_initcall(pcie_init);

I think the module unload comment is a bit odd for built-in only code.

> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
> +MODULE_LICENSE("GPL v2");

These three macros will be, basically, always preprocessed away as long
as this code can't be built to be modular.


Paul Bolle
