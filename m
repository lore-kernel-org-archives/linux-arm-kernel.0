From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jan 2011 16:09:05 -0000
Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet
	controller	in board_init
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
References: <1295968956-10166-1-git-send-email-hvaibhav@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
Message-ID: <000e01cbbcaa$30b74350$9225c9f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller
> > in board_init
> >
> > With addition of hwmod support to gpio, the ethernet controller
> > goes undetected for OMAP35xEVM. So explicitly assert the reset signal to
> > ethernet controller smsc911x -
> >
> > 	- GPIO7 (>=RevG version of EVM's)
> > 	- GPIO64 (<=RevD version of EVM's)
> >
> > This patch is based on intial version from Charulatha V, reference
> > to original discussion -
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg35784.html
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Tested-by: Kevin Hilman <khilman@ti.com>

Out of interest - have you tried this network chip (smsc9118) in an SMP
environment [is it on OMAP4?]? On the Versatile Express it's quite easy to
get it to `lock up'. It claims to be servicing interrupts but you certainly
don't get any useful packets. and ifdown/ifup brings it back to life again.

I took a brief look at the driver and found a few issues there:

1.) Read-after-read and read-after-write minimum delays aren't respected
2.) The locking is too low-level (it's around the register accessors) so
    there is plenty of scope for deadlock if a calling function holds some
    other locks too.
3.) FIFO fastforwarding uses the word count instead of the byte count.
4.) Bit 20 of the HW_CFG register apparently always needs to be asserted,
    but it's 0 out of reset (who knows what they were thinking?!).

I tried to resolve these problems (admittedly as a quick bit of hacking)
but the issue persists.

Anyway, it would just be nice to know if anybody else has seen problems
with this chip/driver because it makes the Versatile Express pretty much
useless as a remote box.

Will
