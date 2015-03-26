From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 26 Mar 2015 06:23:55 -0700
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <1427367975.3378.6.camel@pengutronix.de>
References: <55128016.3030903@denx.de> <1427276390.2813.7.camel@pengutronix.de>
 <55128EC8.6080805@denx.de> <1427367975.3378.6.camel@pengutronix.de>
Message-ID: <CAJ+vNU3inhq+zva2Df1upw=i7b==Ksd2gzfcQ2x3JKPGEjGQ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 4:06 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Mittwoch, den 25.03.2015, 11:32 +0100 schrieb Stefan Roese:
> Okay, I've looked a bit into this and it seems there is no easy solution
> available. It is really unfortunate that the WD reset doesn't reset the
> GPR registers. Also I have no idea if the WD reset properly resets the
> PCIe core, as the reset signal of this core is only wired to the POR
> line.
>
> To fix this (almost) properly we would have to change the complete init
> order of the core, which isn't an easy task, as experience has shown
> that even small changes in that area can prevent the link from coming up
> under certain circumstances.
>
> Which brings me back to my earlier assertion that WD reset should really
> be done through the PMIC. That's yet another case of a WD making the
> overall system more instable.
>
> I think the easiest workaround for now is to detect the WD reset in your
> bootloader and bash the expected default values into the GPR bits.
>
> Regards,
> Lucas

Lucas,

There are many boards out there that unfortunately don't reset PMIC's
properly, IMHO due to a confusing reference design from Freescale.

Using the WDOGx_WRSR register we can detect the reason for reset:
 Bit 4 - POR - Power on reset
 Bit 1 - TOUT - Watchdog timeout
 Bit 0 - SFTW - Software reset (used in machine_restart)

Can we reset the GPR registers based on bits 0 or 1 set, or use these
as further qualifiers in the WAR?

Tim
