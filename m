From: dhdang@apm.com (Duc Dang)
Date: Tue, 21 Jun 2016 01:42:25 -0700
Subject: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling for
 ACPI based PCI host controller
In-Reply-To: <CADaLNDme9VCrM0Mk-3eOhai-TSQtzwHfo_CGqO9eLZFkzi1JGQ@mail.gmail.com>
References: <CADaLNDkziZgM-yAiK2MCqfBRzhWpLmCyPmDZEGsvwd-7nfRfLw@mail.gmail.com>
 <20160620094227.GA27594@red-moon> <5768252D.7090206@codeaurora.org>
 <CADaLNDme9VCrM0Mk-3eOhai-TSQtzwHfo_CGqO9eLZFkzi1JGQ@mail.gmail.com>
Message-ID: <CADaLNDmkVs6s7DCHyCwg7JHTA=y1sTYRXgf09KmQueUBqP+ZdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 12:12 PM, Duc Dang <dhdang@apm.com> wrote:
> On Mon, Jun 20, 2016 at 10:17 AM, Christopher Covington
> <cov@codeaurora.org> wrote:
>> Hi Duc,
>>
>> On 06/20/2016 05:42 AM, Lorenzo Pieralisi wrote:
>>> On Fri, Jun 17, 2016 at 02:37:02PM -0700, Duc Dang wrote:
>>>> On Thu, Jun 16, 2016 at 10:48 AM, Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>> On Wed, Jun 15, 2016 at 11:34:11AM -0400, Christopher Covington wrote:
>>>>>> From: Tomasz Nowicki <tn@semihalf.com>
>>>>>>
>>>>>> pci_generic_ecam_ops is used by default. Since there are platforms
>>>>>> which have non-compliant ECAM space we need to overwrite these
>>>>>> accessors prior to PCI buses enumeration. In order to do that
>>>>>> we call pci_mcfg_get_ops to retrieve pci_ecam_ops structure so that
>>>>>> we can use proper PCI config space accessors and bus_shift.
>>>>>>
>>>>>> pci_generic_ecam_ops is still used for platforms free from quirks.
>>>>>>
>>>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>>>> ---
>>>>>>  arch/arm64/kernel/pci.c | 7 ++++---
>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>>>>> index 94cd43c..a891bda 100644
>>>>>> --- a/arch/arm64/kernel/pci.c
>>>>>> +++ b/arch/arm64/kernel/pci.c
>>>>>> @@ -139,6 +139,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>>>>>>       struct pci_config_window *cfg;
>>>>>>       struct resource cfgres;
>>>>>>       unsigned int bsz;
>>>>>> +     struct pci_ecam_ops *ops;
>>>>>>
>>>>>>       /* Use address from _CBA if present, otherwise lookup MCFG */
>>>>>>       if (!root->mcfg_addr)
>>>>>> @@ -150,12 +151,12 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>>>>>>               return NULL;
>>>>>>       }
>>>>>>
>>>>>> -     bsz = 1 << pci_generic_ecam_ops.bus_shift;
>>>>>> +     ops = pci_mcfg_get_ops(root);
>>>>>> +     bsz = 1 << ops->bus_shift;
>>>>>>       cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>>>>>>       cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>>>>>>       cfgres.flags = IORESOURCE_MEM;
>>>>>> -     cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
>>>>>> -                           &pci_generic_ecam_ops);
>>>>>> +     cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ops);
>>>>>
>>>>> Arnd pointed this out already, I think that's the only pending question
>>>>> here.
>>>>>
>>>>> pci_ecam_create() maps ECAM space for config regions retrieved from
>>>>> the MCFG, which are *supposed* to be ECAM compliant.
>>>>>
>>>>> Do we think that's *always* correct/safe regardless of the kind
>>>>> of quirk we are currently fixing up ?
>>>>>
>>>>> Or we do think that configuration space regions should come from
>>>>> a different resource declared in the ACPI namespace if the regions
>>>>> are not MCFG/ECAM compliant (ie config space is not defined through
>>>>> MCFG at all - possibly through a _CRS method for a vendor specific
>>>>> _HID under the PNP0A03 node ?)
>>>>
>>>> Hi Lorenzo,
>>>>
>>>> For X-Gene: the ECAM space is used to access the configuration space
>>>> of PCIe devices, with additional help from controller register to
>>>> specify the bus, device and function number. Below is the RFC patch
>>>> that implements ECAM fixup for X-Gene PCIe controller on top of this
>>>> RFC ECAM quirk v3 for your and others reference.
>>>
>>> Yes, you have an additional resource in the PNP0A03 _CRS to describe
>>> your register that is a deliberate abuse of the ACPI standard in
>>> that the _CRS is meant to describe resources that are passed on
>>> to secondary buses
>>
>> A potential alternative came up in an off-list discussion: Would it be
>> better to hard code the information in the quirk workaround than look it
>> up from a repurposed ACPI resource?
>
> Hi Chris, Lorenzo,
>
> Thanks for looking into this.
>
> Yes, I am open for this approach and I think it may work. I can
> + check the pci_config_window resource start address (cfg->res.start)
> to figure out the controller and then get the fixed controller
> register address
> or
> + using the domain number to identify the controller.

Hi Chris, Lorenzo,

I reworked the patch to use fix-ed controller address. Please let me know
if you have further comment/concern.

---
[PATCH 1/1] pci: xgene: ECAM fix-up code for X-Gene PCIe

X-Gene PCIe controller does not fully support ECAM.
This patch adds required ECAM fixup to allow X-Gene
PCIe controller to be functional in ACPI boot mode.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
v2 changes:
 - Using ECAM base address to identify fixed controller address

 drivers/pci/host/Makefile         |   2 +-
 drivers/pci/host/pci-xgene-ecam.c | 291 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pci-xgene-ecam.c

diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9c8698e..3480696 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
-obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
+obj-$(CONFIG_PCI_XGENE) += pci-xgene.o pci-xgene-ecam.o
 obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
diff --git a/drivers/pci/host/pci-xgene-ecam.c
b/drivers/pci/host/pci-xgene-ecam.c
new file mode 100644
index 0000000..87d2dcf
--- /dev/null
+++ b/drivers/pci/host/pci-xgene-ecam.c
@@ -0,0 +1,291 @@
+/*
+ * APM X-Gene PCIe ECAM fixup driver
+ *
+ * Copyright (c) 2016, Applied Micro Circuits Corporation
+ * Author:
+ *    Duc Dang <dhdang@apm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/platform_device.h>
+#include <linux/pci-ecam.h>
+
+#ifdef CONFIG_ACPI
+#define RTDID            0x160
+#define ROOT_CAP_AND_CTRL    0x5C
+
+/* PCIe IP version */
+#define XGENE_PCIE_IP_VER_UNKN    0
+#define XGENE_PCIE_IP_VER_1    1
+#define XGENE_PCIE_IP_VER_2    2
+
+#define XGENE_CSR_LENGTH    0x10000
+
+struct xgene_pcie_acpi_root {
+    void __iomem *csr_base;
+    u32 version;
+};
+
+static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
+{
+    struct xgene_pcie_acpi_root *xgene_root;
+    struct device *dev = cfg->parent;
+    u32 csr_base;
+
+    xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+    if (!xgene_root)
+        return -ENOMEM;
+
+    switch (cfg->res.start) {
+    case 0xE0D0000000ULL:
+        csr_base = 0x1F2B0000;
+        break;
+    case 0xD0D0000000ULL:
+        csr_base = 0x1F2C0000;
+        break;
+    case 0x90D0000000ULL:
+        csr_base = 0x1F2D0000;
+        break;
+    case 0xA0D0000000ULL:
+        csr_base = 0x1F500000;
+        break;
+    case 0xC0D0000000ULL:
+        csr_base = 0x1F510000;
+        break;
+    default:
+        return -ENODEV;
+    }
+
+    xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+    if (!xgene_root->csr_base) {
+        kfree(xgene_root);
+        return -ENODEV;
+    }
+
+    xgene_root->version = XGENE_PCIE_IP_VER_1;
+
+    cfg->priv = xgene_root;
+
+    return 0;
+}
+
+static int xgene_v2_1_pcie_ecam_init(struct pci_config_window *cfg)
+{
+    struct xgene_pcie_acpi_root *xgene_root;
+    struct device *dev = cfg->parent;
+    resource_size_t csr_base;
+
+    xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+    if (!xgene_root)
+        return -ENOMEM;
+
+    switch (cfg->res.start) {
+    case 0xC0D0000000ULL:
+        csr_base = 0x1F2B0000;
+        break;
+    case 0xA0D0000000ULL:
+        csr_base = 0x1F2C0000;
+        break;
+    default:
+        return -ENODEV;
+    }
+
+    xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+    if (!xgene_root->csr_base) {
+        kfree(xgene_root);
+        return -ENODEV;
+    }
+
+    xgene_root->version = XGENE_PCIE_IP_VER_2;
+
+    cfg->priv = xgene_root;
+
+    return 0;
+}
+
+static int xgene_v2_2_pcie_ecam_init(struct pci_config_window *cfg)
+{
+    struct xgene_pcie_acpi_root *xgene_root;
+    struct device *dev = cfg->parent;
+    resource_size_t csr_base;
+
+    xgene_root = devm_kzalloc(dev, sizeof(*xgene_root), GFP_KERNEL);
+    if (!xgene_root)
+        return -ENOMEM;
+
+    switch (cfg->res.start) {
+    case 0xE0D0000000ULL:
+        csr_base = 0x1F2B0000;
+        break;
+    case 0xA0D0000000ULL:
+        csr_base = 0x1F500000;
+        break;
+    case 0x90D0000000ULL:
+        csr_base = 0x1F2D0000;
+        break;
+    default:
+        return -ENODEV;
+    }
+
+    xgene_root->csr_base = ioremap(csr_base, XGENE_CSR_LENGTH);
+    if (!xgene_root->csr_base) {
+        kfree(xgene_root);
+        return -ENODEV;
+    }
+
+    xgene_root->version = XGENE_PCIE_IP_VER_2;
+
+    cfg->priv = xgene_root;
+
+    return 0;
+}
+/*
+ * For Configuration request, RTDID register is used as Bus Number,
+ * Device Number and Function number of the header fields.
+ */
+static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
+{
+    struct pci_config_window *cfg = bus->sysdata;
+    struct xgene_pcie_acpi_root *port = cfg->priv;
+    unsigned int b, d, f;
+    u32 rtdid_val = 0;
+
+    b = bus->number;
+    d = PCI_SLOT(devfn);
+    f = PCI_FUNC(devfn);
+
+    if (!pci_is_root_bus(bus))
+        rtdid_val = (b << 8) | (d << 3) | f;
+
+    writel(rtdid_val, port->csr_base + RTDID);
+    /* read the register back to ensure flush */
+    readl(port->csr_base + RTDID);
+}
+
+/*
+ * X-Gene PCIe port uses BAR0-BAR1 of RC's configuration space as
+ * the translation from PCI bus to native BUS.  Entire DDR region
+ * is mapped into PCIe space using these registers, so it can be
+ * reached by DMA from EP devices.  The BAR0/1 of bridge should be
+ * hidden during enumeration to avoid the sizing and resource allocation
+ * by PCIe core.
+ */
+static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
+{
+    if (pci_is_root_bus(bus) && ((offset == PCI_BASE_ADDRESS_0) ||
+                     (offset == PCI_BASE_ADDRESS_1)))
+        return true;
+
+    return false;
+}
+
+void __iomem *xgene_pcie_ecam_map_bus(struct pci_bus *bus,
+                      unsigned int devfn, int where)
+{
+    struct pci_config_window *cfg = bus->sysdata;
+    unsigned int busn = bus->number;
+    void __iomem *base;
+
+    if (busn < cfg->busr.start || busn > cfg->busr.end)
+        return NULL;
+
+    if ((pci_is_root_bus(bus) && devfn != 0) ||
+        xgene_pcie_hide_rc_bars(bus, where))
+        return NULL;
+
+    xgene_pcie_set_rtdid_reg(bus, devfn);
+
+    if (busn > cfg->busr.start)
+        base = cfg->win + (1 << cfg->ops->bus_shift);
+    else
+        base = cfg->win;
+
+    return base + where;
+}
+
+static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
+                    int where, int size, u32 *val)
+{
+    struct pci_config_window *cfg = bus->sysdata;
+    struct xgene_pcie_acpi_root *port = cfg->priv;
+
+    if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
+        PCIBIOS_SUCCESSFUL)
+        return PCIBIOS_DEVICE_NOT_FOUND;
+
+    /*
+    * The v1 controller has a bug in its Configuration Request
+    * Retry Status (CRS) logic: when CRS is enabled and we read the
+    * Vendor and Device ID of a non-existent device, the controller
+    * fabricates return data of 0xFFFF0001 ("device exists but is not
+    * ready") instead of 0xFFFFFFFF ("device does not exist").  This
+    * causes the PCI core to retry the read until it times out.
+    * Avoid this by not claiming to support CRS.
+    */
+    if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
+        ((where & ~0x3) == ROOT_CAP_AND_CTRL))
+        *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+
+    if (size <= 2)
+        *val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+    return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
+    .bus_shift    = 16,
+    .init        = xgene_v1_pcie_ecam_init,
+    .pci_ops    = {
+        .map_bus    = xgene_pcie_ecam_map_bus,
+        .read        = xgene_pcie_config_read32,
+        .write        = pci_generic_config_write,
+    }
+};
+
+DECLARE_ACPI_MCFG_FIXUP(&xgene_v1_pcie_ecam_ops, "APM", "XGENE", 0x2,
+            PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&xgene_v1_pcie_ecam_ops, "APM", "XGENE", 0x1,
+            PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
+
+static struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops = {
+    .bus_shift    = 16,
+    .init        = xgene_v2_1_pcie_ecam_init,
+    .pci_ops    = {
+        .map_bus    = xgene_pcie_ecam_map_bus,
+        .read        = xgene_pcie_config_read32,
+        .write        = pci_generic_config_write,
+    }
+};
+
+DECLARE_ACPI_MCFG_FIXUP(&xgene_v2_1_pcie_ecam_ops, "APM", "XGENE2", 0x1,
+            PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
+
+static struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops = {
+    .bus_shift    = 16,
+    .init        = xgene_v2_2_pcie_ecam_init,
+    .pci_ops    = {
+        .map_bus    = xgene_pcie_ecam_map_bus,
+        .read        = xgene_pcie_config_read32,
+        .write        = pci_generic_config_write,
+    }
+};
+
+DECLARE_ACPI_MCFG_FIXUP(&xgene_v2_2_pcie_ecam_ops, "APM", "XGENE2", 0x2,
+            PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
+#endif
-- 
1.9.1


>>
>> Supporting quirk workarounds for early, non-compliant hardware is
>> helpful and perhaps necessary for bootstrapping the ecosystem in a
>> timely manner. But we don't really want to provide an expandable or
>> reusable interface that would make it easy for new hardware to remain
>> non-compliant.
>>
>> Regards,
>> Cov
>>
>> --
>> Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
Regards,
Duc Dang.
