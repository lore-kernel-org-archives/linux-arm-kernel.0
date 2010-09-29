From: d.cristiani@idem-tech.it (dylan cristiani)
Date: Wed, 29 Sep 2010 11:42:58 +0200
Subject: Fw: libertas_cf driver problems
Message-ID: <20100929114258.00005b97@unknown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Begin forwarded message:

Date: Wed, 29 Sep 2010 11:32:36 +0200
From: dylan cristiani <d.cristiani@idem-tech.it>
To: libertas-dev at lists.infradead.org
Cc: dylan cristiani <d.cristiani@idem-tech.it>,
linux-arm-kernel at lists.infradead.org
<linux-arm-kernel@lists.infradead.org> Subject: Re: libertas_cf driver
problems


On Mon, 19 Jul 2010 17:52:36 +0200
dylan cristiani <d.cristiani@idem-tech.it> wrote:

> Hi list, i'm using marvel compact flash cf8385 chip based wi-fi card,
> and i get some troubles.
> Scenario: i'm using a pxa270 platform based (similar to
> mainstone iii) with last linux kernel 2.6.34; i compile the libertas
> driver as a module (libertas_cs.ko) and i insert the module at the end
> of the boot ('insmod' command inside /etc/init.d/rcS); i load the
> marvell firmware (fw version 5.0.20p2, cap 0x00000393) inside the card
> via hotplug system; all seems to get right: i can get to associate to
> my access point and i get a dynamic ip address through dhcp server;
> but when i start communications between one host and the wi-fi card,
> something wrong happens and the card hangs, till i reset the device.
> here follows the log of the situation from module's insertion to the
> hang situation:
> 
> ........
> libertas_cs 0.0: firmware: requesting libertas_cs_helper.fw
> buf=31 a 0loading=1buf=30 a 0loading=0
> libertas_cs 0.0: firmware: requesting libertas_cs.fw
> buf=31 a 0loading=1buf=30 a 0loading=0
> libertas: 00:10:7a:75:5d:a2, fw 5.0.20p2, cap 0x00000393
> libertas: wlan0: Marvell WLAN 802.11 adapter
> 
> libertas: command 0x001f timed out
> libertas: Timeout submitting command 0x001f
> ------------[ cut here ]------------
> WARNING: at net/sched/sch_generic.c:256 dev_watchdog+0x1a0/0x298()
> NETDEV WATCHDOG: wlan0 (libertas_cs): transmit queue 0 timed out
> Modules linked in: libertas_cs
> Backtrace:
> [<c003a8ec>] (dump_backtrace+0x0/0x108) from [<c003aa0c>]
> (dump_stack+0x18/0x1c) r7:c0405e10 r6:c028234c r5:c03e1640 r4:00000100
> [<c003a9f4>] (dump_stack+0x0/0x1c) from [<c005184c>]
> (warn_slowpath_common+0x50/0x68) [<c00517fc>]
> (warn_slowpath_common+0x0/0x68) from [<c00518b0>]
> (warn_slowpath_fmt+0x30/0x38) r7:00000000 r6:00000001 r5:00000001
> r4:c3edb800 [<c0051880>] (warn_slowpath_fmt+0x0/0x38) from
> [<c028234c>] (dev_watchdog+0x1a0/0x298) r3:c3edb800 r2:c03e1604
> [<c02821ac>] (dev_watchdog+0x0/0x298) from [<c005bfd8>]
> (run_timer_softirq+0x164/0x1d0) r8:c0405ea8 r7:c02821ac r6:00000100
> r5:c0438f00 r4:c0404000 [<c005be74>] (run_timer_softirq+0x0/0x1d0)
> from [<c005674c>] (__do_softirq+0x8c/0x140) [<c00566c0>]
> (__do_softirq+0x0/0x140) from [<c0056a6c>] (irq_exit+0x44/0x4c)
> [<c0056a28>] (irq_exit+0x0/0x4c) from [<c003607c>]
> (asm_do_IRQ+0x7c/0x94) [<c0036000>] (asm_do_IRQ+0x0/0x94) from
> [<c0036ab0>] (__irq_svc+0x30/0xa0) Exception stack(0xc0405f50 to
> 0xc0405f98) 5f40:                                     00000001
> 000000aa a0000013 60000013 5f60: c0404000 c0021f3c c0021f38 c04083a8
> a0020b18 69054117 a0020ae4 c0405fa4 5f80: c0405fa8 c0405f98 c0038040
> c003804c 60000013 ffffffff r6:001a0000 r5:c0405f84 r4:ffffffff
> [<c003801c>] (default_idle+0x0/0x34) from [<c00380b8>]
> (cpu_idle+0x68/0xa4) [<c0038050>] (cpu_idle+0x0/0xa4) from
> [<c0310124>] (rest_init+0x5c/0x70) r4:c043b990 [<c03100c8>]
> (rest_init+0x0/0x70) from [<c0008950>] (start_kernel+0x248/0x2a0)
> [<c0008708>] (start_kernel+0x0/0x2a0) from [<a0008034>] (0xa0008034)
> r5:c04337d8 r4:0000397d ---[ end trace 2ccb466c94cfe8b8 ]---
> libertas: tx watch dog timeout libertas: command 0x000b timed out
> libertas: Timeout submitting command 0x000b libertas: PREP_CMD:
> command 0x000b failed: -110 libertas: tx watch dog timeout
> libertas: command 0x001f timed out
> libertas: Timeout submitting command 0x001f
> libertas: tx watch dog timeout
> .....
> 
> 
> and the timeouts continue till i reset the device, so i cannot get
> to use the card anymore.
> Has anybody had similar problem? can you suggest me some solution/test
> to perform?
> 
> PS when the hang situation happens, also the interrupt line associated
> to the compact flash stop toggling (no more interrupts occur in
> relevant interrupt line into /proc/interrupts)
more infos; now i'm using 2.6.36-rc4 with 'iw' instead of iwconfig and
friends but off course problem still happens: i perform the following
commands:

'iw wlan0 scan'
'iw wlan0 connect dylan'
'udhcpc -i wlan0'

i discover the APs then i can connect to access point whose SSID is
dylan (very original i know..) and i get a dynamic ip address but when
i try to tranfer data to another network ip address:

'scp sd_midori.tgz root at 192.168.1.63:/home/dylan/Working_Copy'

after 250KB of data tranfer i get the same as usual: here the log form
loading of firmware forward till the problem

.....
 libertas: 00:10:7a:75:5d:a2, fw 5.0.20p2, cap 0x00000393
 cfg80211: Calling CRDA for country: JP
 libertas: wlan0: Marvell WLAN 802.11 adapter
 Rr.ca.eiEtlibertas: assoc: bss (null) not in scan results
 cfg80211: Calling CRDA for country: IT
 ------------[ cut here ]------------
 WARNING: at net/sched/sch_generic.c:258 dev_watchdog+0x14c/0x23c()
 NETDEV WATCHDOG: wlan0 (libertas_cs): transmit queue 0 timed out
 Modules linked in: libertas_cs
 Backtrace:
 [] (dump_backtrace+0x0/0x118) from [] (dump_stack+0x18/0x1c)
r6:00000102 r5:c026bc9c r4:c03efe20 r3:c03f5714
 [] (dump_stack+0x0/0x1c) from [] (warn_slowpath_common+0x54/0x6c)
 [] (warn_slowpath_common+0x0/0x6c) from []
(warn_slowpath_fmt+0x38/0x40)
  r8:c041d06c r7:c041ce6c r6:c0429df8 r5:00000000 r4:c38e1800
 r3:00000009
 [] (warn_slowpath_fmt+0x0/0x40) from [] (dev_watchdog+0x14c/0x23c)
  r3:c38e1800 r2:c03c8daa
 [] (dev_watchdog+0x0/0x23c) from [] (run_timer_softirq+0x160/0x210)
  r6:00000100 r5:c03ee000 r4:c041c660
 [] (run_timer_softirq+0x0/0x210) from [] (__do_softirq+0x80/0x114)
 [] (__do_softirq+0x0/0x114) from [] (irq_exit+0x48/0x50)
 [] (irq_exit+0x0/0x50) from [] (asm_do_IRQ+0x80/0xa0)
 [] (asm_do_IRQ+0x0/0xa0) from [] (__irq_svc+0x30/0xa0)
 Exception stack(0xc03eff50 to 0xc03eff98)
 ff40:                                     00000001 00000002 c03eff98
60000013
 ff60: c03ee000 c0020694 c0020690 c03f23a0 a001f254 69054117 a001f220
c03effa4
 ff80: c03effa8 c03eff98 c0037004 c0037010 60000013 ffffffff
  r5:c03eff84 r4:ffffffff
 [] (default_idle+0x0/0x38) from [] (cpu_idle+0x60/0xa4)
 [] (cpu_idle+0x0/0xa4) from [] (rest_init+0x64/0x7c)
  r4:c041f23c r3:00000000
 [] (rest_init+0x0/0x7c) from [] (start_kernel+0x224/0x268)
 [] (start_kernel+0x0/0x268) from [] (0xa0008034)
  r5:c0416f6c r4:0000397d
 ---[ end trace 197b6e3335d4842b ]---
 libertas: tx watch dog timeout
 libertas: command 0x001f timed out
 libertas: Timeout submitting command 0x001f
 libertas: PREP_CMD: command 0x001f failed: -110
 libertas: tx watch libertas: tx watch dog timeout
 libertas: command 0x001f timed out
 libertas: Timeout submitting command 0x001f
 libertas: PREP_CMD: command 0x001f failed: -110
 libertas: tx watch dog timeout
 libertas: tx watch dog timeout
 libertas: command 0x001f timed out
 libertas: Timeout submitting command 0x001f
 libertas: PREP_CMD: command 0x001f failed: -110
 libertas: tx watch dog timeout
 .......

same happens just opening a google homepage with browser like midori or
minimo and same when i tranfer file to the target via sftp

Has anybody some hints or i have to change chipset? if so, any chip to
suggest me, keeping in mind that i'm using a CF interface? due to fact
that probably it's a problem between marvell firmware and user
application, is there any chance to solve it kernel driver side? i'm
the only one with this scenario to have that problem? is this problem
happening also with marvell spi chip or usb?

hoping to hearing at least a coulpe of answers, i send you millions of
regards!!!

dylan


-- 
eng. dylan cristiani
idem srl
