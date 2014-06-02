From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 2 Jun 2014 14:27:41 +0200
Subject: iMX6Q FEC: transmit queue 0 timed out
Message-ID: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

on my IMX6 board with RMII and a LAN8720 PYH I don't get ethernet
running under Linux. It is, however, working from barebox.

I tried
* 3.15-rc8 "bare"
* 3.15-rc8 with three FEC related patches from linux-next ("net: fec:
correct the MDIO clock source" and two PM related patches)
* 3.15-rc8 with Russell King's cubie-patchbomb, I applied only the
net-fec-patches 71...125, which a substitution for
109-net-fec-increase-transmit-ring-size.patch, because that one didn't
apply automatically)

But all seemed to never been able to transmit: a tshark running on a
different computer didn't notice any packets from the iMX6Q board, not
even ARP. However, the barebox boot loader *IS* able to get data over
the ethernet, so the hardware must be ok ...

Any idea on how I could debug this further?



barebox:/ global linux.bootargs.root="root=/dev/ram rdinit=/sbin/init"
barebox:/ ifup eth0
barebox:/ mkdir -p /mnt
barebox:/ mount -t tftp $eth0.serverip /mnt
barebox:/ bootm -v -r /mnt/image/boot/initrd.img.gz
/mnt/linux/arch/arm/boot/zImage
T
Loading ARM Linux zImage '/mnt/linux/arch/arm/boot/zImage'
OS image not yet relocated
Loading initrd GZIP compressed '/mnt/image/boot/initrd.img.gz'
initrd image not yet relocated
Passing control to ARM zImage handler
no OS load address, defaulting to 0x10708000
no initrd load address, defaulting to 0x109ca000
commandline: console=ttymxc0,115200n8 quiet root=/dev/ram rdinit=/sbin/init

Starting kernel at 0x10708000, initrd at 0x109ca000, oftree at 0x10a99000...

/ # ifconfig eth0
eth0      Link encap:Ethernet  HWaddr A2:EB:72:86:51:1F
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
/ # dmesg -c >/dev/null
/ # ifconfig eth0 192.168.233.198
/ # dmesg -c
fec 2188000.ethernet eth0: Freescale FEC PHY driver [SMSC
LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet:00, irq=-1)
/ # ping -c 1 192.168.233.20
PING 192.168.233.20 (192.168.233.20): 56 data bytes


--------------> At this point, nothing happens. So I press Ctrl-C.


--- 192.168.233.20 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
/ # dmesg
random: nonblocking pool is initialized
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:264 dev_watchdog+0x1c0/0x248()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.15.0-rc8 #2
[<c0012e0c>] (unwind_backtrace) from [<c00102d0>] (show_stack+0x10/0x14)
[<c00102d0>] (show_stack) from [<c0356c28>] (dump_stack+0x78/0x94)
[<c0356c28>] (dump_stack) from [<c001c7b4>] (warn_slowpath_common+0x60/0x84)
[<c001c7b4>] (warn_slowpath_common) from [<c001c804>]
(warn_slowpath_fmt+0x2c/0x3c)
[<c001c804>] (warn_slowpath_fmt) from [<c02e1b40>] (dev_watchdog+0x1c0/0x248)
[<c02e1b40>] (dev_watchdog) from [<c0024e70>] (call_timer_fn.isra.35+0x20/0x80)
[<c0024e70>] (call_timer_fn.isra.35) from [<c0025700>]
(run_timer_softirq+0x1d0/0x214)
[<c0025700>] (run_timer_softirq) from [<c001fe34>] (__do_softirq+0xec/0x220)
[<c001fe34>] (__do_softirq) from [<c00201a0>] (irq_exit+0x84/0xa8)
[<c00201a0>] (irq_exit) from [<c000e068>] (handle_IRQ+0x6c/0x90)
[<c000e068>] (handle_IRQ) from [<c00084e0>] (gic_handle_irq+0x3c/0x60)
[<c00084e0>] (gic_handle_irq) from [<c0010d40>] (__irq_svc+0x40/0x50)
Exception stack(0xc04c3f70 to 0xc04c3fb8)
3f60:                                     eefbb550 00000000 00014b1e 00000000
3f80: c04c2000 c04c2000 c04b9af0 ef7fcac0 1000406a 412fc09a 00000000 00000000
3fa0: 00000000 c04c3fb8 c000e1ac c000e1b0 60000013 ffffffff
[<c0010d40>] (__irq_svc) from [<c000e1b0>] (arch_cpu_idle+0x24/0x2c)
[<c000e1b0>] (arch_cpu_idle) from [<c004b2b8>] (cpu_startup_entry+0x98/0x110)
[<c004b2b8>] (cpu_startup_entry) from [<c04999ec>] (start_kernel+0x2e8/0x344)
---[ end trace a7d71cbbbcf0c938 ]---
fec 2188000.ethernet eth0: TX ring dump
Nr     SC     addr       len  SKB
  0    0x9c00 0x3e2b8000   42 eea21b40 40000000
  1 S  0x0000 0x00000000    0   (null) 40000000
  2    0x0000 0x00000000    0   (null) 40000000
  3    0x0000 0x00000000    0   (null) 40000000
126    0x0000 0x00000000    0   (null) 40000000
127  H 0x2000 0x00000000    0   (null) 40000000
fec 2188000.ethernet eth0: TX ring dump
Nr     SC     addr       len  SKB
  0    0x9c00 0x3e2b8000   42 eea21840 40000000
  1 S  0x0000 0x00000000    0   (null) 40000000
...
126    0x0000 0x00000000    0   (null) 40000000
127  H 0x2000 0x00000000    0   (null) 40000000
fec 2188000.ethernet eth0: TX ring dump
Nr     SC     addr       len  SKB
  0    0x9c00 0x3e2b8000   42 eea219c0 40000000
  1 S  0x0000 0x00000000    0   (null) 40000000
...
126    0x0000 0x00000000    0   (null) 40000000
127  H 0x2000 0x00000000    0   (null) 40000000
/ # grep ether /proc/interrupts
150:        156          0          0          0       GIC 150  2188000.ethernet
151:          0          0          0          0       GIC 151  2188000.ethernet
