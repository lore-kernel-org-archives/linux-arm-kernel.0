From: hancock@sedsystems.ca (Robert Hancock)
Date: Fri, 23 Nov 2018 16:17:05 -0600
Subject: iMX6 PCIe MSI issues
Message-ID: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am working with a custom FPGA PCI Express endpoint connected to an NXP
iMX6D processor running the 4.19.2 kernel. It seems happy using INTx
interrupts but when trying to enable MSI the device driver is not
receiving any interrupts.

>From some register poking I have figured out:
-the MSI address set on the PCIe device is correctly set in the iMX MSI
controller's MSI Controller Address register (0x1ffc820)
-the interrupt vectors are enabled in the MSI controller's Interrupt
Enable register (0x1ffc828)
-the interrupt vectors are not masked in the MSI controller's Interrupt
Mask register (0x1ffc82c)
-The MSI controller's Interrupt Status register (0x1ffc830) shows that
the requested interrupt vectors are pending
-In the ARM GIC, vector 152 (for msi_ctrl_int) is enabled in the IS
enable register (0x00a01110), but not set in the IS pending (0x00a01210)
or IS active (0x00a01310) registers
-Vector 152 is not masked in the GPC interrupt mask (0x00a01310)
-Vector 152 is not active in the GPC interrupt status (0x00a01310)

So it appears the MSI controller is receiving and recognizing the MSI
from the device, but the interrupt is not making it into the GIC for
some reason. If I manually set vector 152 to pending in the GIC, the
dw_handle_msi_irq handler in pci-designware-host.c does get called along
with the interrupt handler(s) for the PCIe device, so it appears the
chain from that point on is working:

# devmem 0x00a01210 32 0x1000000

I found someone else reporting this in 2014 with an unknown kernel
version on the NXP forums here, but with no resolution listed there:

https://community.nxp.com/thread/318307

Any ideas on what may be going wrong? My next step may be to try an
older kernel version to see if this got broken at some point.

-- 
Robert Hancock
Senior Software Developer
SED Systems
Email: hancock at sedsystems.ca
