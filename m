From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 15:40:38 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
Message-ID: <20161108154038.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 03:11:07PM +0000, Sudeep Holla wrote:
> On 08/11/16 14:51, Russell King - ARM Linux wrote:
> >On Wed, Nov 02, 2016 at 10:52:03PM -0600, Sudeep Holla wrote:
> >>This is minor rework of the series[1] from Neil Armstrong's to support
> >>legacy SCPI protocol to make DT bindings more generic and move out all
> >>the platform specific bindings out of the generic binding document.
> >
> >Is this what would be in my HBI0282B Juno?
> >
> 
> No, it's one on the AmLogic Meson GXBB platform. Juno never supported
> that except that old firmware use it internally. By that I mean some
> version of trusted firmware used legacy SCPI but they are generally
> bundled together in fip, so you should not see any issue with upgrade.

I was wondering whether it'd work with my existing 1st September 2014
version of the trusted firmware.  I've pretty much come to the
conclusion that there's no way I can run the later firmware on this
hardware.

> I am currently trying to run Linaro 16.10 release, I don't see any issue
> except network boot from UEFI which is known and reported.

Interesting - maybe the hardware is different then?

> I will go through your logs in detail and try to replicate your issue.
> I assume you have tried replacing the entry contents of the uSD with the
> release. I will start with that now.

I haven't wiped it and copied the entire contents of the zip file over.
I instead backed up the old board.txt and images.txt files, and copied
the HBI0282B directories on top of the others.

This correctly causes all the various components to be updated when the
board boots, updating the MBB BIOS, iofpga, and reprogramming the NOR
flash with the updated images.  I even diff'd what was on the uSD card
and what was supplied in the zip file.

That's one state I tested: it also allowed me to edit the board.txt and
similar to wind back to what I have now on the board - which is all the
old versions of the firmware except for the MBB BIOS.

Anyway, I've wiped the uSD, and copied the contents of the 16.10 release
over:


ARM V2M-Juno Boot loader v1.0.0
HBI0262 build 1872

ARM V2M_Juno Firmware v1.4.4
Build Date: Jul 26 2016

Time :  15:18:35
Date :  08:11:2016

Cmd> usb_on
Enabling debug USB...

Cmd> reboot

Powering up system...

Switching on ATXPSU...
PMIC RAM configuration (pms_v103.bin)...
MBtemp   : 26 degC

Configuring motherboard (rev B, var B)...
IOFPGA image \MB\HBI0262B\io_b118.bit
IOFPGA  config: PASSED
OSC CLK config: PASSED

Configuring SCC registers...
Writing SCC 0x00000054 with 0x0007FFFE
Writing SCC 0x0000005C with 0x00FE001E
Writing SCC 0x00000100 with 0x003F1000
Writing SCC 0x00000104 with 0x0001F300
Writing SCC 0x00000108 with 0x00371000
Writing SCC 0x0000010C with 0x0001B300
Writing SCC 0x00000118 with 0x003F1000
Writing SCC 0x0000011C with 0x0001F100
Writing SCC 0x000000F8 with 0x0BEC0000
Writing SCC 0x000000FC with 0xABE40000
Writing SCC 0x0000000C with 0x000000C2
Writing SCC 0x00000010 with 0x000000C2

Peripheral ID0:0x000000AD
Peripheral ID1:0x000000B0
Peripheral ID2:0x0000000B
Peripheral ID3:0x00000000
Peripheral ID4:0x0000000D
Peripheral ID5:0x000000F0
Peripheral ID6:0x00000005
Peripheral ID7:0x000000B1

Programming NOR Flash
Erasing Flash image Image
........................................
Erasing Flash image juno
.
Erasing Flash image fip
.....
Erasing Flash
......
Writing File fip to Flash Address 0x08000000
.............
Image: fip UPDATED from \SOFTWARE\fip.bin
Erasing Flash image bl1
.
Erasing Flash
.
Writing File bl1 to Flash Address 0x0BEC0000

Image: bl1 UPDATED from \SOFTWARE\bl1.bin
Erasing Flash
.
Writing File norkern to Flash Address 0x08500000

Image: norkern UPDATED from \SOFTWARE\Image
Erasing Flash
.
Writing File board.dtb to Flash Address 0x0A700000

Image: board.dtb UPDATED from \SOFTWARE\juno.dtb
Erasing Flash image ramdisk.img
.
Erasing Flash
.
Writing File ramdisk.img to Flash Address 0x09800000

Image: ramdisk.img UPDATED from \SOFTWARE\ramdisk.img
Erasing Flash image hdlcdclk
.
Erasing Flash
.
Writing File hdlcdclk to Flash Address 0x0A5C0000

Image: hdlcdclk UPDATED from \SOFTWARE\hdlcdclk.dat
Erasing Flash
.
Writing File bl0 to Flash Address 0x0BE40000

Image: bl0 UPDATED from \SOFTWARE\bl0.bin
Erasing Flash
.
Writing File startup.nsh to Flash Address 0x0BF00000

Image: startup.nsh UPDATED from \SOFTWARE\startup.nsh
Erasing Flash
....
Writing File BOOTENV to Flash Address 0x0BFC0000
.
Image: BOOTENV UPDATED from \SOFTWARE\blank.img
Erasing Flash
.
Writing File selftest to Flash Address 0x0A600000
..
Image: selftest UPDATED from \SOFTWARE\selftest
PCIE clock configured...

Testing motherboard interfaces (FPGA build 118)...
SRAM 32MB test: PASSED
LAN9118   test: PASSED
KMI1/2    test: PASSED
MMC       test: PASSED
PB/LEDs   test: PASSED
FPGA UART test: PASSED
PCIe init test: PASSED
MAC addrs test: PASSED

SMC MAC address 0002-F700-5A7B
Setting HDMI0 mode for SVGA.
Setting HDMI1 mode for SVGA.

SoC SMB clock enabled.

Testing SMB clock...
SMB clock running
Releasing system resets...

UART0 set to SoC UART0
UART1 set to SoC UART1

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.2(debug):99e8937
NOTICE:  BL1: Built : 12:57:25, Nov  1 2016
INFO:    BL1: RAM 0x4037000 - 0x4040000
INFO:    Using crypto library 'mbed TLS'
INFO:    BL1: Loading BL2
INFO:    Loading image id=6 at address 0x4006000
INFO:    Skip reserving region [base = 0x4006000, size = 0x37f]
INFO:    Image id=6 loaded at address 0x4006000, size = 0x37f
INFO:    Loading image id=1 at address 0x4006000
INFO:    Image id=1 loaded at address 0x4006000, size = 0x11158
NOTICE:  BL1: Booting BL2
INFO:    Entry point address = 0x4006000
INFO:    SPSR = 0x3c5
NOTICE:  BL2: v1.2(debug):99e8937
NOTICE:  BL2: Built : 12:57:25, Nov  1 2016
INFO:    Using crypto library 'mbed TLS'
INFO:    BL2: Loading SCP_BL2
INFO:    Loading image id=7 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0x5ae]
INFO:    Image id=7 loaded at address 0x4023000, size = 0x5ae
INFO:    Loading image id=8 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0x47a]
INFO:    Image id=8 loaded at address 0x4023000, size = 0x47a
INFO:    Loading image id=12 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0x389]
INFO:    Image id=12 loaded at address 0x4023000, size = 0x389
INFO:    Loading image id=2 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0xf334]
INFO:    Image id=2 loaded at address 0x4023000, size = 0xf334
INFO:    BL2: Initiating SCP_BL2 transfer to SCP
INFO:    BL2: SCP_BL2 transferred to SCP
INFO:    Configuring TrustZone Controller
INFO:    BL2: Loading BL31
INFO:    Loading image id=9 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0x47a]
INFO:    Image id=9 loaded at address 0x4023000, size = 0x47a
INFO:    Loading image id=13 at address 0x4023000
INFO:    Skip reserving region [base = 0x4023000, size = 0x389]
INFO:    Image id=13 loaded at address 0x4023000, size = 0x389
INFO:    Loading image id=3 at address 0x4023000
INFO:    Image id=3 loaded at address 0x4023000, size = 0xc020
INFO:    BL2: Loading BL32
INFO:    Loading image id=10 at address 0xff000000
INFO:    Skip reserving region [base = 0xff000000, size = 0x488]
INFO:    Image id=10 loaded at address 0xff000000, size = 0x488
INFO:    Loading image id=14 at address 0xff000000
INFO:    Skip reserving region [base = 0xff000000, size = 0x397]
INFO:    Image id=14 loaded at address 0xff000000, size = 0x397
INFO:    Loading image id=4 at address 0xff000000
INFO:    Image id=4 loaded at address 0xff000000, size = 0x3c0a0
INFO:    BL2: Loading BL33
INFO:    Loading image id=11 at address 0xe0000000
INFO:    Skip reserving region [base = 0xe0000000, size = 0x48b]
INFO:    Image id=11 loaded at address 0xe0000000, size = 0x48b
INFO:    Loading image id=15 at address 0xe0000000
INFO:    Skip reserving region [base = 0xe0000000, size = 0x39a]
INFO:    Image id=15 loaded at address 0xe0000000, size = 0x39a
INFO:    Loading image id=5 at address 0xe0000000
INFO:    Image id=5 loaded at address 0xe0000000, size = 0xf0000
NOTICE:  BL1: Booting BL31
INFO:    Entry point address = 0x4023000
INFO:    SPSR = 0x3cd
NOTICE:  BL31: v1.2(debug):99e8937
NOTICE:  BL31: Built : 12:57:25, Nov  1 2016
INFO:    ARM GICv2 driver initialized
INFO:    BL31: Initializing runtime services
INFO:    BL31: Initializing BL32
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0xe0000000
INFO:    SPSR = 0x3c9
UEFI firmware (version f51ab72 built at 12:57:40 on Nov  1 2016)
add-symbol-file /home/buildslave/workspace/armlt-platforms-release/workspace-pinned-uefi/uefi/edk2/Build/ArmJuno/DEBUG_GCC49/AARCH64/ArmPlatformPkg/PrePi/PeiUniCore/DEBUG/ArmPlatformPrePiUniCore.dll 0xE0000800
add-symbol-file /home/buildslave/workspace/armlt-platforms-release/workspace-pinned-uefi/uefi/edk2/Build/ArmJuno/DEBUG_GCC49/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll 0xFE03C000
Loading DxeCore at 0x00FE03B000 EntryPoint=0x00FE03C000
add-symbol-file /home/buildslave/workspace/armlt-platforms-release/workspace-pinned-uefi/uefi/edk2/Build/ArmJuno/DEBUG_GCC49/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll 0xFE03C000
HOBLIST address in DXE = 0xFDDFE018
Memory Allocation 0x00000004 0xFEFEA000 - 0xFEFEAFFF
Memory Allocation 0x00000004 0xFEFE9000 - 0xFEFE9FFF
Memory Allocation 0x00000004 0xFEFE8000 - 0xFEFE8FFF
Memory Allocation 0x00000004 0xFEFE7000 - 0xFEFE7FFF
Memory Allocation 0x00000004 0xFEFE6000 - 0xFEFE6FFF
Memory Allocation 0x00000004 0xFEFE5000 - 0xFEFE5FFF
Memory Allocation 0x00000004 0xFEFE4000 - 0xFEFE4FFF
Memory Allocation 0x00000004 0xFEFE3000 - 0xFEFE3FFF
Memory Allocation 0x00000004 0xFEFEB000 - 0xFEFFFFFF
Memory Allocation 0x00000004 0xFEFD3000 - 0xFEFE2FFF
Memory Allocation 0x00000004 0xFE827000 - 0xFEFD2FFF
Memory Allocation 0x00000004 0xFE07B000 - 0xFE826FFF
Memory Allocation 0x00000004 0xFE03B000 - 0xFE07AFFF
Memory Allocation 0x00000003 0xFE03B000 - 0xFE07AFFF
FV Hob            0xE0000000 - 0xE00EFFFF
FV Hob            0xFE07B000 - 0xFE8253BF
FV2 Hob           0xFE07B000 - 0xFE8253BF

which looks more hopeful... except it stops there.

As it contains a zero sized Image and .dtb files, I tried copying my
Image and .dtb over, and also copied my original config.txt (only
change is AUTORUN: FALSE).  It still doesn't appear to boot beyond
this point.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
