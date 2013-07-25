From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 16:25:25 +0900
Subject: Mainline kernel on snowball
In-Reply-To: <20130725054036.GD31954@1wt.eu>
References: <20130725052317.GA25854@verge.net.au>
 <20130725054036.GD31954@1wt.eu>
Message-ID: <20130725072525.GC7654@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 07:40:36AM +0200, Willy Tarreau wrote:
> Hi Simon,
> 
> On Thu, Jul 25, 2013 at 02:23:17PM +0900, Simon Horman wrote:
> > Hi,
> > 
> > I apologise for the na?ve nature of this question,
> > but I do not seem to be able to make any progress of my own accord.
> > 
> > I would like to boot the mainline kernel - ideally v3.10 and v3.11-rcX -
> > on snowball. The reason being to verify CPU hotplug which
> > seems to be broken on shmobile, though that is tangential to this post.
> > 
> > My procedure, which does not work, is as follows.
> > I have tried a number of different versions all with roughly
> > the same result.
> > 
> > 1. Build kernel
> > # git checkout v3.10.2 # I have tried several over versions too.
> > # make u8500_defconfig
> > Edit .config to enable CONFIG_ARM_APPENDED_DTB
> > # LOADADDR=0x100000 make uImage dtbs
> > 
> > 2. Append dtb to zImage and recreate uImage
> > mv arch/arm/boot/zImage arch/arm/boot/zImage.tmp
> > cat arch/arm/boot/zImage.tmp arch/arm/boot/dts/snowball.dtb
> > /bin/sh scripts/mkuboot.sh \
> > 	-A arm -O linux -C none  -T kernel \
> > 	-a 0x100000 -e 0x100000 -n 'Linux-3.10.2' \
> > 	-d arch/arm/boot/zImage arch/arm/boot/uImage
> > 
> > 3. Boot uImage from u-boot
> > Snowball $ setenv ethaddr 3e:c4:73:05:d1:a1
> > Snowball $ bootp;bootm
> > smc911x: detected LAN9221 controller
> > smc911x: phy initialized
> > smc911x: MAC 3e:c4:73:05:d1:a1
> > BOOTP broadcast 1
> > *** Unhandled DHCP Option in OFFER/ACK: 28
> > *** Unhandled DHCP Option in OFFER/ACK: 44
> > *** Unhandled DHCP Option in OFFER/ACK: 28
> > *** Unhandled DHCP Option in OFFER/ACK: 44
> > DHCP client bound to address 10.3.3.146
> > Using smc911x-0 device
> > TFTP from server 10.3.3.135; our IP address is 10.3.3.146
> > Filename 'snowball/uImage'.
> > Load address: 0x100000
> > Loading: #################################################################
> >          #################################################################
> >          #################################################################
> >          #################################################################
> >          ##########################################################
> > done
> > Bytes transferred = 2540191 (26c29f hex)
> > ## Booting kernel from Legacy Image at 00100000 ...
> >    Image Name:   'Linux-3.10.2'
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2540127 Bytes =  2.4 MB
> >    Load Address: 00100000
> >    Entry Point:  00100000
> >    XIP Kernel Image ... OK
> > OK
> > 
> > Starting kernel ...
> > 
> > 
> > This is as far as it gets.
> 
> Are you sure you have the correct bootargs by default ? It was a
> pain for me to figure the correct ones, and I finally found them
> in the boot scripts. Mine is booted with this :
> 
> # cat /proc/cmdline 
> console=tty0 console=ttyAMA2,115200n8  root=UUID=018e1580-e7e9-460b-95c5-236f6b87b13d rootwait ro fixrtc nocompcache vmalloc=300M mem=128M at 0 mali.mali_mem=64M at 128M hwmem=168M at 192M mem=22M at 360M mem_issw=1M at 383M mem=640M at 384M

Thanks. Rummaging around in the environment present in uboot I came up with
the following:

bootargs=cachepolicy=writealloc noinitrd init=init board_id=1 crashkernel=crashkernel=1M at 0x5600000 logo.nologo startup_graphics=1 mpcore_wdt.mpcore_margin=359 loglevel=8 console=ttyAMA2,115200n8 mem=128M at 0 mali.mali_mem=64M at 128M
mem=24M at 192M hwmem=167M at 216M mem_issw=1M at 383M mem=640M at 384M vmalloc=256M

Unfortunately neither this, nor the boot args you are using seem
to get me any further.

> # uname -a
> Linux snowball 3.10.0-rc5-snowball #2 SMP Fri Jun 14 09:19:28 CEST 2013 armv7l GNU/Linux
> 
> I don't have the CONFIG_ARM_APPENDED_DTB set, instead I have copied
> the dtb on the flash since u-boot supports it (I find this boot
> procedure quite annoying btw).

Thanks.

I have now also tried the following without CONFIG_ARM_APPENDED_DTB set.

Snowball $ setenv ethaddr 3e:c4:73:05:d1:a1
Snowball $ bootp 
smc911x: detected LAN9221 controller
smc911x: phy initialized
smc911x: MAC 3e:c4:73:05:d1:a1
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
DHCP client bound to address 10.3.3.146
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.146
Filename 'snowball/uImage'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################################################
done
Bytes transferred = 2540999 (26c5c7 hex)
Snowball $ tftp 0xf00000 snowball/snowball.dtb
smc911x: detected LAN9221 controller
smc911x: phy initialized
smc911x: MAC 3e:c4:73:05:d1:a1
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.146
Filename 'snowball/snowball.dtb'.
Load address: 0xf00000
Loading: ###
done
Bytes transferred = 16722 (4152 hex)
Snowball $ bootm 0x100000 - 0xf00000
## Booting kernel from Legacy Image at 00100000 ...
   Image Name:   'Linux-3.10.2'
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2540935 Bytes =  2.4 MB
   Load Address: 00100000
   Entry Point:  00100000
   XIP Kernel Image ... OK
OK

Starting kernel ...
