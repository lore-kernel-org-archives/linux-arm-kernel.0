From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 11:57:38 +0100
Subject: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
In-Reply-To: <20131112023033.GA23243@MrMyself>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
 <20131112014913.GE11083@S2101-09.ap.freescale.net>
 <20131112023033.GA23243@MrMyself>
Message-ID: <20131112105738.GF30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 12, 2013 at 10:30:34AM +0800, Nicolin Chen wrote:
> Hi Markus,
> 
> On Tue, Nov 12, 2013 at 09:49:16AM +0800, Shawn Guo wrote:
> > Copy Nicolin.
> > 
> > Shawn
> > 
> > On Mon, Nov 11, 2013 at 05:03:36PM +0100, Markus Pargmann wrote:
> > > There is a hardware issue when using capture and playback at the same
> > > time. In the tested scenario, the capture stream was started slightly
> > > before the playback stream. The first time the application starts after
> > > a powerup, there is a high probability that the SSI unit does not send a
> > > request to the SDMA unit. The playback does not work. I tested this on
> > > i.MX53 with SSI unit 2 kernel 3.10.10.
> 
> I've been tested SSI with WM8962 on i.MX6 series for a while, and never met
> this issue, well, not with 3.10.10 original code and i.MX53 though.
> 
> Could you please provide me a reproducible flow? 
> 
> If playback first and capture later, would this also reproduce the issue?
> 
> Is there any command must be executed before the arecord | aplay, or just
> run it after system boot-up?
> 
> By trying to reproduce it on i.MX6, we can confirm if it's a common issue
> to the IP or its driver, or just a hardware defect within i.MX53.

I just tested a patch from J?rgen Beisert "fix SDMA starvation" [1]. It
solves exactly this issue but was not applied. I will rebase the patch
onto the latest sound tree and resend it.

Thanks,

Markus Pargmann

[1] http://thread.gmane.org/gmane.linux.sound/1724

> 
> Thank you,
> Nicolin Chen
> 
> ---
> 
> > > 
> > > Here is a register dump of the situation:
> > > SDMA
> > > 0x63fb0000
> > > 00000000: c0040000 00000000 0000001e 00000000
> > > 00000010: 00000001 ffffffff 00000000 e03efa41
> > > 00000020: 00000000 00000000 00000000 00000000
> > > 00000030: 00000064 00000000 00000003 00000000
> > > 00000040: 00000000 00000000 00000000 00006000
> > > 00000050: 00000000 00000000 00000001 00004050
> > > 00000060: 01208000 00000000 00000000 00000000 /* 0x60: EVT_MIRROR showing all received DMA requests */
> > >            ^ This should be a 3 instead. Bits 24 and 25 are the DMA requests for
> > >              RX and TX. Bit 25 is not set, DMA request 25 is missing.
> > > 
> > > SSI
> > > 0x50014000
> > > 00000000: 00000000 00000000 0000005f 00000000
> > > 00000010: 00000457 000050c1 01f80f00 0000028d /* 0x14: ISR Interrupt status register */
> > >                           ^
> > > 	     At 0x14 we can clearly see the last bit is set (0x1) which
> > > 	     is TFE0, Transmit FIFO 0 empty. So it should automatically
> > > 	     request data from the DMA engine, but it doesn't.
> > > 
> > > 00000020: 0000028d 0004e000 00040000 000010dd
> > > 00000030: 00001f1f 00000000 00000000 00000000
> > > 00000040: 00000000 00000000 00000000 00000000
> > > 00000050: 00000000 00000000 ........
> > > STATS (/sys/bus/platform/devices/50014000.ssi/statistics)
> > > rfrc=0
> > > tfrc=0
> > > roe1=0
> > > roe0=0
> > > tue1=0
> > > tue0=1094475
> > > 
> > > I could solve this issue by filling the transmit FIFO with data. After
> > > that, the SDMA unit receives DMA request 25 again and audio playback
> > > works.
> > > 
> > > This patch adds TUE0 interrupt handler which fills FIFO0 with arbitrary data.
> > > 
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > > 
> > > Hi,
> > > 
> > > does anyone have an idea why the SSI unit does not request DMA by its own at
> > > the beginning? Or is it a hardware errata that is not listed yet?
> > > 
> > > Regards,
> > > 
> > > Markus Pargmann
> > > 
> > > 
> > >  sound/soc/fsl/fsl_ssi.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > > index 6b81d0c..8faf2b5 100644
> > > --- a/sound/soc/fsl/fsl_ssi.c
> > > +++ b/sound/soc/fsl/fsl_ssi.c
> > > @@ -269,9 +269,14 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
> > >  	}
> > >  
> > >  	if (sisr & CCSR_SSI_SISR_TUE0) {
> > > +		int i;
> > > +
> > >  		ssi_private->stats.tue0++;
> > >  		sisr2 |= CCSR_SSI_SISR_TUE0;
> > >  		ret = IRQ_HANDLED;
> > > +
> > > +		for (i = 0; i != ssi_private->fifo_depth; ++i)
> > > +			write_ssi(0x0, &ssi->stx0);
> > >  	}
> > >  
> > >  	if (sisr & CCSR_SSI_SISR_TFS) {
> > > -- 
> > > 1.8.4.2
> > > 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
