From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 11 Feb 2016 15:25:22 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <20160211084029.GE13664@pengutronix.de>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
 <CAOMZO5AE6HwBYz7kOFORt0HTojJLSb0MYUbkb_HCshDHy=d27g@mail.gmail.com>
 <20160210150315.GC13664@pengutronix.de>
 <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
 <20160211084029.GE13664@pengutronix.de>
Message-ID: <20160211152522.75faf7fa@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 11 Feb 2016 09:40:29 +0100 Uwe Kleine-K?nig wrote:
> On Wed, Feb 10, 2016 at 06:10:18PM -0200, Fabio Estevam wrote:
> > Hi Uwe,
> > 
> > On Wed, Feb 10, 2016 at 1:03 PM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > Hello Fabio,
> > >
> > > On Tue, Feb 02, 2016 at 11:00:33AM -0200, Fabio Estevam wrote:
> > >> On Wed, Jan 27, 2016 at 12:43 PM, Uwe Kleine-K?nig
> > >> <u.kleine-koenig@pengutronix.de> wrote:
> > >>
> > >> > So you didn't hit the problem that resetting a saif didn't work, right?
> > >>
> > >> No, we haven't seen this reset issue.
> > >>
> > >> > Do you have a few more technical details here? A usecase of my machine
> > >>
> > >> Let me find out as it has been several years I worked on this problem.
> > >> Will let you know.
> > >
> > > Anything new on your end? I know from Lothar that he invested quite some
> > > time to debug his hardware setup, tested the codec instead of the i.MX28
> > > as clock provider and several more things. I also spend some time on
> > > this issue and we both hope that Freescale/NXP can help in better
> > > understanding the issue and hopefully can come up with a recipe to make
> > > concurrent recording and playback on i.MX28 work.
> > >
> > > Lothar is in contact with Freescale, too, but up to now with little
> > > success. The company I'm working for at the moment would also welcome a
> > > solution here.
> > 
> > Sorry for the delay. I have been on holidays.
> 
> I wonder who granted you to go on holidays given that we have
> problems :-)
> 
> > Can you confirm you have both SAIF interfaces being clocked from ref_pll?
> 
> root at hostname:/sys/kernel/debug/clk find -name saif?_sel
> ./ref_xtal/pll0/saif0_sel
> ./ref_xtal/pll0/saif1_sel
> 
> root at hostname:/sys/kernel/debug/clk cat ./ref_xtal/pll0/saif?_sel/clk_rate 
> 480000000
> 480000000
> 
> This is based on 3.10 (but I hope to update soon to 4.4ish). I know that
> Lothar uses 4.4. Also Lothar noticed that disabling one of these
> saif_sel clocks doesn't make an impression on the interfaces, they just
> continue to run. Maybe a clock is routed in a wrong way?
> 
That's obviously some misunderstanding.
What I observed is, that by selectively disabling and re-enabling one of
the SAIF clocks in any way (toggling the CLKGATE bit in the
CLKCTRL_SAIF# register, toggling the RUN bit in the SAIF_CTRL register
or even toggling the SLAVE_MODE bit in the SAIF_CTRL register) the SAIF
interfaces get out of sync (if they happened to be in sync in the first
place) with no way to deterministically get them in sync again.

Since the SAIF0 clock is routed to the codec, sampling the data on the
SAIF1 interface is not in sync with the data sent by the codec.

I also tried tying the BITCLK resp. LRCLK of both SAIFs together and
selecting the SAIF1 inputs as source via the SAIF_CLKMUX_SEL field in
the DIGCTL_CTRL register. Even with this setup there is no way to get
consistent data sampled on the SAIF1 interface.


Lothar Wa?mann
