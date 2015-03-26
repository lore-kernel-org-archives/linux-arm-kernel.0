From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 26 Mar 2015 12:06:15 +0100
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <55128EC8.6080805@denx.de>
References: <55128016.3030903@denx.de>
 <1427276390.2813.7.camel@pengutronix.de> <55128EC8.6080805@denx.de>
Message-ID: <1427367975.3378.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 25.03.2015, 11:32 +0100 schrieb Stefan Roese:
> On 25.03.2015 10:39, Lucas Stach wrote:
> > Am Mittwoch, den 25.03.2015, 10:29 +0100 schrieb Stefan Roese:
> >> Hi!
> >>
> >> I'm currently facing a problem in the imx6 PCIe driver. The
> >> problem happens, after the Linux imx6 internal watchdog has timed-out
> >> and issues a reset (this is intended, as I'm testing this wdog right
> >> now). But the next Linux boot hangs in imx6_pcie_assert_core_reset()
> >> while accessing a register from the PCIe port logic memory:
> >>
> >> 		val = readl(pp->dbi_base + PCIE_PL_PFLR);
> >>
> >> The watchdog will issue a new reset once it times out again. But
> >> Linux will hang here the next time as well. Only a power-cycle
> >> helps. For a test purpose, I've removed the following part from
> >> this function:
> >>
> >> 	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> >> 	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> >> 		...
> >> 	}
> >>
> >> Without it, Linux boots up fine. And PCIe also seems to be fully
> >> functional.
> >>
> >> I have to admit that I have no real insight in the imx6 / DW PCIe
> >> driver. So I'm checking with you experts, if you have any ideas why
> >> this could be the case? And how this could be solved.
> >>
> >> BTW: This happens with v3.19 and v4.0-rc5 on a i.MX6Solo based board
> >> (TQMa6S SoM). With no PCIe support enabled in the bootloader (U-Boot).
> >
> > The problem here is that the LTSSM state machine stays in "Link" state
> > after the WD reset and no configuration of the core can happen in this
> > state. The path inside the above if clause applies a workaround the get
> > LTSSM back into the initial state.
> >
> > As this is a bit racy and not the intended way to do things we only
> > apply this workaround if we are relatively certain that the PCIe link
> > had been enabled without a reset to the core before.
> 
> Thanks for the explanation.
> 
> > So what you are saying is that after the WD reset the GPR registers are
> > cleared?
> 
> No, they are not cleared.
> 
> After a power-on reset, these are the GPR values:
> gpr1=48401005 gpr12=0f000000
> 
> Here the values after a "normal" reset issued via the reboot command:
> gpr1=48441005 gpr12=0f004090
> 
> This is because of the shutdown handler calling
> imx6_pcie_assert_core_reset().
> 
> Now after the watchdog reset, its a bit different:
> gpr1=48411005 gpr12=0f004490
> 
> So this is only time (in my test cases), that the if clause is
> entered (and hangs).
> 
> > If so we may need to make the logic to decide when to apply
> > this WAR a bit smarter.
> 
Okay, I've looked a bit into this and it seems there is no easy solution
available. It is really unfortunate that the WD reset doesn't reset the
GPR registers. Also I have no idea if the WD reset properly resets the
PCIe core, as the reset signal of this core is only wired to the POR
line.

To fix this (almost) properly we would have to change the complete init
order of the core, which isn't an easy task, as experience has shown
that even small changes in that area can prevent the link from coming up
under certain circumstances.

Which brings me back to my earlier assertion that WD reset should really
be done through the PMIC. That's yet another case of a WD making the
overall system more instable.

I think the easiest workaround for now is to detect the WD reset in your
bootloader and bash the expected default values into the GPR bits.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
