From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Sun, 12 Apr 2015 14:25:42 +0300
Subject: [PATCH v2 0/2] ARM: mvebu: Add support for DLINK DNS-327L
In-Reply-To: <20150411214547.GK5244@lunn.ch>
Message-ID: <1428837944-28150-1-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased against 4.0-rc7
This is the resubmit of the patchset with fixes based on review by Andrew Lunn
In my previous email I've wrongly referenced power button (in email, dts was okay) 
as mpp63, it's really mpp65 (mpp63 is the 'backup' button). 
Fixed and updated description of the patchset from my first email follows.

DNS-327L is a 2-bay NAS with the following specs:     
     - 512MiB RAM
     - 128MiB NAND Flash
     - 1 GbE interface (Marvell PHY)
     - 1 rear USB 3.0 port (via PCIe USB 3.0 controller)
     - 2 internal SATA ports handled by the Armada 370: 
       	 uses 2 gpios for power control
     - two front 2-color leds (amber + white) for both discs, 
        controlled by the SoC
     - One white LED handled by SoC (USB)
     - 3 buttons. Power handled by weltrend, USB and 
       RESET (on the bottom) are wired via GPIOs 
     - Unidentified i2c device at address 0x13 (via i2cdetect)
     - UART0 providing serial console
     - Weltrend MCU serving for RTC, temperature, fan control, 
       and power button handling interfaced via UART1 
       (Handled via userspace dns320l-daemon)

Hardware notes follow: 
Everything's supported, save for mysterious i2c device at 
address 0x13 (any ideas what can it be?) that I couldn't even find 
on the PCB.

Stock firmware performs some messing with PHY registers (that 
have no public documentation) using a userspace script. Using 
upstream kernel it is possible to match the stock behavior using 
the following in u-boot prompt:

/* Set RGMII voltage to 1.8v, according to public docs. Nice! */
mw.l 0xd00184e0 0xa8a; 
/* Some weird magic that goes into phy registers, no public docs */
phyWrite 0 16 2; 
phyWrite 0 19 77; 
phyWrite 0 18 5747; 

When power button is long-pressed to turn the NAS off, weltrend signals 
the SoC by driving mpp65 line low.

'Backup' button is wired to gpio63. Apparently right now pinctrl assumes
that this line can only work as 'gpo' that screws up gpio-buttons driver.
Since without gpio-buttons, mpp63 works as input properly via sysfs 
interface, I've added a patch for pinctrl-armada-370.c that fixes the 
issue.

Andrew Andrianov (2):
  pinctrl: mvebu: Fix mapping of pin 63 (gpo -> gpio)
  ARM: mvebu: dts: Add dts file for DLink DNS-327L

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  344 ++++++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-armada-370.c     |    2 +-
 3 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts

-- 
1.7.10.4
