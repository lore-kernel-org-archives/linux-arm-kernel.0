From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Dec 2011 21:46:08 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <20111218203953.GY14542@n2100.arm.linux.org.uk>
References: <201112172023.05519.heiko@sntech.de>
 <201112182124.13313.heiko@sntech.de>
 <20111218203953.GY14542@n2100.arm.linux.org.uk>
Message-ID: <201112182146.09090.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 18 Dezember 2011, 21:39:53 schrieb Russell King - ARM Linux:
> On Sun, Dec 18, 2011 at 09:24:12PM +0100, Heiko St?bner wrote:
> > Am Sonntag 18 Dezember 2011, 20:45:18 schrieb Russell King - ARM Linux:
> > > On Sun, Dec 18, 2011 at 08:33:32PM +0100, Heiko St?bner wrote:
> > > > Am Sonntag 18 Dezember 2011, 20:01:02 schrieben Sie:
> > > > > On Sun, Dec 18, 2011 at 07:50:37PM +0100, Heiko St?bner wrote:
> > > > > > I didn't get this far. With your patch the Oopses already happen
> > > > > > during the startup of the system / the loading of the modules.
> > > > > > 
> > > > > > A bit of the message spew I got during testing with linux-
> > 
> > next-20111216:
> > > > > In some way, this is a good thing because it's showing that there's
> > > > > problems with kobject lifetime rules.
> > > > > 
> > > > > The #2 and further oops dumps are a result of corrupting the work
> > > > > queues as a result of #1, so #2 onwards should be ignored.
> > > > > 
> > > > > I suspect if you avoid loading the s3c_hsudc module these will go
> > > > > away.
> > > > 
> > > > nope :-), same faults happen even if s3c-hsudc is not present at all.
> > > > So it seems, this delayed cleanup poses problems for other drivers as
> > > > well.
> > > 
> > > Okay, let's try to find out which one it is.  Please use the attached
> > > patch - it'll be a little more noisy, reporting which kobjects are
> > > being released at the point when they're added to the workqueue.
> > 
> > The cuplrit seems to be a kobject named "holders" and from what I
> > gathered is from kernel/module.c and handling module sysfs entries.
> > 
> > 
> > Partial log below:
> > 
> > kobject: 'bq24022' (c78a9a80): kobject_release
> > [...]
> > kobject: 'gpio-vbus' (c78a9cc0): kobject_release
> > [...]
> > kobject: 'bq24022' (c78a9a80): kobject_cleanup
> > kobject: 'gpio-vbus' (c78a9cc0): kobject_cleanup
> > [...]
> > Found /sbin/init, booting ...
> > 
> > INIT: version 2.88 booting
> > 
> > Starting the hotplug events dispatcher: udevdudevd[367]: starting version
> > 172 .
> > Synthesizing the initial hotplug events...done.
> > Waiting for /dev to be fully populated...
> > [...]
> > Cleaning up ifupdown....
> > Loading kernel modules...
> > kobject: 'holders' (c7addc80): kobject_release
> > kobject: 'notes' (c7add080): kobject_release
> > done.
> > Activating lvm and md swap...done.
> > Checking file systems...fsck from util-linux 2.19.1
> > done.
> > [...]
> > kobject: 'holders' (c7addc80): kobject_cleanup
> > Unable to handle kernel paging request at virtual address bf055504
> > pgd = c0004000
> > [bf055504] *pgd=371f9811, *pte=00000000, *ppte=00000000
> > Internal error: Oops: 7 [#1]
> 
> Please post the entire first oops dump for the above run - it may contain
> useful information to properly track this down.

kobject: 'holders' (c7addc80): kobject_cleanup
Unable to handle kernel paging request at virtual address bf055504
pgd = c0004000
[bf055504] *pgd=371f9811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1]
Modules linked in: ohci_hcd usbcore leds_s3c24xx i2c_s3c2410 i2c_core
CPU: 0    Not tainted  (3.2.0-rc5-next-20111216+ #33)
PC is at kobject_put+0x18/0x7c
LR is at kobject_del+0x64/0x70
pc : [<c0114624>]    lr : [<c011470c>]    psr: a0000013
sp : c70bdef8  ip : c70bdf18  fp : c70bdf14
r10: 00000000  r9 : c0114718  r8 : c7803a00
r7 : c7abd360  r6 : c02e1de0  r5 : c7addca0  r4 : bf0554a0
r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : bf0554a0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 378ac000  DAC: 00000017
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bdef8 to 0xc70be000)
dee0:                                                       c7addc80 c7addca0
df00: c02e1de0 c7addc80 c70bdf2c c70bdf18 c011470c c011461c c0114748 c7addc80
df20: c70bdf4c c70bdf30 c01147ec c01146b8 c7addca0 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114728 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000000 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 59595959 59595959
Backtrace: 
[<c011460c>] (kobject_put+0x0/0x7c) from [<c011470c>] (kobject_del+0x64/0x70)
 r4:c7addc80
[<c01146a8>] (kobject_del+0x0/0x70) from [<c01147ec>] (kobject_delayed_cleanup+0xd4/0x174)
 r4:c7addc80
[<c0114718>] (kobject_delayed_cleanup+0x0/0x174) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c7addca0
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e24cb004 e24dd00c e2504000 0a000013 (e5d43064) 
---[ end trace 9e78135e0183be43 ]---
