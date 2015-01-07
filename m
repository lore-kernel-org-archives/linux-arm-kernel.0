From: dev@lynxeye.de (Lucas Stach)
Date: Wed, 07 Jan 2015 01:17:07 +0100
Subject: [PATCH 1/4] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <fdd128ec089a0669d66149aa4915e45d@agner.ch>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
 <fdd128ec089a0669d66149aa4915e45d@agner.ch>
Message-ID: <1420589827.25483.7.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 06.01.2015, 00:41 +0100 schrieb Stefan Agner:
> Hi Lucas,
> 
> Thanks for picking that up!
> 
> I did some short benchmarks on Colibri T20 V1.2, L4T. Write/read speeds
> I measured on the YAFFS2 based file system:
> 
> # dd if=/dev/zero of=test bs=50M count=1 conv=fdatasync
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB) copied, 9.88293 s, 5.3 MB/s
> 
> echo 3 > /proc/sys/vm/drop_caches
> # dd if=test of=/dev/zero bs=50M count=1
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB) copied, 5.97056 s, 8.8 MB/s
> 
Thanks, this puts things into perspective.

> So your values look quite realistic then!
> 
> Some comments below...
> 
> On 2015-01-04 21:39, Lucas Stach wrote:
> > Add support for the NAND flash controller found on NVIDIA
> > Tegra 2/3 SoCs. This is a largely reworked version of the driver
> > started by Thierry.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> > I've tested this driver with the in-kernel mtd-tests and some
> > realworld workloads on a Colibri T20 module.
> > ---
> >  .../bindings/mtd/nvidia,tegra20-nand.txt           |  30 +
> >  MAINTAINERS                                        |   6 +
> >  drivers/mtd/nand/Kconfig                           |   6 +
> >  drivers/mtd/nand/Makefile                          |   1 +
> >  drivers/mtd/nand/tegra_nand.c                      | 794 +++++++++++++++++++++
> >  5 files changed, 837 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> >  create mode 100644 drivers/mtd/nand/tegra_nand.c
> > 

[...]

> > +static irqreturn_t tegra_nand_irq(int irq, void *data)
> > +{
> > +	struct tegra_nand *nand = data;
> > +	irqreturn_t ret = IRQ_HANDLED;
> > +	u32 isr, dma;
> > +
> > +	isr = readl(nand->regs + ISR);
> > +	dma = readl(nand->regs + DMA_CTRL);
> > +
> > +	if (!isr && !(dma & DMA_CTRL_IS_DONE)) {
> > +		ret = IRQ_NONE;
> > +		goto out;
> 
> The out label doesn't do anything more than just return. Why not just
> return IRQ_NONE here and return IRQ_HANDLED at the end, saves the local
> variable and helps readability...
> 
Yes, this function looked a bit more complicated when I started to clean
this. So not removing the out label was just an oversight.

> Why is this needed anyway, is the IRQ shared with other peripherals?
> 
> In the L4T driver, there is a warning message about spurious interrupts,
> does this works around this interrupts?
> 
I haven't seen any spurious IRQs during my testing. So not doing
anything special should be okay I think.

[...]

> > +}
> > +
> > +static void tegra_nand_setup_timing(struct tegra_nand *nand, int mode)
> > +{
> > +	unsigned long rate = clk_get_rate(nand->clk) / 1000000;
> > +	unsigned long period = 1000000 / rate;
> 
> Hm, period of a clock in ns... Sounds like a common use case. I searched
> for a macro/helper, but did not found anything. Well then.
> 
> > +	const struct nand_sdr_timings *timings;
> > +	u32 val, reg = 0;
> > +
> > +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> > +
> > +	val = max3(timings->tAR_min, timings->tRR_min,
> > +		   timings->tRC_min) / period;
> > +	if (val > 2)
> > +		val -= 2;
> 
> According to my TRM this is:
> Generated timing = (n+3) * NAND_CLK_PERIOD ns.
> 
> Shouldn't this look like
> 	if (val >= 3)
> 		val -= 3;
> then?
> 
> I see that all the calculations of the timings below are different then
> in TRM. I think we need to take the whole offset into account, or do I
> miss something here?
> 
> 
> > +	reg |= TIMING_TCR_TAR_TRR(val);
> > +
> > +	val = max(max(timings->tCS_min, timings->tCH_min),
> > +		  max(timings->tALS_min, timings->tALH_min)) / period;
> > +	if (val > 1)
> > +		val -= 1;
> > +	reg |= TIMING_TCS(val);
> 
> See mask error in macro definition.
> 
> > +
> > +	val = max(timings->tRP_min, timings->tREA_max) + 6000;
> > +	reg |= TIMING_TRP(val / 1000);
> > +	reg |= TIMING_TRP_RESP(val / period);
> > +
> > +	reg |= TIMING_TWB(timings->tWB_max / period);
> > +	reg |= TIMING_TWHR(timings->tWHR_min / period);
> > +	reg |= TIMING_TWH(timings->tWH_min / 1000);
> > +	reg |= TIMING_TWP(timings->tWP_min / 1000);
> > +	reg |= TIMING_TRH(timings->tRHW_min / 1000);
> 
> Why 1000 for those three values? In my TRM, those values are in
> NAND_CLK_PERIOD too.
> 

Thanks for noticing. I wrote that part half a year ago and don't know
the details anymore. I will look this up again (and fix if necessary)
and come back to you.

Regards,
Lucas
