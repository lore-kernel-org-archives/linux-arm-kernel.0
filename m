From: jchandra@broadcom.com (Jayachandran C)
Date: Wed, 20 Apr 2016 05:52:08 +0530
Subject: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
In-Reply-To: <124097091.1DmSn50Vlh@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-9-git-send-email-tn@semihalf.com>
 <124097091.1DmSn50Vlh@wuerfel>
Message-ID: <CAKc_7PWepAifNbu2LQa6StCHSOee=mHe6OEnS9MLrFBCR85B4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 3:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 April 2016 19:06:43 Tomasz Nowicki wrote:
>> From: Jayachandran C <jchandra@broadcom.com>
>>
>> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
>> provide generic functions for accessing memory mapped PCI config space.
>>
>> The API is defined in drivers/pci/ecam.h and is written to replace the
>> API in drivers/pci/host/pci-host-common.h. The file defines a new
>> 'struct pci_config_window' to hold the information related to a PCI
>> config area and its mapping. This structure is expected to be used as
>> sysdata for controllers that have ECAM based mapping.
>>
>> Helper functions are provided to setup the mapping, free the mapping
>> and to implement the map_bus method in 'struct pci_ops'
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>
> I've taken a fresh look now at what is going on here.
>
>> @@ -58,4 +58,9 @@ void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>>  /* default ECAM ops, bus shift 20, generic read and write */
>>  extern struct pci_generic_ecam_ops pci_generic_ecam_default_ops;
>>
>> +#ifdef CONFIG_PCI_HOST_GENERIC
>> +/* for DT based pci controllers that support ECAM */
>> +int pci_host_common_probe(struct platform_device *pdev,
>> +                       struct pci_generic_ecam_ops *ops);
>> +#endif
>>  #endif
>
> This doesn't seem to belong here: just leave the declaration
> in the existing file.

This can be done, the file would just have one line so I thought
it made sense to move it to ecam.h where the struct is defined.

>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 7a0780d..31d6eb5 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -82,6 +82,7 @@ config PCI_HOST_GENERIC
>>       bool "Generic PCI host controller"
>>       depends on (ARM || ARM64) && OF
>>       select PCI_HOST_COMMON
>> +     select PCI_GENERIC_ECAM
>>       help
>>         Say Y here if you want to support a simple generic PCI host
>>         controller, such as the one emulated by kvmtool.
>> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
>> index e9f850f..99d99b3 100644
>> --- a/drivers/pci/host/pci-host-common.c
>> +++ b/drivers/pci/host/pci-host-common.c
>> @@ -22,27 +22,21 @@
>>  #include <linux/of_pci.h>
>>  #include <linux/platform_device.h>
>>
>> -#include "pci-host-common.h"
>> +#include "../ecam.h"
>
> As mentioned, don't use headers from parent directories, anything
> that needs to be shared must go into include/linux, while the parts
> that are only needed in one directory should be declared there.

This is also ok - It can either go to pci.h or a separate pci-ecam.h

>> -static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>> +static void gen_pci_generic_unmap_cfg(void *ptr)
>> +{
>> +     pci_generic_ecam_free((struct pci_config_window *)ptr);
>> +}
>
> Why the void pointer?

devm_add_action() needs it.

>> +static struct pci_generic_ecam_ops pci_thunder_pem_ops = {
>> +     .bus_shift      = 24,
>> +     .init           = thunder_pem_init,
>> +     .pci_ops        = {
>> +             .map_bus        = pci_generic_ecam_map_bus,
>> +             .read           = thunder_pem_config_read,
>> +             .write          = thunder_pem_config_write,
>> +     }
>> +};
>
> Adding the callback pointer for init here and yet another structure
> pci_config_window really seems to go too far with the number of
> abstraction levels.

The abstraction was already there in pci-host-common.h for
ops for ECAM/CAM based controllers. It made sense to move it
to ecam.h and use it for ECAM based ACPI [1].

We need to pass pci_ops, bus_shift and an additional pointer
for quirks for ECAM based host controllers. Having it as a
structure pci_generic_ecam_ops reduces the function arguments,
and also keeps most of the older API.

> I think here it makes much more sense to just implement ECAM pci_ops
> in ACPI separately, as the implementation really trivial to start with,
> and all the complexity comes just from trying to share it with other
> stuff. Doesn't ACPI already have an ECAM implementation for x86
> that you could simply use?

The implementation is extremely trivial on 64 bit, and slightly more
complex in 32bit (pci-host-common.c per bus mapping and set_pte
based mapping on  x86). The generic ACPI on 64 bit is very simple
if there are no quirks,I have already posted that [2] some time back.

ACPI on x86 also has a 32 bit and a 64 bit version
(arch/x86/pci/mmconfig_{32,64}.c}. The code there is a bit messed
up and it does not make sense to share or reuse that.

There has been suggestions earlier from Bjorn on sharing the
ECAM implementation[1], which was the starting point of
doing this patch.

Overall, this patch improves config window mapping for
pci-host-common.c based drivers on 64 bit and deletes
quite a bit of duplicated code. I would argue that this makes
sense even without ACPI.

JC.

[1] https://lkml.org/lkml/2016/3/3/921
[2] http://article.gmane.org/gmane.linux.kernel.pci/47753
