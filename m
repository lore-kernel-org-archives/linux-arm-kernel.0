From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 22 Mar 2017 19:48:01 +0200
Subject: [RFC 7/8] cpufreq: imx6q: Initialize LDO bypass
In-Reply-To: <1490202585.29056.5.camel@pengutronix.de>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <75ec3ea8fe812b4cf689e0c130358e81aa7fbd13.1490199005.git.leonard.crestez@nxp.com>
 <1490202585.29056.5.camel@pengutronix.de>
Message-ID: <1490204881.17057.16.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-22 at 18:09 +0100, Lucas Stach wrote:
> Am Mittwoch, den 22.03.2017, 18:53 +0200 schrieb Leonard Crestez:
> > 
> > Several imx6* socs have three built-in regulators LDO_ARM LDO_SOC and
> > LDO_PU used to control internal chip voltages. "ldo-bypass" mode refers
> > to placing these regulators in bypass mode and controlling voltages from
> > an external power management chip instead. This is intended to save
> > power at the expense of an extra PMIC on the board.
> > 
> > The voltages for these regulators are controlled from the imxq6 cpufreq
> > driver so it makes sense to also control LDO bypass from here. The gpc
> > driver also fetches a reference to LDO_PU and uses it to gate power to
> > graphics blocks.
> > 
> > The LDO regulator has a minimum dropout voltage of 125mv so enabling
> > bypass mode will raise the effective voltage by that amount. We need set
> > the minimum frequency first to avoid overvolting when enabling LDO
> > bypass.
> > 
> > The binding is an u32 fsl,ldo-bypass in the gpc node because that's how
> > it was defined in the freescale vendor tree for a long time and
> > compatibility is desirable. Otherwise it would be a bool.
> > 
> > Some versions of u-boot shipped by freescale check this same property
> > and set regulators in bypass mode before linux actually starts so we
> > check for that scenario as well and finish early.
> I've not looked at the patch at all, but this feels like the wrong
> location to implement this. Using bypass mode or not should really be a
> internal decision of the regulator driver, influenced by a DT property
> to allow bypass mode.
> 
> The regulator driver can also implement the correct sequencing of first
> lowering external voltage to min + dropout, then going into bypass mode,
> then lower the external voltage by the amount of the dropout. I don't
> see why we need a frequency switch for this at all.

Because minimum voltages are dictated by core frequency. At high frequency
the (minimum voltage for frequency + dropout) is too high and would go beyond
the maximum of 1300 mv when bypass is enabled. It doesn't actually instantly
break, this is based on the "operating ranges" from this document:

http://www.nxp.com/assets/documents/data/en/data-sheets/IMX6DQCEC.pdf

> Implementing this in the consumers seems like the wrong spot.

It doesn't belong in drivers for individual regulators either, it's a piece
of board-level global configuration.

--
Regards,
Leonard
