From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 4 Jul 2010 11:43:44 +0300
Subject: [PATCH 3/4] mx25: fix time accounting
In-Reply-To: <20100512094642.GB31199@pengutronix.de>
References: <20100125105439.GE6724@jasper.tkos.co.il>
	<fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
	<20100511154349.GZ31199@pengutronix.de>
	<20100512050627.GA19283@jasper.tkos.co.il>
	<20100512094642.GB31199@pengutronix.de>
Message-ID: <20100704084343.GB19559@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, May 12, 2010 at 11:46:42AM +0200, Sascha Hauer wrote:
> On Wed, May 12, 2010 at 08:06:28AM +0300, Baruch Siach wrote:
> > On Tue, May 11, 2010 at 05:43:49PM +0200, Sascha Hauer wrote:
> > > On Mon, Jan 25, 2010 at 12:58:21PM +0200, Baruch Siach wrote:
> > > > The gpt_clk rate function doesn't consider the PER divider. This causes a
> > > > significant drift in time accounting. Fix this by introducing the correct rate
> > > > calculation function.
> > > 
> > > Should have tested this one. In fact with this patch applied my clock
> > > goes wrong.
> > > 
> > > The i.MX Timer code makes sure the gpt clock is sourced from the ipg
> > > clock (GPTCR[6:8] = 1), so the behaviour should be correct the way it
> > > was before this patch. Any idea why it was wrong on your hardware? Have
> > > you changed the GPTCR bits?
> > 
> > No. My current platform is the i.MX25 PDK. I've added the following to my 
> > mx25pdk_init():
> > 
> > debugfs_create_x32("gptcr", 0444, NULL,
> >     (u32*)MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR));
> > 
> > When the system is running I get:
> > 
> > # cat /debugfs/gptcr 
> > 0x00000249
> > 
> > That is GPTCR[6:8] = 1.
> > 
> > The same clock calculation is being done in the platform code of the Freescale 
> > supplied kernel (now based on 2.6.31).  Can you get this one running on your 
> > platform?
> 
> I just checked the fsl 2.6.31 source. They really pass the per_clk to
> the timer, but they also change the timer source to MX3_TCTL_CLK_PER
> (2<<6).
> Here are the relevant bits from arch/arm/plat-mxc/time.c in the fsl
> 2.6.31 source:
> 
> /* MX31, MX35 */
> #define MX3_TCTL_WAITEN		(1 << 3)
> #define MX3_TCTL_CLK_IPG	(1 << 6)
> #define MX3_TCTL_CLK_PER	(2 << 6)
> #define MX3_TCTL_FRR		(1 << 9)
> #define MX3_IR			0x0c
> #define MX3_TSTAT		0x08
> #define MX3_TSTAT_OF1		(1 << 0)
> #define MX3_TCN			0x24
> #define MX3_TCMP		0x10
> 
> #define timer_is_v2()	(!(cpu_is_mx1() || cpu_is_mx2()) || cpu_is_mx25())
> 
> void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
> {
> 	...
> 
> 	if (timer_is_v2())
> 		tctl_val = MX3_TCTL_CLK_PER | MX3_TCTL_FRR | MX3_TCTL_WAITEN | MXC_TCTL_TEN;
> 	else
> 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> 
> 	...
> }
> 
> I wonder what is going wrong here.

Our target board has finally arrived and I now see the same problem (i.e., the 
clock runs at half rate).  Setting the clock source to PER as is shown in the 
fsl code fixes the problem on this target board.

The strange thing is that the i.MX25 PDK works fine both ways. Maybe the move 
from RedBoot to Barebox has something to do with this ;-). I haven't tried 
Barebox on the PDK while booting from flash.

Anyway, I'm sending a patch in reply to this message.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
