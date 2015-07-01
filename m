From: james.morse@arm.com (James Morse)
Date: Wed, 01 Jul 2015 15:26:33 +0100
Subject: [PATCH v3 2/5] PCI: designware: Add ARM64 support
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
Message-ID: <5593F899.6050306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zhou Wang wrote:
> I tested this patch on D02 board of Hisilicon. It works well.
> I have compiled the driver with multi_v7_defconfig. However, I don't
> have
> ARM32 PCIe related board to do test. It will be appreciated if someone
> could
> help to test it.
>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Tested-by: James Morse <james.morse@arm.com>

Tests on this new series, using the same i.MX 6Quad board, are not working.

The network card is no longer detected, and I get a lockup when removing
the root bridge and rescanning.

Partial dmesg output below. Significantly, the lines:
> [    0.152128] PCI host bridge /soc/pcie at 0x01000000 ranges:
> [    0.152142]   No bus range found for /soc/pcie at 0x01000000, using [bus
00-ff]
are new.

Both series are applied to v4.1, use the same .config file, and the same dtb.
I will investigate further.

(Re-testing v2 works, so this isn't an interim hardware failure)

Thanks,

James



root at localhost:~# dmesg | grep -i pci
[    0.126184] PCI: CLS 0 bytes, default 64
[    0.152128] PCI host bridge /soc/pcie at 0x01000000 ranges:
[    0.152142]   No bus range found for /soc/pcie at 0x01000000, using [bus 00-ff]
[    0.154183] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.154201] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.154215] pci_bus 0000:00: root bus resource [???
0x01f00000-0x01f7ffff flags 0x0]
[    0.154228] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.154270] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.154306] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.154333] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.154352] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.154377] pci 0000:00:00.0: IOMMU is currently not supported for PCI
[    0.154429] pci 0000:00:00.0: supports D1
[    0.154440] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.154683] PCI: bus0: Fast back to back transfers disabled
[    0.154806] PCI: bus1: Fast back to back transfers enabled
[    0.154884] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.154903] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff
pref]
[    0.154917] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.155145] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    0.155161] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
[    0.155279] aer 0000:00:00.0:pcie02: service driver aer loaded
[    1.188840] ehci-pci: EHCI PCI platform driver
[    1.232518] ohci-pci: OHCI PCI platform driver
