From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Sun,  3 May 2015 17:27:35 +0300
Subject: [PATCH v3 0/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
Message-ID: <1430663256-22714-1-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased and fixed against 4.1-rc1
This is the resubmit of the patch with fixes based on reviews by Andrew Lunn
and Sebastian Hesselbarth

It looks like UART1 MPP defaults (mpp41, mpp42) introduced in 
f8afeaea9611b5183b7919de4fb9333dedc72896 don't play well with DNS-327L and 
break both ttyS1 and NAND if used.
I have fixed the mappings for DNS-327L in this patch

Changelog since last respin: 
* All the style fixes
* pinctrl fixes for uart1

Fixed and updated description of the patch from my first email follows.

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


Andrew Andrianov (1):
  ARM: mvebu: dts: Add dts file for DLink DNS-327L

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  349 ++++++++++++++++++++++++
 2 files changed, 350 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts

-- 
1.7.10.4
