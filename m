From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Dec 2011 13:14:14 +0800
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <4EE192DC.3080209@nvidia.com>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B77BD8@HQMAIL01.nvidia.com>
 <20111209010147.GH7913@S2100-06.ap.freescale.net>
 <4EE18403.30604@nvidia.com>
 <20111209043220.GJ7913@S2100-06.ap.freescale.net>
 <4EE192DC.3080209@nvidia.com>
Message-ID: <20111209051413.GK7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:47:24PM -0700, Stephen Warren wrote:
> On 12/08/2011 09:32 PM, Shawn Guo wrote:
> > On Thu, Dec 08, 2011 at 08:44:03PM -0700, Stephen Warren wrote:
> >> On 12/08/2011 06:01 PM, Shawn Guo wrote:
> >>> On Thu, Dec 08, 2011 at 03:14:40PM -0800, Stephen Warren wrote:
> >>>> Presumably, the set of pins, groups, and functions is determined by the
> >>>> SoC HW. Platform data is usually board-specific rather than SoC specific.
> >>>> You have two choices here: You could either parse this data from device
> >>>> tree as Arnd suggested (and I think as the TI OMAP pinctrl driver will),
> >>>> or do what I've done in the Tegra pinctrl driver, and simply put each
> >>>> SoC's data into the driver and select which one to use based on the DT
> >>>> compatible flag; I didn't see the point of putting data in to the DT that
> >>>> was identical for every board using a given SoC.
> >>>>
> >>> I'm not sure about tegra, but for imx, it's very difficult to enumerate
> >>> all these data and list them in pinctrl driver.  Sascha gave a few
> >>> examples when we discussed about it in another thread.  The TX and RX
> >>> pin of UART has 4 options each.  SD could possibly have 1, 4, and 8
> >>> data lines.  Display interface could have 16, 24, 32 data lines, etc.
> >>> All these options are chosen by board design for given soc pinmux
> >>> design.  So putting this data into device tree makes sense for imx too.
> >>
> >> The pinctrl driver should simply represent the raw options that the HW
> >> supports on each individual pin. This table should be readily enumerable
> ...
> > The situation is there might be a few possible pin groups for each
> > function of 16/24/32-bit display.   Let's think about the UART case
> > I put above, to enumerate all the groups, we will have 16 groups for
> > one UART instance.  And we have 5 UART ports on recent imx SoC.
> 
> I'm not familiar with imx. For my education, which of the following is true:
> 

It's the case b).

> a)
> 
> * UART TX signal can muxed onto 1 of 16 pins
> * UART RX signal can muxed onto 1 of 16 pins
> 
> In this case, you'd just list say "UART A TX" as a legal function for
> each of those 16 pins. Yes, that's a lot of places, but still do-able.
> 
> (16 possible positions would be a lot, but I suppose it is possible in HW)
> 
> b)
> 
> * UART TX signal can muxed onto 1 of 4 pins
> * UART RX signal can muxed onto 1 of 4 pins
> * So, there are 16 (4*4) combinations of these two settings
> 
> In this case, you'd just list say "UART A TX" for the 4 pins, and "UART
> A RX" for the other 4 pins. The 16 combinations don't come into play at
> all; the board-specific mapping table would pick 1 single combination,
> and represent this as:
> 
> pin X: function = UART A TX
> pin Y: function = UART A RX
> 

We really do not expect per pin function mapping but per block function
mapping.  That said, the UART driver is going to tell pinctrl subsystem
"I'm UARTA, please set all my pins up for me".

> Either way though, whether you put the data into tables in the driver or
> in the SoC .dtsi file (included by each board's .dts file), the pinctrl

We are not going to list that into SoC .dtsi file.

> driver's table really should list all possible options, and the pinctrl
> mapping table should select just one; that's kinda the whole point of
> the tables. If you try to put just the used subset into device tree, you
> won't be able to put it into the .dtsi file since it'll be
> board-specific, and you'll end up forcing board .dts authors to recreate

That's what we are going to do.

> that driver's complete configuration table every time, which seems like
> a lot of wasted work.

If we understand that it's a board specific design for given SoC pinmux
superset, it's natural to me that the board (.dts) author should create
the subset for his board.

Regards,
Shawn

> (and yes, this might bloat the .dtsi file, and
> mean a lot of useless device tree parsing, which is why I personally
> chose not to put the SoC tables into the device tree).
> 
