From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 31 Oct 2016 15:28:13 -0700
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
In-Reply-To: <CACna6ryMbF8kVUYOfhre4qtZp5haa2Shijcv40AXsjL_jZL=JQ@mail.gmail.com>
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
 <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
 <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
 <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
 <3847db9f-a8e1-b7fe-c2fa-19ea893bae5f@broadcom.com>
 <CACna6ryMbF8kVUYOfhre4qtZp5haa2Shijcv40AXsjL_jZL=JQ@mail.gmail.com>
Message-ID: <f6a890ee-bf20-def0-141f-b21412336574@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

On 10/31/2016 3:16 PM, Rafa? Mi?ecki wrote:
> On 31 October 2016 at 23:05, Scott Branden <scott.branden@broadcom.com> wrote:
>> On 16-10-31 02:56 PM, Florian Fainelli wrote:
>>> - fixups the aborts in the kernel, look where they come from, by using
>>> some bit of magic, looking at PCIe registers and whatnot (provided that
>>> is even possible), not too hard, but can take a while, and is error prone
>>
>> Option 4 sounds like the proper solution - check the range the abort is due
>> to the PCI device enumeration and only ignore those aborts.
> 
> This was already suggested by Arnd:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422873.html
> and Ray was checking some internal datasheets, but I'm afraid he never
> found info on checking if error was caused by PCIe controller.
> 

Correct. Based on response from our ASIC team, on Northstar, 1) we
cannot distinguish between various external imprecise aborts; 2) nor can
we use the internal PCIe controller register to disable unsupported
request from being forwarded as APB bus error (and therefore causes the
abort).

All subsequent iProc SoCs can disable this error forwarding from the
iProc PCIe controller.

> Maybe we could think about some BCM5301X API (extra symbol exported by
> arch code) for starting ignoring aborts and stopping that. We could
> ignore aborts during scanning only but honestly it sounds like a bit
> hacky solution to me.
> 
> 

Correct, one possible solution is to only ignoring the aborts during
condiguration space register access of an endpoint device. Below is the
logic how I only disable the APB bus error forwarding during these
accesses (for all other iProc SoCs):

+/**
+ * APB error forwarding can be disabled during access of configuration
+ * registers of the endpoint device, to prevent unsupported requests
+ * (typically seen during enumeration with multi-function devices) from
+ * triggering a system exception
+ */
+static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
+					      bool disable)
+{
+	struct iproc_pcie *pcie = iproc_data(bus);
+	u32 val;
+
+	if (bus->number && pcie->has_apb_err_disable) {
+		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_APB_ERR_EN);
+		if (disable)
+			val &= ~APB_ERR_EN;
+		else
+			val |= APB_ERR_EN;
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_APB_ERR_EN, val);
+	}
+}
+
[...]
+static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int
devfn,
+				    int where, int size, u32 *val)
+{
+	int ret;
+
+	iproc_pcie_apb_err_disable(bus, true);
+	ret = pci_generic_config_read32(bus, devfn, where, size, val);
+	iproc_pcie_apb_err_disable(bus, false);
+
+	return ret;
+}
+
+static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int
devfn,
+				     int where, int size, u32 val)
+{
+	int ret;
+
+	iproc_pcie_apb_err_disable(bus, true);
+	ret = pci_generic_config_write32(bus, devfn, where, size, val);
+	iproc_pcie_apb_err_disable(bus, false);
+
+	return ret;
+}
+
 static struct pci_ops iproc_pcie_ops = {
 	.map_bus = iproc_pcie_map_cfg_bus,
-	.read = pci_generic_config_read32,
-	.write = pci_generic_config_write32,
+	.read = iproc_pcie_config_read32,
+	.write = iproc_pcie_config_write32,
 };

>>> I can certainly advocate that option 3 is the one that gives a working
>>> device, and this is what matters from a distribution perspective like
>>> LEDE/OpenWrt.
>>>
>> Since I don't use BCM5301x option 3 is fine by me.
> 
> So for it seems like the best solution to me, but I'm open for changes
> if someone points another that is clean & better one.
> 

I agree with that option 3 is probably the best solution for now, from a
distribution's perspective.

Thanks,

Ray
