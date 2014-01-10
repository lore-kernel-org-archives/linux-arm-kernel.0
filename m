From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Jan 2014 15:43:46 +0100
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <52D005E1.6000308@killerwolves.net>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net> <20140109165557.GB9681@lunn.ch>
 <52CF4652.3030207@killerwolves.net>
 <20140110112846.GG27432@n2100.arm.linux.org.uk>
 <52CFFF07.5080806@killerwolves.net> <20140110142548.GG9681@lunn.ch>
 <52D005E1.6000308@killerwolves.net>
Message-ID: <20140110144346.GH9681@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 12:38:25AM +1000, Ben Peddell wrote:
> On 11/01/14 00:25, Andrew Lunn wrote:
> > On Sat, Jan 11, 2014 at 12:09:11AM +1000, Ben Peddell wrote:
> >> On 10/01/14 21:28, Russell King - ARM Linux wrote:
> >>> On Fri, Jan 10, 2014 at 11:01:06AM +1000, Ben Peddell wrote:
> >>>> It appears the initrd address in the devicetree structure (which is 
> >>>> filled in from what is passed by the bootloader when 
> >>>> CONFIG_ARM_ATAG_DTB_COMPAT is set) is processed _after_ the address in 
> >>>> the initrd= kernel parameter is processed.
> >>>
> >>> That's wrong.  Kernel parameters should always override what's passed by
> >>> boot loaders etc.
> >>
> >> In that case, what I saw was a bug - note that this only occurs when
> >> DeviceTree is enabled:
> >>
> >>
> >>          __  __                      _ _
> >>         |  \/  | __ _ _ ____   _____| | |
> >>         | |\/| |/ _` | '__\ \ / / _ \ | |
> >>         | |  | | (_| | |   \ V /  __/ | |
> >>         |_|  |_|\__,_|_|    \_/ \___|_|_|
> >>  _   _     ____              _
> >> | | | |   | __ )  ___   ___ | |_
> >> | | | |___|  _ \ / _ \ / _ \| __|
> >> | |_| |___| |_) | (_) | (_) | |_
> >>  \___/    |____/ \___/ \___/ \__|  ** LOADER **
> >>  ** MARVELL BOARD: Synology Disk Station LE
> >>
> >> U-Boot 1.1.4 (Jul  6 2010 - 19:26:08) Marvell version: 3.4.4
> >>
> >> U-Boot code: 00600000 -> 0067FFF0  BSS: -> 0068B43C
> >>
> >> Soc: 88F6281 A1 (DDR2)
> >> CPU running @ 1200Mhz L2 running @ 480Mhz
> >> SysClock = 400Mhz , TClock = 200Mhz
> >>
> >> DRAM CAS Latency = 6 tRP = 6 tRAS = 18 tRCD=6
> >> DRAM CS[0] base 0x00000000   size 128MB
> >> DRAM Total size 128MB  16bit width
> >> [4096kB at f8000000] Flash:  4 MB
> >> Addresses 8M - 0M are saved for the U-Boot usage.
> >> Mem malloc Initialization (8M - 7M): Done
> >> Using default environment
> >>
> >>
> >> CPU : Marvell Feroceon (Rev 1)
> >>
> >> Streaming disabled
> >> Write allocate disabled
> >>
> >> Module 1 is AUDIO
> >>
> >> USB 0: host mode
> >>
> >> Synology Model: DS211j
> >> Fan Status: Good
> >>
> >> Net:   egiga0 [PRIME]
> >> Hit any key to stop autoboot:  0
> >> Marvell>> setenv ipaddr 192.168.200.62
> >> Marvell>> setenv serverip 192.168.200.16
> >> Marvell>> tftp 0x01000000 uImage-3.13-rc7-ds211j-git-fdt
> >> Using egiga0 device
> >> TFTP from server 192.168.200.16; our IP address is 192.168.200.62
> >> Filename 'uImage-3.13-rc7-ds211j-git-fdt'.
> >> Load address: 0x1000000
> >> Loading: #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #########################################################
> >> done
> > 
> > So here you load the kernel into RAM at 0x0100 0000.
> > 
> > 
> >> Bytes transferred = 1954736 (1dd3b0 hex)
> >> Marvell>> setenv bootargs console=ttyS0,115200 ip=off initrd=0x00800040,0x0013FFC0 root=/dev/md0 rw syno_hw_version=DS211j ihd_num=2 netif_num=1 earlyprintk
> > 
> > I don't see you loading the initrd into RAM at 0x0080 0000.
> 
> See below
> 
> > 
> >> Marvell>> bootm 0x01000000 0xf8280000
> > 
> > And here you tell it the initrd is at 0xf8280000.
> 
> This is because I am using the initrd in flash.
> 
> > 
> >> ## Booting image at 01000000 ...
> >> Bad Magic Number
> >> Marvell>> tftp 0x01000000 uImage-3.13-rc7-ds211j-git-fdt
> >> Using egiga0 device
> >> TFTP from server 192.168.200.16; our IP address is 192.168.200.62
> >> Filename 'uImage-3.13-rc7-ds211j-git-fdt'.
> >> Load address: 0x1000000
> >> Loading: #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #################################################################
> >>          #########################################################
> >> done
> >> Bytes transferred = 1954800 (1dd3f0 hex)
> >> Marvell>> bootm 0x01000000 0xf8280000
> >> ## Booting image at 01000000 ...
> >>    Image Name:   linux-3.13-rc7-ds211j+
> >>    Image Type:   ARM Linux Kernel Image (uncompressed)
> >>    Data Size:    1954736 Bytes =  1.9 MB
> >>    Load Address: 00008000
> >>    Entry Point:  00008000
> >>    Verifying Checksum ... OK
> >> OK
> >> ## Loading Ramdisk Image at f8280000 ...
> >>    Image Name:   altair-boot
> >>    Image Type:   ARM Linux RAMDisk Image (unknown compression)
> >>    Data Size:    1022268 Bytes = 998.3 kB
> >>    Load Address: 00800000
> >>    Entry Point:  00800000
> >>    Verifying Checksum ... OK
> 
> Here the bootloader copies the initrd to 0x00800040, yet passes
> 0xf8280040 to the kernel.

But does it pass 0xf8280040 because you used:

bootm 0x01000000 0xf8280000

What happens if you use

bootm 0x01000000 0x00800000

      Andrew
