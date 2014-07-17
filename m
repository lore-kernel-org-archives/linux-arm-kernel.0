From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 17 Jul 2014 15:55:06 +0200
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <20140716065505.GB2612@dragon>
References: <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
 <20140625125306.GB6917@dragon>
 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
 <20140628143712.GA7869@dragon>
 <1404135864.4305.23.camel@weser.hi.pengutronix.de>
 <20140701065105.GE14471@dragon>
 <1404724251.4587.20.camel@weser.hi.pengutronix.de>
 <20140707135502.GR30239@dragon> <20140716065505.GB2612@dragon>
Message-ID: <1405605306.12800.7.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Mittwoch, den 16.07.2014, 14:55 +0800 schrieb Shawn Guo:
> On Mon, Jul 07, 2014 at 09:55:03PM +0800, Shawn Guo wrote:
> > On Mon, Jul 07, 2014 at 11:10:51AM +0200, Lucas Stach wrote:
> > > Hi Shawn,
> > > 
> > > Over the weekend I tried to reproduce your problem on a SabreSD board,
> > > but wasn't able to trigger the issue. 3.16-rc3 with PCIe active works
> > > just fine over a suspend and resume cycle for me.
> > 
> > That's strange.  In my setup, PCIe support is enabled in kernel and DT,
> > but I do not have a PCIe device connected to the board.
> > 
> > > 
> > > One possibly relevant difference is that I've booted with NFSroot, while
> > > it seems you are using a SATA connected device. Is this right?
> > 
> > I have a SATA disk connected, but did boot with NFSroot.
> > 
> > > If so,
> > > can you test if it works if you boot from SDcard or the like? This might
> > > be relevant as PCIe and SATA share some clocks.
> > 
> > I tried to disable SATA support completely, but it doesn't help.
> 
> Lucas, any news on this?  Or should we just try to use Richard's patch
> to solve the problem?

I would like to understand the problem first before throwing "fixes" at
the issue. As you said this isn't a regression we are in no hurry and
should try to analyze the issue properly. I just retested and I'm still
not able to reproduce the issue on my SabreSD. Maybe there are board
revision that exhibit different behavior? My board has two sticks on
saying "Rev B3" and "Rev X3".

As you can see from the log suspend/resume is working fine for me with
kernel 3.16-rc5 + imx_v6_v7_defconfig.

root at XXX:~ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.004 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 95.846 msecs
PM: suspend devices took 0.100 seconds
PM: late suspend of devices complete after 5.395 msecs
PM: noirq suspend of devices complete after 4.914 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 1556.385 msecs
PM: early resume of devices complete after 3.134 msecs
PM: resume of devices complete after 153.568 msecs
PM: resume devices took 0.160 seconds
Restarting tasks ... done.
ata1: SATA link down (SStatus 0 SControl 300)
fec 2188000.ethernet eth0: Link is Down
fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
root at XXX:~ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 87.638 msecs
PM: suspend devices took 0.090 seconds
PM: late suspend of devices complete after 4.528 msecs
PM: noirq suspend of devices complete after 5.031 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 1425.302 msecs
PM: early resume of devices complete after 2.736 msecs
PM: resume of devices complete after 156.013 msecs
PM: resume devices took 0.160 seconds
Restarting tasks ... done.
ata1: SATA link down (SStatus 0 SControl 300)
fec 2188000.ethernet eth0: Link is Down
fec 2188000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
root at XXX:~

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
