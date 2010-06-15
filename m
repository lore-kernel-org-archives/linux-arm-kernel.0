From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 15 Jun 2010 13:53:01 +0200
Subject: [PATCH 2/2] ehci-mxc: bail out on transceiver problems
In-Reply-To: <201006151347.51085.philippe.retornaz@epfl.ch>
References: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
	<1276598063-3956-2-git-send-email-w.sang@pengutronix.de>
	<20100615104342.GE17833@buzzloop.caiaq.de>
	<201006151347.51085.philippe.retornaz@epfl.ch>
Message-ID: <20100615115301.GJ17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 01:47:50PM +0200, Philippe R?tornaz wrote:
> Le mardi, 15 juin 2010 12.43:42, Daniel Mack a ?crit :
> > On Tue, Jun 15, 2010 at 12:34:23PM +0200, Wolfram Sang wrote:
> > > The old code registered the hcd even if there were no transceivers
> > > detected, leading to oopses like this if we try to probe a non-existant
> > > ULPI:
> > 
> > Hmm. I'm aware that there was a missing bail in this function, but
> > actually, I had hardware which didn't properly detect the ULPI chip but
> > still worked fine. There has been quite some discussion here about that,
> > and eventually I decided to not make this a hard error as it didn't
> > really harm.
> > 
> > > [    2.730000] mxc-ehci mxc-ehci.0: unable to init transceiver
> > > [    2.740000] timeout polling for ULPI device
> > > [    2.740000] timeout polling for ULPI device
> > > [    2.750000] mxc-ehci mxc-ehci.0: unable to enable vbus on transceiver
> > > [    2.750000] mxc-ehci mxc-ehci.0: Freescale On-Chip EHCI Host
> > > Controller [    2.760000] mxc-ehci mxc-ehci.0: new USB bus registered,
> > > assigned bus number 2 [    2.770000] Unhandled fault: external abort on
> > > non-linefetch (0x808) at 0xc4876184 [    2.770000] Internal error: : 808
> > > [#1] PREEMPT
> > > [    2.770000] last sysfs file:
> > > [    2.770000] Modules linked in:
> > > [    2.770000] CPU: 0    Not tainted  (2.6.33.5 #5)
> > > [    2.770000] PC is at ehci_hub_control+0x4d4/0x8f8
> > > [    2.770000] LR is at ehci_mxc_setup+0xbc/0xdc
> > > [    2.770000] pc : [<c0196dfc>]    lr : [<c019bc8c>]    psr: 00000093
> > > [    2.770000] sp : c3815e40  ip : 00000001  fp : 60000013
> > > [    2.770000] r10: c4876184  r9 : 00000000  r8 : c3814000
> > > [    2.770000] r7 : c391d2cc  r6 : 00000001  r5 : 00000001  r4 : 00000000
> > > [    2.770000] r3 : 80000000  r2 : 00000007  r1 : 80000000  r0 : c4876184
> > > [    2.770000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> > > Segment kernel [    2.770000] Control: 0005317f  Table: a0004000  DAC:
> > > 00000017 [    2.770000] Process swapper (pid: 1, stack limit =
> > > 0xc3814270)
> > 
> > But that, of course, changes everthing. If you happen to see such
> > Ooopses, your patch should go in, and I will check the boards again and
> > see if they still fail to probe the ULPI. Eventually, we might need some
> > kind of quirks field in the platform data :(
> > 
> 
> Have you tried my imx31 EHCI controller init patch applied ? 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014729.html

No, I haven't yet, as I'm not currently working on such a board. But I
will once I get back to that issue. Thanks for the reminder :)

Daniel
