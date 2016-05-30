From: jchandra@broadcom.com (Jayachandran C)
Date: Mon, 30 May 2016 21:43:58 +0530
Subject: [PATCH V8 9/9] pci, acpi: ARM64 support for ACPI based generic
 PCI host controller
In-Reply-To: <8385994.W7ve9PrvHG@wuerfel>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-10-git-send-email-tn@semihalf.com>
 <8385994.W7ve9PrvHG@wuerfel>
Message-ID: <CAKc_7PW3Hdk9zTZ53yhGVdeeFVGFaFExZEvp456s16DnnMMjWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 9:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, May 30, 2016 5:14:22 PM CEST Tomasz Nowicki wrote:
>> +       bsz = 1 << pci_generic_ecam_ops.bus_shift;
>> +       cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>> +       cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>> +       cfgres.flags = IORESOURCE_MEM;
>> +       cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
>> +                             &pci_generic_ecam_ops);
>> +       if (IS_ERR(cfg)) {
>> +               pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
>> +                      PTR_ERR(cfg));
>> +               return PTR_ERR(cfg);
>> +       }
>> +
>> +       ri->cfg = cfg;
>> +       return 0;
>> +}
>
> I wonder if we could do this a little simpler and just put a pointer
> to the mmconfig space into struct pci_host_bridge, and then have a trivial
> map_bus function alongside pci_generic_config_read/pci_generic_config_write.
>
> As this code is specific to arch/arm64, we don't need any of the complexity
> of drivers/pci/ecam.c, which basically only exists to work around the
> limited virtual address space of 32-bit machines.

The map_bus provided by pci-ecam.h is already trivial in 64bit case,
it was written so that it could be optimized at compile time. The
pci_ecam_create is a useful to have here instead of redoing the
request_resource/ioremap sequence.

The struct pci_config_window can be moved into struct
pci_host_bridge (or a wrapper of pci_host_bridge) when we have
the setup to point bus->sysdata to something like that. The ECAM
API can be fixed up to handle that case as well. I did not make
any changes since the pci_host_bridge discussion is still going on.

JC.
