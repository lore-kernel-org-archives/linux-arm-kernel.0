From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 08 Apr 2015 15:37:06 +0200
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <CAOMZO5CDOJXp3Hbe8a9dPh=krWhw-i5i8Zoa5Hb+2XGAdou7ew@mail.gmail.com>
References: <55128016.3030903@denx.de>
 <CAOMZO5CDOJXp3Hbe8a9dPh=krWhw-i5i8Zoa5Hb+2XGAdou7ew@mail.gmail.com>
Message-ID: <1428500226.2809.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 08.04.2015, 10:32 -0300 schrieb Fabio Estevam:
> Hi Stefan,
> 
> On Wed, Mar 25, 2015 at 6:29 AM, Stefan Roese <sr@denx.de> wrote:
> > Hi!
> >
> > I'm currently facing a problem in the imx6 PCIe driver. The
> > problem happens, after the Linux imx6 internal watchdog has timed-out
> > and issues a reset (this is intended, as I'm testing this wdog right
> > now). But the next Linux boot hangs in imx6_pcie_assert_core_reset()
> > while accessing a register from the PCIe port logic memory:
> 
> I am not able to reproduce this problem on a imx6q-sabresd.
> 
> Even with PCI enabled in U-boot, when I run 'reboot' the kernel
> re-starts fine here.
> 
If you do a proper shutdown in Linux the kernel will make sure to
properly disable PCIe before rebooting and leave things behind in a
deterministic state.

The problem appears when a watchdog reset happens, so the kernel has no
chance to clean things up before rebooting. This isn't a problem if you
do a full system reset via the watchdog out line to the PMIC, but gets
ugly if only the i.MX6 is reset (which apparently doesn't clear the GPR
bits).

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
