From: victorascroft@gmail.com (victorascroft at gmail.com)
Date: Thu, 26 Mar 2015 14:04:45 +0530
Subject: [PATCH 00/12] USB: chipidea: patchset for performance improvement
In-Reply-To: <20150324122146.GC2293@shlinux2>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
 <20150324103253.GC4707@Sanchayan-Arch>
 <20150324122146.GC2293@shlinux2>
Message-ID: <20150326083445.GA4747@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On 15-03-24 20:21:47, Peter Chen wrote:
> On Tue, Mar 24, 2015 at 04:02:53PM +0530, victorascroft at gmail.com wrote:
> > Hello Peter, 
> > 
> > On 15-03-19 09:19:11, Peter Chen wrote:
> > > Hi all,
> > > 
> > > In this patch set, I add some interfaces for tuning the performance
> > > of chipidea usb driver. With this set, the USB performance can be improved
> > > at some user cases with suitable parameters. The main changes:
> > > 
> > > - Interface to tune interrupt threshold control, and set
> > > 'Immediate' for default value
> > > - The glue layer can disable stream mode according to USB role
> > > - Interface to tune AHB burst configuration at SBUSCFG
> > > - Interface to tune tx/rx burst size
> > > - i.mx changes for achieving better performance, it can reduce
> > >   the latecy between bus and USB FIFO, and reduce the overrun
> > >   and underrun occurrences, it is useful for the system bus is busy.
> > >   we see great improvement for ISO transfer, eg, high resolution
> > >   USB camera when the bus is busy.
> > > 
> > > Below are some test results at imx6sx sdb board
> > > (set ehci_hcd.park=3 at bootargs), the tests are done
> > > at v4.0 kernel, no other bus loading during the tests,
> > > so we have not seen performance change for some use cases.
> > > 
> > > USB Mass Storage (Host mode)
> > > With Patch Set		Without Patch Set
> > > R: 26.9 MB/s		27 MB/s
> > > W: 25.2 MB/s		24.5 MB/s
> > > 
> > > 1G USB Ethernet Card
> > > With Patch Set		Without Patch Set
> > > TX: 186 Mb/s		185 Mb/s
> > > RX: 219 Mb/s		216 Mb/s
> > > 
> > > g_ncm (Device Mode)
> > > With Patch Set		Without Patch Set
> > > TX: 166MB/s		163MB/s
> > > RX: 230MB/s		184MB/s
> > > 
> > 
> > I tested these patches on a Colibri Vybrid VF61. Have not applied the 
> > 7th and 11th patch, but, the changes these patches introduce, I added 
> > them to our device tree node. These would be  the addition of 
> > ahb-burst-config = <0x0> and tx-burst-size-dword = <0x10> and 
> > rx-burst-size-dword = <0x10> to the usb node in vfxxx.dtsi file for both 
> > the peripheral and host usb nodes.
> > 
> > I used hdparm and dd for the tests. Some of the readings are below.
> > 
> > With this patchset applied
> > 
> > Reads
> > hdparm -t --direct /dev/sda
> > 
> > /dev/sda:
> >  Timing O_DIRECT disk reads:  36 MB in  3.05 seconds =  11.80 MB/sec
> > 
> > Writes
> > root at colibri-vf:~# time dd if=/dev/zero bs=128k count=4096
> > of=/media/sda1/tmpfile
> > 4096+0 records in
> > 4096+0 records out
> > 
> > real    1m11.671s
> > user    0m0.010s
> > sys     0m10.130s
> > 
> > USB Client - RNDIS
> > 
> > root at colibri-vf:~# iperf -c 192.168.1.1
> > ------------------------------------------------------------
> > Client connecting to 192.168.1.1, TCP port 5001
> > TCP window size: 43.8 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 192.168.1.2 port 41317 connected with 192.168.1.1 port 5001
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0-10.0 sec   105 MBytes  88.2 Mbits/sec
> > 
> > Without this patchset applied
> > 
> > Reads
> > hdparm -t --direct /dev/sda
> > 
> > /dev/sda:
> >  Timing O_DIRECT disk reads:  78 MB in  3.06 seconds =  25.50 MB/sec
> > 
> > Writes
> > root at colibri-vf:~# time dd if=/dev/zero bs=128k count=4096
> > of=/media/sda1/tmpfil
> > 4096+0 records in
> > 4096+0 records out
> > 
> > real    0m43.807s
> > user    0m0.050s
> > sys     0m9.960s
> > 
> > USB Client - RNDIS
> > 
> > root at colibri-vf:~# iperf -c 192.168.1.1
> > ------------------------------------------------------------
> > Client connecting to 192.168.1.1, TCP port 5001
> > TCP window size: 43.8 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 192.168.1.2 port 49857 connected with 192.168.1.1 port 5001
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0-10.0 sec   138 MBytes   116 Mbits/sec
> > 
> > 
> > Perhaps I am missing something? I have the ehci_hcd.park=3 set.
> > 
> > root at colibri-vf:~# cat /proc/cmdline
> > ehci_hcd.park=3 ubi.mtd=ubi root=ubi0:rootfs rootfstype=ubifs
> > ubi.fm_autoconvert=1 mtdparts=vf610_nfc:128k(vf-bcb)ro,1408k(
> > u-boot)ro,512k(u-boot-env),-(ubi) fec_mac= consoleblank=0 console=tty1
> > console=ttyLP0,115200n8 mem=256M
> > 
> > Is there any other parameter or variable I need to set?
> 
> Hi Sanchayan,
> 
> The dts setting is specific for i.mx6 (maybe i.mx5 is applicate),
> and it needs below patch to co-work with it, it is an i.mx
> controller specific improvement (not in core).
> > >   usb: chipidea: usbmisc_imx: add unburst setting for imx6
> 
> Other chipidea SoCs may have optimized parameters than default ones, it
> needs to check with IC guys.
> 
> Enable stream mode should improve tx performance, you can have a try.

I will give this a try in a while and check, if that helps.

Thanks.

- Sanchayan.

> 
> > 
> > - Sanchayan
> > 
> > > Peter Chen (12):
> > >   Doc: usb: ci-hdrc-imx: add gadget-itc-setting for binding doc
> > >   usb: chipidea: set ITC to 0 for device mode
> > >   usb: chipidea: define stream mode disable for both roles
> > >   usb: chipidea: imx: add stream mode enable for device mode at
> > >     imx6sl/imx6sx
> > >   usb: chipidea: introduce ci_platform_config
> > >   Doc: usb: ci-hdrc-imx: add ahb-burst-config for binding doc
> > >   ARM: imx6: set ahb-burst-config as 0 for USB
> > >   usb: chipidea: add ahb burst configuration
> > >   usb: chipidea: usbmisc_imx: add unburst setting for imx6
> > >   Doc: usb: ci-hdrc-imx: add tx(rx)-burst-config-dword for binding doc
> > >   ARM: imx6: change default burst size for USB
> > >   usb: chipidea: add burst size configuration interface
> > > 
> > >  .../devicetree/bindings/usb/ci-hdrc-imx.txt        |  12 +++
> > >  arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +++
> > >  arch/arm/boot/dts/imx6sl.dtsi                      |   9 ++
> > >  arch/arm/boot/dts/imx6sx.dtsi                      |   9 ++
> > >  drivers/usb/chipidea/bits.h                        |   7 ++
> > >  drivers/usb/chipidea/ci.h                          |   3 +
> > >  drivers/usb/chipidea/ci_hdrc_imx.c                 |  14 ++-
> > >  drivers/usb/chipidea/core.c                        | 119 +++++++++++++++++++--
> > >  drivers/usb/chipidea/host.c                        |   6 +-
> > >  drivers/usb/chipidea/usbmisc_imx.c                 |  12 ++-
> > >  include/linux/usb/chipidea.h                       |  11 +-
> > >  11 files changed, 191 insertions(+), 23 deletions(-)
> > > 
> > > -- 
> > > 1.9.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> 
> Best Regards,
> Peter Chen
