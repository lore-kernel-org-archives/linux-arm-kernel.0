From: liudongdong3@huawei.com (liudongdong (C))
Date: Tue, 19 Jan 2016 09:49:40 +0800
Subject: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <569CDD8F.807@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1452785776.28109.22.camel@redhat.com> <569CDD8F.807@semihalf.com>
Message-ID: <569D9634.3040304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz, Mark

? 2016/1/18 20:41, Tomasz Nowicki ??:
> On 14.01.2016 16:36, Mark Salter wrote:
>>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>>> >+extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>>> >+
>>> >+static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *root)
>>> >+{
>>> >+    struct pci_mcfg_fixup *f;
>>> >+    int bus_num = root->secondary.start;
>>> >+    int domain = root->segment;
>>> >+
>>> >+    /*
>>> >+     * First match against PCI topology <domain:bus> then use DMI or
>>> >+     * custom match handler.
>>> >+     */
>>> >+    for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
>>> >+        if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
>>> >+            (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
>>> >+            (f->system ? dmi_check_system(f->system) : 0 ||
>>> >+             f->match ? f->match(f, root) : 0))
>>> >+            return f->ops;
>> I think this would be better as:
>>
>>             (f->system ? dmi_check_system(f->system) : 1 &&
>>              f->match ? f->match(f, root) : 1))
>>             return f->ops;
>>
>> Otherwise, one has to call dmi_check_system() from f->match() if
>> access to root is needed.
>

Non-DMI, we need not to call dmi_check_system() from f->match(),
we can use _HID to decide to hook the pci_ops or not.

Device (PCI1)
{
         Name (_HID, "HISI0080") // PCI Express Root Bridge
         Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
	...
}

static const struct acpi_device_id hisi_pcie_ids[] = {
     {"HISI0080", 0},
     {"", 0},
};

static int hisi_pcie_match(struct pci_mcfg_fixup *fixup, struct acpi_pci_root *root)
{
     int ret;
     struct acpi_device *device;

     device = root->device;
     ret = acpi_match_device_ids(device, hisi_pcie_ids);
     if (ret)
         return 0;
     ......
     return 1;
}

static struct pci_ops hisi_ecam_pci_ops = {
     .map_bus = pci_mcfg_dev_base,
     .read = hisi_pci_read,
     .write = hisi_pci_write,
};

DECLARE_ACPI_MCFG_FIXUP(NULL, hisi_pcie_match, &hisi_ecam_pci_ops,
     PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);

Thanks
Dongdong
> Makes a lot of sense to me, I will modify as you suggested.
>
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
