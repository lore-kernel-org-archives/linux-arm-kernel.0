From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Tue, 08 Oct 2013 11:02:24 +0200
Subject: imx6q-wandboard: Ethernet tx-queue timeouts when SATA is active
In-Reply-To: <1381215022.1282.18.camel@mako.sharkbay.at>
References: <1381053686.1282.12.camel@mako.sharkbay.at>
 <0E83723C55F66F43A6041464FE31119D3FBB40@039-SN2MPN1-012.039d.mgd.msft.net>
 <1381215022.1282.18.camel@mako.sharkbay.at>
Message-ID: <1381222944.1282.30.camel@mako.sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

To still make the problem happen every few seconds I additionally (in
parallel to the /dev/sda stream) started a second netcat pipe pushing
just /dev/zero to a different UDP port on the server like that:
Server: nc -l -u -p 13000 > /dev/null
Wandboard: nc -u <server> 13000 < /dev/zero

That way I achieve up to 52 MBytes/s going out on the network interface.

So the quantity of the network drops definitely increases when the
network throughput gets higher.

But still this only happens when SATA is running with high throughput at
the same time. Only streaming date from /dev/zero over the net with 52
MBytes/s does not trigger the network interruptions.

Regards,
Tom

On Die, 2013-10-08@08:50 +0200, Thomas Scheiblauer wrote:
> Hello Richard,
> 
> Thank you for looking into this.
> The problem seems only to happen when the SATA and network bandwidths
> are pushed up to their limits and the data throughput is around 40
> MBytes/s.
> On the latest kernel from (with rmk/for-next, libata/for-next and the
> RobertCNelson patchset merged in) I seem not to be able to reach that
> throughput using NFS or netcat over TCP. The only method I can reproduce
> this reliably now is to pipe through netcat using UDP.
> 
> Please try to pipe /dev/sda through netcat like that:
> on some (fast) server:
> 	nc -l -u -p 12000 > /dev/null
> on the Wnadboard:
> 	nc -u <server-ip> 12000 < /dev/sda
> 
> Though it does not happen so often at the moment as it seems the latest
> changes to the kernel (maybe the libata/for-next merge?) do not let me
> reach the previously possible throughput so easily. And it seems to get
> more stable the longer it runs (thermal or power supply problems???)
> 
> Regards,
> Tom
> 
> On Die, 2013-10-08 at 03:19 +0000, Zhu Richard-R65037 wrote:I
>  validated the SATA functions on v3.12-rc3 of linus git repos just now.
> > 
> > 
> > Here is the log:
> > ...[v3.12-rc3 of linus repos]...
> > Starting kernel ...
> > 
> > Booting Linux on physical CPU 0x0
> > Linux version 3.12.0-rc3 (richard at richard-OptiPlex-780) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #3 SMP Tue Oct 8 11:10:51 CST 2013
> > CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
> > CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > Machine: Freescale i.MX6 Quad/DualLite (Device Tree), model: Freescale i.MX6 Quad SABRE Smart Device Board
> > ...
> > ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata1.00: ATA-8: SanDisk SSD P4 32GB, SSD 8.00, max UDMA/133
> > ata1.00: 62533296 sectors, multi 1: LBA48 
> > ata1.00: configured for UDMA/133
> > scsi 0:0:0:0: Direct-Access     ATA      SanDisk SSD P4 3 SSD  PQ: 0 ANSI: 5
> > sd 0:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB)
> > sd 0:0:0:0: [sda] Write Protect is off
> > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> >  sda: sda1 sda2
> > sd 0:0:0:0: [sda] Attached SCSI disk
> > ...[NFS]...
> > mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
> >  mmcblk1: p1 p2
> > libphy: 2188000.ethernet:01 - Link is Up - 100/Full
> > IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > Sending DHCP requests ., OK
> > IP-Config: Got DHCP answer from 10.192.242.252, my address is 10.192.242.95
> > IP-Config: Complete:
> >      device=eth0, hwaddr=00:04:9f:02:18:df, ipaddr=10.192.242.95, mask=255.255.255.0, gw=10.192.242.254
> >      host=10.192.242.95, domain=ap.freescale.net, nis-domain=(none)
> >      bootserver=0.0.0.0, rootserver=10.192.225.216, rootpath=
> >      nameserver0=10.192.130.201, nameserver1=10.211.0.3, nameserver2=10.196.51.200
> > ALSA device list:
> >   #0: wm8962-audio
> > ...[DO-MASS-DATA-COPY]...
> > root at freescale ~$ cp -rf *.* /mnt/src/
> > root at freescale ~$ df
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > 10.192.225.216:/home/r65037/nfs/rootfs_mx5x_10.11
> >                      843113892 781000276  19285936  98% /
> > devtmpfs                385392        48    385344   0% /dev
> > tmpfs                   385392        48    385344   0% /dev
> > shm                     385392         0    385392   0% /dev/shm
> > rwfs                       512         0       512   0% /mnt/rwfs
> > /dev/sda1             14239124   1265124  12250676   9% /mnt/src
> > 
> > Best Regards
> > Richard Zhu
> > 
> > 
> > -----Original Message-----
> > From: Zhu Richard-R65037 
> > Sent: Tuesday, October 08, 2013 10:53 AM
> > To: 'Thomas Scheiblauer'; linux-arm-kernel at lists.infradead.org
> > Cc: Li Frank-B20596; shawn.guo at linaro.org
> > Subject: RE: imx6q-wandboard: Ethernet tx-queue timeouts when SATA is active
> > 
> > Hi Tom:
> > Thanks for your reminder.
> > 
> > Based on libata/for-next branch of Tejun's git repos(https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/),
> > I used to verify the i.MX6Q SATA functions on i.MX6Q SD board + NFS enviroment.
> > There is no such kind of issue.
> > 
> > Let me re-validate it on the v3.12-rc3 of Linus' git repos.
> > 
> > BTW, what?s the tool-chains used by you?
> > 
> > Here is my logs:
> > Booting Linux on physical CPU 0x0
> > Linux version 3.12.0-rc1+ (richard at richard-OptiPlex-780) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #2 SMP Fri Sep 27 15:21:49 CST 2013
> > CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d ...
> > IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready Sending DHCP requests ., OK
> > IP-Config: Got DHCP answer from 10.192.242.252, my address is 10.192.242.95
> > IP-Config: Complete:
> >      device=eth0, hwaddr=00:04:9f:02:18:df, ipaddr=10.192.242.95, mask=255.255.255.0, gw=10.192.242.254
> >      host=10.192.242.95, domain=ap.freescale.net, nis-domain=(none)
> >      bootserver=0.0.0.0, rootserver=10.192.225.216, rootpath=
> >      nameserver0=10.192.130.201, nameserver1=10.211.0.3, nameserver2=10.196.51.200 ALSA device list:
> >   #0: wm8962-audio
> > ...
> > root at freescale ~$ fdisk /dev/sda -l
> > 
> > Disk /dev/sda: 32.0 GB, 32017047552 bytes
> > 255 heads, 63 sectors/track, 3892 cylinders Units = cylinders of 16065 * 512 = 8225280 bytes
> > 
> >    Device Boot      Start         End      Blocks  Id System
> > /dev/sda1              92        1892    14466532+ 83 Linux
> > /dev/sda2            1893        3892    16065000  83 Linux
> > ...
> > root at freescale ~$ cp -rf *.* /mnt/src/
> > root at freescale ~$ df
> > ...
> > shm                     385392         0    385392   0% /dev/shm
> > rwfs                       512         0       512   0% /mnt/rwfs
> > /dev/sda1             14239124    477484  13038316   4% /mnt/src
> > 
> > Best Regards
> > Richard Zhu
> > 
> > -----Original Message-----
> > From: Thomas Scheiblauer [mailto:tom at sharkbay.at]
> > Sent: Sunday, October 06, 2013 6:01 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Zhu Richard-R65037; Li Frank-B20596; shawn.guo at linaro.org
> > Subject: BUG: imx6q-wandboard: Ethernet tx-queue timeouts when SATA is active
> > 
> > I experience transmit queue timeouts every few seconds on the ethernet port when SATA is transfering data at the same time e.g. when copying from HD over NFS or piping HD data through ssh or netcat.
> > When the first timeout happens I get this kernel message:
> > 
> > WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:264 dev_watchdog
> > +0x278/0x298()
> > NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out Modules linked in: uio_pdrv_genirq uio
> > CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.12.0-rc3 #1
> > Backtrace: 
> > [<80011a94>] (dump_backtrace+0x0/0x10c) from [<80011c30>] (show_stack
> > +0x18/0x1c)
> >  r6:00000108 r5:00000009 r4:00000000 r3:00000000 [<80011c18>] (show_stack+0x0/0x1c) from [<804b4418>] (dump_stack
> > +0x78/0x94)
> > [<804b43a0>] (dump_stack+0x0/0x94) from [<800228b4>]
> > (warn_slowpath_common+0x6c/0x90)
> >  r4:ef0b9e18 r3:8062f4b4
> > [<80022848>] (warn_slowpath_common+0x0/0x90) from [<8002297c>]
> > (warn_slowpath_fmt+0x38/0x40)
> >  r8:80661e48 r7:806340c0 r6:ef353100 r5:ef368800 r4:00000000 [<80022944>] (warn_slowpath_fmt+0x0/0x40) from [<803f3660>]
> > (dev_watchdog+0x278/0x298)
> >  r3:ef368800 r2:805cec10
> > [<803f33e8>] (dev_watchdog+0x0/0x298) from [<8002c62c>]
> > (call_timer_fn.isra.24+0x2c/0x8c)
> >  r8:ef034814 r7:806340c0 r6:803f33e8 r5:00000100 r4:ef0b8000After it [<8002c600>] (call_timer_fn.isra.24+0x0/0x8c) from [<8002c804>]
> > (run_timer_softirq+0x178/0x200)
> >  r7:806340c0 r6:00200200 r5:00000000 r4:ef0b9e90 [<8002c68c>] (run_timer_softirq+0x0/0x200) from [<800265d4>]
> > (__do_softirq+0xf4/0x1e0)
> > [<800264e0>] (__do_softirq+0x0/0x1e0) from [<80026a04>] (irq_exit
> > +0xa0/0xf0)
> > [<80026964>] (irq_exit+0x0/0xf0) from [<8000ef7c>] (handle_IRQ
> > +0x44/0x9c)
> >  r4:8062fd88 r3:00000180
> > [<8000ef38>] (handle_IRQ+0x0/0x9c) from [<800084d4>] (gic_handle_irq
> > +0x30/0x64)
> >  r6:ef0b9f70 r5:8063a778 r4:f400010c r3:000000a0 [<800084a4>] (gic_handle_irq+0x0/0x64) from [<80012700>] (__irq_svc
> > +0x40/0x50)
> > Exception stack(0xef0b9f70 to 0xef0b9fb8)
> > 9f60:                                     81e1e970 00000000 00574db0
> > 00000000
> > 9f80: 80661d47 00000001 80661d47 8063a3e0 804badbc ef0b8000 8063a388
> > ef0b9fc4
> > 9fa0: ef0b9fc8 ef0b9fb8 8000f184 8000f188 600e0013 ffffffff
> >  r7:ef0b9fa4 r6:ffffffff r5:600e0013 r4:8000f188 [<8000f158>] (arch_cpu_idle+0x0/0x38) from [<80057814>]
> > (cpu_startup_entry+0x68/0x138)
> > [<800577ac>] (cpu_startup_entry+0x0/0x138) from [<80013578>]
> > (secondary_start_kernel+0xd4/0xe8)
> >  r7:806621f4 r3:00000005
> > [<800134a4>] (secondary_start_kernel+0x0/0xe8) from [<100085a4>]
> > (0x100085a4)
> >  r4:7f09c06a r3:8000858c
> > ---[ end trace db3ced4bf31e8711 ]---
> > 
> > I tried with kernels 3.11.1, 3.12.0-rc2 and 3.12.0-rc3, vanilla as well as with all ARM fixes from rmk/for-next and the RobertCNelson patchset applied.
> > 
> > Steps to reproduce:
> >      1. boot one of the mentioned kernel releases (either patched or
> >         unpatched)
> >      2. copy some file from a storage device connected to the Quad's
> >         SATA port (or just /dev/sda if sda is your SATA storage) over
> >         the network to another machine either using nfs or piping
> >         through ssh (use the HPN patched ssh and its "None" cipher to
> >         make it fast because I suspect it happens more often when
> >         copying with high throughput) or just pipe it directly through a
> >         network socket (preferably UDP because it's faster) using e.g.
> >         "netcat" (nc),
> >      3. Look at the network throughput using e.g. "dstat" and at dmesg
> >      4. network throughput will drop to zero every few seconds (seldom
> >         it keeps stable for more tan 30 seconds) and will take about 3
> >         or 4 seconds to recover.
> >      5. additionally you may spot the above mentioned kernel warning
> >         once in dmesg.
> >      6. In addition when you use nfs (nfs4 server on the Wandboard in my
> >         case) you will spot messages like this in dmesg every time a
> >         throughput drop happens: "rpc-srv/tcp: nfsd: sent only 118848
> >         when sending 262208 bytes - shutting down socket"
> > 
> > The drops ONLY happen when using SATA at the same time as ethernet. If you just copy e.g. /dev/zero or some data from the SD-Card (testet with the internal SD) it will constantly run with about 408 MBit/s without interruptions.
> > 
> > I have posted my current kernel config to
> > ftp://ftp.arm.linux.org.uk/pub/linux/arm/incoming/tom.sharkbay.at_config-3.12.0-rc3
> > I have already tried many different configurations regarding IO-schedulers, preemption models, dynticks, static ticks, etc...
> > 
> > Btw, I'm running ArchLinux on the Wandboard and tried ext4 and btrfs filesystems on the SATA HD (it seems not to be a filesystem problem since it also happens when just copying /dev/sda)
> > 
> > Regards,
> > Tom
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
