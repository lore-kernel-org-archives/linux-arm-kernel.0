From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 28 Jan 2016 07:38:36 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <20160127144340.GD13664@pengutronix.de>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
Message-ID: <20160128073836.605f49bf@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 27 Jan 2016 15:43:40 +0100 Uwe Kleine-K?nig wrote:
> Hello Fabio,
> 
> [dropping Jack Lee from Cc: as his address doesn't exist.]
> 
> On Wed, Jan 27, 2016 at 09:53:18AM -0200, Fabio Estevam wrote:
> > On Wed, Jan 27, 2016 at 8:56 AM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > I currently work with an i.MX28 based machine and occasionally when
> > > recording sound with arecord but no microphone connected the result
> > > contains much noise.
> > >
> > > I found commits
> > >
> > >         90ce77d4468e ENGR00285446-3 [MX28] SAIF: Bit Shift in SAIF RX Data
> > >         1ea685a12f19 ENGR00285446-2 [MX28] SAIF: Bit Shift in SAIF RX Data
> > >         1ca899221d8b ENGR00285446-1 [MX28] SAIF: Bit Shift in SAIF RX Data
> > >
> > > in the Freescale vendor kernel (branch imx_2.6.35_maintain at
> > > git://git.freescale.com/imx/linux-2.6-imx.git). The kernel running on
> > > the machine in question is based on 3.10 with an impressive (that's
> > > negative) patch stack on top. I think patches -2 and -3 are not relevant
> > > for my setup because the two saif clocks are configured identically if
> > > I'm not mistaken. However implementing the soft reset as is done in
> > 
> > Please make sure that the two saif clocks are configured identically.
> 
> I think I have that. According to $debugfs/clk the two saif clocks have
> the same parent and frequency.
> 
> > This was the most important part of the fix when we worked on this
> > problem on 2.6.35.
> 
> So you didn't hit the problem that resetting a saif didn't work, right?
> 
According to the i.MX28 Ref. Manual CLKGATE of the SAIF block does NOT
automatically assert upon asserting SFTRST:
|35.3.1 SAIF Control Register (HW_SAIF_CTRL)
[...]
|HW_SAIF_CTRL field descriptions
| Field Description
|  31   | Setting this bit to 1 forces a reset to the entire block. SFTRST has no effect on CLKGATE. Also, the
|SFTRST | SFTRST bit may be written when CLKGATE=1. This bit must be cleared to 0 for normal operation.

So the standard stmp_reset_block() function won't work for the
SAIF block.

BTW: I'm currently investigating the same problem...


Lothar Wa?mann
