From: r.herring@freescale.com (Rob Herring)
Date: Tue, 06 Jul 2010 10:28:04 -0500
Subject: [PATCH 3/4] mx25: fix time accounting
In-Reply-To: <20100512104523.GB19283@jasper.tkos.co.il>
References: <20100125105439.GE6724@jasper.tkos.co.il>
	<fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
	<20100511154349.GZ31199@pengutronix.de>
	<20100512050627.GA19283@jasper.tkos.co.il>
	<20100512094642.GB31199@pengutronix.de>
	<20100512104523.GB19283@jasper.tkos.co.il>
Message-ID: <1278430084.8041.1.camel@ra7055-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch,

On Wed, 2010-05-12 at 13:45 +0300, Baruch Siach wrote:
> Hi Sascha,
> 
> On Wed, May 12, 2010 at 11:46:42AM +0200, Sascha Hauer wrote:
> > On Wed, May 12, 2010 at 08:06:28AM +0300, Baruch Siach wrote:
> > > On Tue, May 11, 2010 at 05:43:49PM +0200, Sascha Hauer wrote:
> > > > On Mon, Jan 25, 2010 at 12:58:21PM +0200, Baruch Siach wrote:
> > > > > The gpt_clk rate function doesn't consider the PER divider. This causes a
> > > > > significant drift in time accounting. Fix this by introducing the correct rate
> > > > > calculation function.
> > > > 
> > > > Should have tested this one. In fact with this patch applied my clock
> > > > goes wrong.
> > > > 
> > > > The i.MX Timer code makes sure the gpt clock is sourced from the ipg
> > > > clock (GPTCR[6:8] = 1), so the behaviour should be correct the way it
> > > > was before this patch. Any idea why it was wrong on your hardware? Have
> > > > you changed the GPTCR bits?
> > > 
> > > No. My current platform is the i.MX25 PDK. I've added the following to my 
> > > mx25pdk_init():
> > > 
> > > debugfs_create_x32("gptcr", 0444, NULL,
> > >     (u32*)MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR));
> > > 
> > > When the system is running I get:
> > > 
> > > # cat /debugfs/gptcr 
> > > 0x00000249
> > > 
> > > That is GPTCR[6:8] = 1.
> > > 
> > > The same clock calculation is being done in the platform code of the Freescale 
> > > supplied kernel (now based on 2.6.31).  Can you get this one running on your 
> > > platform?
> > 
> > I just checked the fsl 2.6.31 source. They really pass the per_clk to
> > the timer, but they also change the timer source to MX3_TCTL_CLK_PER
> > (2<<6).
> 
> Strange. The i.MX25 Reference Manual says nothing about PER in the CLKSRC 
> field of GPTCR. The relevant text from 28.5.2.1 "GPT Control Register (GPTCR)" 
> is:
> 
> 000 No clock
> 001 ipg_clk
> 010 ipg_clk_highfreq
> 011 ipp_ind_clkin (external clock from pad)
> 1xx ipg_clk_32k
> 
> So ipg_clk_highfreq == PER clock? Can anyone from Freescale shed some light on 
> this?

Yes, ipg_clk_highfreq is per_clk.

Rob
