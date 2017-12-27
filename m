From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 27 Dec 2017 02:53:13 +0000
Subject: [PATCH V2] ARM: imx: suspend/resume: use outer_disable/resume
In-Reply-To: <20171227025055.GD11724@b29396-OptiPlex-7040>
References: <1514339867-28946-1-git-send-email-peng.fan@nxp.com>
 <20171227023207.GX23070@X250>
 <AM3PR04MB3067ECFE7A7DAE48DFD124780070@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20171227025055.GD11724@b29396-OptiPlex-7040>
Message-ID: <DB6PR04MB3221A901AC3DD7922540741488070@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86 at gmail.com]
> Sent: Wednesday, December 27, 2017 10:51 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Peng Fan <peng.fan@nxp.com>;
> linux-kernel at vger.kernel.org; Russell King <linux@armlinux.org.uk>; Fabio
> Estevam <fabio.estevam@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> van.freenix at gmail.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2] ARM: imx: suspend/resume: use
> outer_disable/resume
> 
> On Wed, Dec 27, 2017 at 02:33:57AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > Sent: Wednesday, December 27, 2017 10:32 AM
> > > To: Peng Fan <peng.fan@nxp.com>
> > > Cc: A.s. Dong <aisheng.dong@nxp.com>; linux-kernel at vger.kernel.org;
> > > Russell King <linux@armlinux.org.uk>; Fabio Estevam
> > > <fabio.estevam@nxp.com>; Sascha Hauer <kernel@pengutronix.de>;
> > > van.freenix at gmail.com; linux-arm- kernel at lists.infradead.org
> > > Subject: Re: [PATCH V2] ARM: imx: suspend/resume: use
> > > outer_disable/resume
> > >
> > > On Wed, Dec 27, 2017 at 09:57:47AM +0800, Peng Fan wrote:
> > > > Use outer_disable/resume for suspend/resume.
> > > > With the two APIs used, code could be simplified and easy to
> > > > extend to introduce l2c_write_sec for i.MX platforms when moving
> > > > Linux Kernel runs in non-secure world.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> > >
> > > @Aisheng, can you please give it a test?
> > >
> >
> > Yes, of course.
> >
> 
> Not sure but i can still meet booting crash on mx6sx sdb.
> Peng, you did not meet it, right?
> 
> I tested with Shanw/for-next branch.

I use kernel master branch. I'll switch to shawn's for-next branch and give a test.

Thanks,
Peng.

> 
> [    4.840665] VFS: Mounted root (nfs filesystem) readonly on device 0:13.
> [    4.853448] devtmpfs: mounted
> [    4.858370] Freeing unused kernel memory: 1024K
> INIT: version 2.88 booting
> [    6.835667] BUG: Bad rss-counter state mm:ecef66c0 idx:0 val:-1
> [    6.841783] BUG: Bad rss-counter state mm:ecef66c0 idx:1 val:1
> Starting udev
> [    7.792090] Unable to handle kernel NULL pointer dereference at virtual
> address 00000001
> [    7.800500] pgd = ecbcc000
> [    7.803884] [00000001] *pgd=ba0c1831
> [    7.807541] Internal error: Oops: 17 [#1] SMP ARM
> [    7.812268] Modules linked in:
> [    7.815368] CPU: 0 PID: 175 Comm: S04udev Not tainted 4.15.0-rc1-00043-
> g7afb5ac-dirty #1891
> [    7.823739] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [    7.829595] task: ec79d940 task.stack: ec8bc000
> [    7.834168] PC is at kmem_cache_alloc+0xf0/0x168
> [    7.838808] LR is at 0x2e85d000
> [    7.841971] pc : [<c0226ec0>]    lr : [<2e85d000>]    psr: 20000013
> [    7.848257] sp : ec8bdef8  ip : ef7d9ee0  fp : ec8bdf2c
> [    7.853502] r10: 00000b5e  r9 : 00000001  r8 : a0000013
> [    7.858748] r7 : 00000b5f  r6 : c014a21c  r5 : 014000c0  r4 : ec001d80
> [    7.865295] r3 : 00000000  r2 : eca5b200  r1 : ec8bc000  r0 : c1009290
> [    7.871848] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
> none
> [    7.879003] Control: 10c5387d  Table: acbcc04a  DAC: 00000051
> [    7.884770] Process S04udev (pid: 175, stack limit = 0xec8bc210)
> [    7.890798] Stack: (0xec8bdef8 to 0xec8be000)
> [    7.895180] dee0:                                                       00422030 00000000
> [    7.903387] df00: 000000c3 00000004 ec79d940 ffffff9c 0178f780 c0108104
> ec8bc000 00000000
> [    7.911592] df20: ec8bdf44 ec8bdf30 c014a21c c0226ddc 00000004 00000000
> ec8bdf94 ec8bdf48
> [    7.919798] df40: c022bf2c c014a1fc 00422030 00000000 0000000d 00000004
> 000003e8 000003e8
> [    7.928004] df60: 0000a990 00000000 5a41ff5b 00000004 00000000 0178f780
> 00000021 c0108104
> [    7.936209] df80: ec8bc000 00000000 ec8bdfa4 ec8bdf98 c022c120 c022bf0c
> 00000000 ec8bdfa8
> [    7.944414] dfa0: c0107f40 c022c110 00000004 00000000 0178f780 00000004
> be92eca8 00008000
> [    7.952619] dfc0: 00000004 00000000 0178f780 00000021 00000000 00000000
> 00000024 be92edac
> [    7.960826] dfe0: 000e51e4 be92eca4 b6eac97c b6eac87c 60000010 0178f780
> 00000000 00000000
> [    7.969018] Backtrace:
> [    7.971519] [<c0226dd0>] (kmem_cache_alloc) from [<c014a21c>]
> (prepare_creds+0x2c/0x120)
> [    7.979642]  r10:00000000 r9:ec8bc000 r8:c0108104 r7:0178f780 r6:ffffff9c
> r5:ec79d940
> [    7.987492]  r4:00000004
> [    7.990060] [<c014a1f0>] (prepare_creds) from [<c022bf2c>]
> (SyS_faccessat+0x2c/0x204)
> [    7.997911]  r5:00000000 r4:00000004
> [    8.001517] [<c022bf00>] (SyS_faccessat) from [<c022c120>]
> (SyS_access+0x1c/0x20)
> [    8.009028]  r10:00000000 r9:ec8bc000 r8:c0108104 r7:00000021 r6:0178f780
> r5:00000000
> [    8.016875]  r4:00000004
> [    8.019448] [<c022c104>] (SyS_access) from [<c0107f40>]
> (ret_fast_syscall+0x0/0x28)
> [    8.027135] Code: e121f008 e3590000 0a000002 e5943014 (e7993003)
> [    8.033525] ---[ end trace 5829484d9a98b0fd ]---
> /etc/init.d/rc: line 45:   175 Se[    8.042776] Unable to handle kernel NULL
> pointer dereference at virtual address 00000001
> 
> Regards
> Dong Aisheng
> 
> > Regards
> > Dong Aisheng
> >
> > > Shawn
