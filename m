From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 Apr 2012 18:32:11 +0200
Subject: [alexandre.belloni@piout.net: AT91SAM9261-EK still broken ?]
In-Reply-To: <20120409205653.GA10737@piout.net>
References: <20120409192055.GA7092@piout.net>
 <20120409205653.GA10737@piout.net>
Message-ID: <20120410163211.GJ16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	but found and fixed

Best Regards,
J.
On 22:56 Mon 09 Apr     , Alexandre Belloni wrote:
> Hi again,
> 
> More info, I get almost the same behavior while booting from nand.
> ts_calibrate and ubiattach seem to trigger the issue.
> 
> ifconfig eth0 192.168.1.222
> dm9000 dm9000.0: eth0: link down
> # dm9000 dm9000.0: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1): 56 data bytes
> 64 bytes from 192.168.1.1: seq=0 ttl=64 time=12.184 ms
> [...]
> --- 192.168.1.1 ping statistics ---
> 28 packets transmitted, 28 packets received, 0% packet loss
> round-trip min/avg/max = 0.471/5.027/14.160 ms
> # ts_calibrate 
> xres = 240, yres = 320
> signal 2 caught
> # ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1): 56 data bytes
> ------------[ cut here ]------------
> WARNING: at net/sched/sch_generic.c:256 dev_watchdog+0x258/0x278()
> NETDEV WATCHDOG: eth0 (dm9000): transmit queue 0 timed out
> Modules linked in:
> [<c0012614>] (unwind_backtrace+0x0/0xf0) from [<c0019f98>] (warn_slowpath_common+0x4c/0x64)
> [<c0019f98>] (warn_slowpath_common+0x4c/0x64) from [<c001a044>] (warn_slowpath_fmt+0x30/0x40)
> [<c001a044>] (warn_slowpath_fmt+0x30/0x40) from [<c0250010>] (dev_watchdog+0x258/0x278)
> [<c0250010>] (dev_watchdog+0x258/0x278) from [<c002370c>] (run_timer_softirq+0xf8/0x230)
> [<c002370c>] (run_timer_softirq+0xf8/0x230) from [<c001f140>] (__do_softirq+0x90/0x120)
> [<c001f140>] (__do_softirq+0x90/0x120) from [<c001f534>] (irq_exit+0x48/0x50)
> [<c001f534>] (irq_exit+0x48/0x50) from [<c000e980>] (handle_IRQ+0x44/0x98)
> [<c000e980>] (handle_IRQ+0x44/0x98) from [<c000dd78>] (__irq_svc+0x38/0x60)
> [<c000dd78>] (__irq_svc+0x38/0x60) from [<c000eacc>] (default_idle+0x24/0x40)
> [<c000eacc>] (default_idle+0x24/0x40) from [<c000ec90>] (cpu_idle+0x84/0xbc)
> [<c000ec90>] (cpu_idle+0x84/0xbc) from [<c03f76e0>] (start_kernel+0x24c/0x290)
> ---[ end trace 93ffb7dfd2d10fb0 ]---
> --- 192.168.1.1 ping statistics ---
> 9 packets transmitted, 0 packets received, 100% packet loss
> 
> 
> On Mon, Apr 09, 2012 at 09:20:55PM +0200, Alexandre Belloni wrote :
> > Hum, I got the wrong list...
> > 
> > ----- Forwarded message from Alexandre Belloni <alexandre.belloni@piout.net> -----
> > 
> > Date: Mon, 9 Apr 2012 21:10:25 +0200
> > From: Alexandre Belloni <alexandre.belloni@piout.net>
> > To: linux-arm-kernel at lists.arm.linux.org.uk
> > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Subject: AT91SAM9261-EK still broken ?
> > User-Agent: Mutt/1.5.21 (2010-09-15)
> > 
> > Hi Jean-Christophe,
> > 
> > I'm using linux 3.4-rc2 and it seems I'm running in the same issue that
> > was described there: https://lkml.org/lkml/2011/8/8/355
> > 
> > I didn't have a deep look into it but when I try to use ts_calibrate or
> > ts_test, the network interface is freezing. As I'm using nfs to boot, I
> > can't do anything anymore...
> > 
> > Kernel message:
> > 
> > # ts_calibrate 
> > ------------[ cut here ]------------
> > WARNING: at net/sched/sch_generic.c:256 dev_watchdog+0x258/0x278()
> > NETDEV WATCHDOG: eth0 (dm9000): transmit queue 0 timed out
> > Modules linked in:
> > [<c0012614>] (unwind_backtrace+0x0/0xf0) from [<c0019f98>] (warn_slowpath_common+0x4c/0x64)
> > [<c0019f98>] (warn_slowpath_common+0x4c/0x64) from [<c001a044>] (warn_slowpath_fmt+0x30/0x40)
> > [<c001a044>] (warn_slowpath_fmt+0x30/0x40) from [<c023fb70>] (dev_watchdog+0x258/0x278)
> > [<c023fb70>] (dev_watchdog+0x258/0x278) from [<c002370c>] (run_timer_softirq+0xf8/0x230)
> > [<c002370c>] (run_timer_softirq+0xf8/0x230) from [<c001f140>] (__do_softirq+0x90/0x120)
> > [<c001f140>] (__do_softirq+0x90/0x120) from [<c001f534>] (irq_exit+0x48/0x50)
> > [<c001f534>] (irq_exit+0x48/0x50) from [<c000e980>] (handle_IRQ+0x44/0x98)
> > [<c000e980>] (handle_IRQ+0x44/0x98) from [<c000dd78>] (__irq_svc+0x38/0x60)
> > [<c000dd78>] (__irq_svc+0x38/0x60) from [<c000eacc>] (default_idle+0x24/0x40)
> > [<c000eacc>] (default_idle+0x24/0x40) from [<c000ec90>] (cpu_idle+0x84/0xbc)
> > [<c000ec90>] (cpu_idle+0x84/0xbc) from [<c03e16e0>] (start_kernel+0x24c/0x290)
> > ---[ end trace e6a4b7e1afc454c3 ]---
> > nfs: server 192.168.1.1 not responding, still trying
> > 
> > Regards,
> > 
> > -- 
> > Alexandre Belloni
> > 
> > ----- End forwarded message -----
> > 
> > -- 
> > Alexandre Belloni
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Alexandre Belloni
