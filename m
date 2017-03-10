From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 10 Mar 2017 17:34:24 +0530
Subject: [RESEND PATCH v3 5/7] PCI: dwc: all: Modify dbi accessors to
 access data of 4/2/1 bytes
In-Reply-To: <a56e462d-83ee-194f-1f9f-3f4c339cad46@axis.com>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-6-git-send-email-kishon@ti.com>
 <a56e462d-83ee-194f-1f9f-3f4c339cad46@axis.com>
Message-ID: <58C29648.5020708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 09 March 2017 08:18 PM, Niklas Cassel wrote:
> On 03/09/2017 07:39 AM, Kishon Vijay Abraham I wrote:
>> Previously dbi accessors can be used to access data of size 4
>> bytes. But there might be situations (like accessing
>> MSI_MESSAGE_CONTROL in order to set/get the number of required
>> MSI interrupts in EP mode) where dbi accessors must
>> be used to access data of size 2. This is in preparation for
>> adding endpoint mode support to designware driver.
> 
> Hello Kishon
> 
> I don't really like the idea of adding an extra argument to every existing read/write.
> Will not a read/write of length != 32 be quite uncommon compared to
> a read/write of length == 32?
> 
> How about adding some defines to pcie-designware.h:
> 
> #define dw_pcie_writel_dbi(pci, base, reg, val) dw_pcie_write_dbi(pci, base, reg, 0x4, val)
> #define dw_pcie_readl_dbi(pci, base, reg) dw_pcie_read_dbi(pci, base, reg, 0x4)
> 
> That way we don't have to change every existing read/write.
> 
> 
> 
> Is there a reason why we can't just do:
> 
> vial = dw_pcie_readl_dbi(pci, base, MSI_MESSAGE_CONTROL);

MSI_MESSAGE_CONTROL is 0x52 (MSI capability offset + 2). I'm not sure if we can
do a readl that crosses the alignment boundary in all platforms. The other
option is to readl from "MSI capability offset + 0" and extract the last 16
bits. I felt this is more clear since we are interested only in the
MSI_MESSAGE_CONTROL.

> <shifting+masking the bits we need to get/set>
> dw_pcie_writel_dbi(pci, base, MSI_MESSAGE_CONTROL, val);
> 
> Or are we going to be doing read/writes of length != 32 so often that
> you think that it's cleaner to have this abstraction?

it's used mainly for accessing configuration space header fields. Even the pci
core uses *pci_read_config_word* for accessing such fields.

Thanks
Kishon
