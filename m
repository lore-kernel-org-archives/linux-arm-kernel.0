From: phdm@macq.eu (Philippe De Muyter)
Date: Sun, 6 Nov 2016 16:31:17 +0100
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <1427377198.3378.16.camel@pengutronix.de>
Message-ID: <20161106153117.GA22538@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM i.MX6q experts,

sorry to come back with an old problem.  I work with with two
different custom boards, designed after the SabreSD board with imx6dl
and imx6q cpus, and I have exactly the same problem : linux kernel hangs
in imx6_pcie_assert_core_reset() at the line :
	val = readl(pp->dbi_base + PCIE_PL_PFLR);
this happens constantly after a watchdog reset, and also
sometimes (or on some boards) after a reboot.  As we know that
U-Boot on our boards will never mess with the PCI setup, and
that if the PCIe block is configured, it has certainly be
configured by the previous kernel session, I have merely disabled the
code block trying to put back the PCIe block into configurable state.
I have no problem so far, but do you agree that this is a valid fix ?

I use either v3.17 or Freescale's 4.1.15_1.2.0_ga

Best Regards,

Philippe

On Thu, Mar 26, 2015 at 12:39:58PM +0000, Lucas Stach wrote:
> Hi Tim,
> 
> Am Donnerstag, den 26.03.2015, 06:23 -0700 schrieb Tim Harvey:
> > On Thu, Mar 26, 2015 at 4:06 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > > Am Mittwoch, den 25.03.2015, 11:32 +0100 schrieb Stefan Roese:
> > > Okay, I've looked a bit into this and it seems there is no easy solution
> > > available. It is really unfortunate that the WD reset doesn't reset the
> > > GPR registers. Also I have no idea if the WD reset properly resets the
> > > PCIe core, as the reset signal of this core is only wired to the POR
> > > line.
> > >
> > > To fix this (almost) properly we would have to change the complete init
> > > order of the core, which isn't an easy task, as experience has shown
> > > that even small changes in that area can prevent the link from coming up
> > > under certain circumstances.
> > >
> > > Which brings me back to my earlier assertion that WD reset should really
> > > be done through the PMIC. That's yet another case of a WD making the
> > > overall system more instable.
> > >
> > > I think the easiest workaround for now is to detect the WD reset in your
> > > bootloader and bash the expected default values into the GPR bits.
> > >
> > > Regards,
> > > Lucas
> > 
> > Lucas,
> > 
> > There are many boards out there that unfortunately don't reset PMIC's
> > properly, IMHO due to a confusing reference design from Freescale.
> > 
> > Using the WDOGx_WRSR register we can detect the reason for reset:
> >  Bit 4 - POR - Power on reset
> >  Bit 1 - TOUT - Watchdog timeout
> >  Bit 0 - SFTW - Software reset (used in machine_restart)
> > 
> > Can we reset the GPR registers based on bits 0 or 1 set, or use these
> > as further qualifiers in the WAR?
> > 
> Doing it in the kernel is too late. This WAR is specifically to work
> around bootloaders leaving the PCI link running when jumping into the
> kernel. We use the GPR bits to detect if the bootloader has touched the
> PCIe core. Unfortunately we see the same signature if the kernel touched
> PCIe and the system got reset by the WD.
> 
> If we reset the GPR bits depending on the reset reason register in the
> kernel we have no way to know if the bootloader has touched the PCIe
> core after a WD reset (in which case we still need to apply the WAR). So
> the only way to keep the WAR working while cleaning out bad WD reset
> behavior is to reset the GPR bits in the bootloader, before the
> bootloader itself may touch the PCIe core.
> 
> It may be possible to come up with a solution for this in the kernel by
> looking at the PCIe clock status when entering the kernel, but this
> means that we scatter even more WAR code for the bad Freescale PCIe
> integration throughout the kernel, as such code has to go into the
> platform as we don't have the required information at hand in the PCI
> driver. So I'm not really thrilled by thinking about doing it in the
> kernel.
> 
> Regards,
> Lucas
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
