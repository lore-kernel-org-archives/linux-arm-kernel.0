From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 18 Mar 2015 09:49:22 +0100
Subject: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1426518695.26437.55.camel@x220>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>	
 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
 <1426518695.26437.55.camel@x220>
Message-ID: <55093C12.7070004@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 03/16/2015 04:11 PM, Paul Bolle wrote:
>> +config PCI_ST
>> +	bool "ST PCIe controller"
> You add a bool Kconfig symbol. A week or two ago I saw some patches fly
> by that - I think - allowed PCIe controllers to be built modular.

Thanks for your review.

Are you talking about "PCI: Export symbols of PCI functions" patch, that 
is part of a series
named "pci: iproc: Add Broadcom iProc PCIe support" ?

This controller doesn't look like to be based on pcie-designware core 
driver.
Other vendors that are using "pcie-designware" core driver are also make 
it bool.
The current core driver doesn't support module loading/unloading as I 
see it.
If this is required, I also think this should be part of another patchset.

What do you think ?

Please advise,
BR,
Fabrice
>
>> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
>> +	select PCIE_DW
>> +	help
>> +	  Enable PCIe controller support on ST Socs. This controller is based
>> +	  on Designware hardware and therefore the driver re-uses the
>> +	  Designware core functions to implement the driver.
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> +obj-$(CONFIG_PCI_ST) += pci-st.o
> If you keep that symbol bool this objectfile will never be part of a
> module.
>
>> diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
>> new file mode 100644
>> index 0000000..470000d
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-st.c
>> +#include <linux/module.h>
> For built-in code this include is, probably, not needed.
>
>> +MODULE_DEVICE_TABLE(of, st_pcie_of_match);
> For built-in code that macro will always be preprocessed away.
>
>> +/* ST PCIe driver does not allow module unload */
>> +static int __init pcie_init(void)
>> +{
>> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
>> +}
>> +device_initcall(pcie_init);
> I think the module unload comment is a bit odd for built-in only code.
>
>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
>> +MODULE_LICENSE("GPL v2");
> These three macros will be, basically, always preprocessed away as long
> as this code can't be built to be modular.
>
>
> Paul Bolle
>
