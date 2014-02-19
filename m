From: monstr@monstr.eu (Michal Simek)
Date: Wed, 19 Feb 2014 09:54:38 +0100
Subject: [PATCH] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CAErSpo5FGPhgnp8Gfy-1_Lk7ckCi7U5+z5pLnPU+jScPxD5yUQ@mail.gmail.com>
References: <1392564830-5868-1-git-send-email-sthokal@xilinx.com>
 <CAErSpo5FGPhgnp8Gfy-1_Lk7ckCi7U5+z5pLnPU+jScPxD5yUQ@mail.gmail.com>
Message-ID: <5304714E.7070900@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 10:32 PM, Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> On Sun, Feb 16, 2014 at 8:33 AM, Srikanth Thokala <sthokal@xilinx.com> wrote:
>> This is the driver for Xilinx AXI PCIe Host Bridge Soft IP
>>
>> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
>> ---
>> - Rebased on v3.14.0-rc2
>> ---
>>  .../devicetree/bindings/pci/xilinx-pcie.txt        |   43 +
>>  drivers/pci/host/Kconfig                           |    7 +
>>  drivers/pci/host/Makefile                          |    1 +
>>  drivers/pci/host/pci-xilinx.c                      |  985 ++++++++++++++++++++
>>  4 files changed, 1036 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>>  create mode 100644 drivers/pci/host/pci-xilinx.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>> new file mode 100644
>> index 0000000..66a2487
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
>> @@ -0,0 +1,43 @@
>> +* Xilinx AXI PCIe Root Port Bridge DT description
>> +
>> +Required properties:
>> +- #address-cells: Address representation for root ports, set to <3>
>> +- #size-cells: Size representation for root ports, set to <2>
>> +- compatible: Should contain "xlnx,axi-pcie-1.00.a"
>> +- reg: Should contain AXI PCIe registers location and length
>> +- interrupts: Should contain AXI PCIe interrupt
>> +- ranges: ranges for the PCI memory regions
>> +       Please refer to the standard PCI bus binding document for a more
>> +       detailed explanation
>> +- xlnx,axibar-num: Number of memory regions configured in the hardware,
>> +       maximum being three which is configurable in the hardware.
>> +- xlnx,include-rc: Root Port (=1) or End Point (=0)
>> +- xlnx,pciebar2axibar-0: Translation address from PCIe to AXI
>> +       Only one PCIe BAR is applicable in Root port mode, it can be
>> +       either 32/64-bit. If it is 64-bit BAR, lower 32 bits are present
>> +       in 'xlnx,pciebar2axibar-0' and Upper 32 bits in 'xlnx,pciebar2
>> +       axibar-1'. And if it is 32-bit BAR, only 'xlnx,pciebar2axibar-0'
>> +       is valid
>> +
>> +Optional properties
>> +- xlnx,pciebar-as: PCIe BAR aperture size is 32 (=0) or 64-bit (=1).
>> +- xlnx,pciebar2axibar-1: Translation address from PCIe to AXI, contains
>> +       upper 32 bits if PCIe BAR size is 64-bit. When xlnx,pciebar-as
>> +       is set, this is a required property and should contain a valid
>> +       value (other than FF's)
> 
> I hardly know anything about DT, but xlnx,pciebar2axibar-0,
> xlnx,pciebar-as, and xlnx,pciebar2axibar-1 look strange to me.  Is
> that really the DT way of dealing with 32/64-bit BARs and host bridge
> address translation?  I don't see similar things in the other files in
> Documentation/devicetree/bindings/pci/, even though some of the other
> drivers/pci/host/*.c files do use pci_add_resource_offset(), which
> indicates that they support address translation.

This is how xilinx is describing hardware in design tools.
And as Arnd already know this is full IP description with all options
which can be selected.
If there is any standard way how to describe it we can change it.

> Please also include a MAINTAINERS update for drivers/pci/host/pci-xilinx.c.

This should be handle by our record that's why MAINTAINERS update is not necessary.
(N: xilinx below)

ARM/ZYNQ ARCHITECTURE
M:	Michal Simek <michal.simek@xilinx.com>
L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
W:	http://wiki.xilinx.com
T:	git git://git.xilinx.com/linux-xlnx.git
S:	Supported
F:	arch/arm/mach-zynq/
F:	drivers/cpuidle/cpuidle-zynq.c
N:	zynq
N:	xilinx
F:	drivers/clocksource/cadence_ttc_timer.c
F:	drivers/mmc/host/sdhci-of-arasan.c

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/dfaa0601/attachment.sig>
