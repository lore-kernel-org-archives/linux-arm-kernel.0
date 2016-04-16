From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 16 Apr 2016 12:50:13 +0530
Subject: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
In-Reply-To: <5110401.mGEq6IVFz2@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-9-git-send-email-tn@semihalf.com>
 <5110401.mGEq6IVFz2@wuerfel>
Message-ID: <CAKc_7PWFacFJZA2JpfM4RcRFVj0jyUE73HhhvmX0cKm07JGupg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 12:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 April 2016 19:06:43 Tomasz Nowicki wrote:
>> -MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
>> -
>> -static int thunder_pem_probe(struct platform_device *pdev)
>> +static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg)
>>  {
>> -       struct device *dev = &pdev->dev;
>> -       const struct of_device_id *of_id;
>>         resource_size_t bar4_start;
>>         struct resource *res_pem;
>>         struct thunder_pem_pci *pem_pci;
>> +       struct platform_device *pdev;
>>
>>         pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
>>         if (!pem_pci)
>>                 return -ENOMEM;
>>
>> -       of_id = of_match_node(thunder_pem_of_match, dev->of_node);
>> -       pem_pci->gen_pci.cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
>> +       pdev = to_platform_device(dev);
>>
>>         /*
>>          * The second register range is the PEM bridge to the PCIe
>> @@ -330,7 +298,29 @@ static int thunder_pem_probe(struct platform_device *pdev)
>>         pem_pci->ea_entry[1] = (u32)(res_pem->end - bar4_start) & ~3u;
>>         pem_pci->ea_entry[2] = (u32)(bar4_start >> 32);
>>
>> -       return pci_host_common_probe(pdev, &pem_pci->gen_pci);
>> +       cfg->priv = pem_pci;
>> +       return 0;
>> +}
>> +
>>
>
> I still think it would be better to keep the loadable PCI host drivers
> separate from the ACPI PCI infrastructure. There are a number of
> simplifications that we want to do to the DT based drivers in the long
> run, so it's better if that code is not shared at this level. Abstracting
> out the ECAM code is fine, but at that point you should be able to just
> call it from the ACPI layer.

The issue is not with this patch (in my opinion). This patch is just
re-arranging how thunder specific data is maintained. Earlier it was
a container_of gen_pci, now it is ->priv of pci_config_window.

I can see the issue in patches 12 and 13 of this patchset which adds
ACPI fixups into the thunder OF driver.

The simple approach when doing modular PCI drivers would be to make
pci-thunder-*.c like pci-host-common.c, to be compiled in if configured.
The fie will contain all the Thunder quirks and can export
pci_thunder_ecam_ops.

Then the OF driver part will be trivial and can be merged into
pci-host-generic.c which can be a module. The ACPI hooks can be
moved to the ACPI PCI host driver file.

Would appreciate any suggestions on the way forward.

Thanks,
JC.
