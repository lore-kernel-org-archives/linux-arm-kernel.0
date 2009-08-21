From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 21 Aug 2009 18:23:30 +0200
Subject: [PATCH 32/47] mmc: atmel-mci: New MCI2 module support in atmel-mci driver
Message-ID: <mailman.42.1254134102.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new revision of the IP adds some improvements to the MCI already present
in several Atmel SOC.
Some new registers are added and a particular way of handling DMA interaction
lead to a new sequence in function call which is backward compatible: On MCI2,
we must set the DMAEN bit to enable the DMA handshaking interface. This must
happen before the data transfer command is sent.

A new function is able to differentiate MCI2 code and is based on knowledge of
processor id (cpu_is_xxx()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   85 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 75 insertions(+), 10 deletions(-)

Index: linus2/drivers/mmc/host/atmel-mci.c
===================================================================
--- linus2.orig/drivers/mmc/host/atmel-mci.c
+++ linus2/drivers/mmc/host/atmel-mci.c
@@ -92,6 +92,7 @@ struct atmel_mci_dma {
  * @need_clock_update: Update the clock rate before the next request.
  * @need_reset: Reset controller before next request.
  * @mode_reg: Value of the MR register.
+ * @cfg_reg: Value of the CFG register.
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @mapbase: Physical address of the MMIO registers.
@@ -155,6 +156,7 @@ struct atmel_mci {
 	bool			need_clock_update;
 	bool			need_reset;
 	u32			mode_reg;
+	u32			cfg_reg;
 	unsigned long		bus_hz;
 	unsigned long		mapbase;
 	struct clk		*mck;
@@ -223,6 +225,19 @@ static bool mci_has_rwproof(void)
 }
 
 /*
+ * The new MCI2 module isn't 100% compatible with the old MCI module,
+ * and it has a few nice features which we want to use...
+ */
+static inline bool atmci_is_mci2(void)
+{
+	if (cpu_is_at91sam9g45())
+		return true;
+
+	return false;
+}
+
+
+/*
  * The debugfs stuff below is mostly optimized away when
  * CONFIG_DEBUG_FS is not set.
  */
@@ -357,12 +372,33 @@ static int atmci_regs_show(struct seq_fi
 			buf[MCI_BLKR / 4],
 			buf[MCI_BLKR / 4] & 0xffff,
 			(buf[MCI_BLKR / 4] >> 16) & 0xffff);
+	if (atmci_is_mci2())
+		seq_printf(s, "CSTOR:\t0x%08x\n", buf[MCI_CSTOR / 4]);
 
 	/* Don't read RSPR and RDR; it will consume the data there */
 
 	atmci_show_status_reg(s, "SR", buf[MCI_SR / 4]);
 	atmci_show_status_reg(s, "IMR", buf[MCI_IMR / 4]);
 
+	if (atmci_is_mci2()) {
+		u32 val;
+
+		val = buf[MCI_DMA / 4];
+		seq_printf(s, "DMA:\t0x%08x OFFSET=%u CHKSIZE=%u%s\n",
+				val, val & 3,
+				((val >> 4) & 3) ?
+					1 << (((val >> 4) & 3) + 1) : 1,
+				val & MCI_DMAEN ? " DMAEN" : "");
+
+		val = buf[MCI_CFG / 4];
+		seq_printf(s, "CFG:\t0x%08x%s%s%s%s\n",
+				val,
+				val & MCI_CFG_FIFOMODE_1DATA ? " FIFOMODE_ONE_DATA" : "",
+				val & MCI_CFG_FERRCTRL_COR ? " FERRCTRL_CLEAR_ON_READ" : "",
+				val & MCI_CFG_HSMODE ? " HSMODE" : "",
+				val & MCI_CFG_LSYNC ? " LSYNC" : "");
+	}
+
 	kfree(buf);
 
 	return 0;
@@ -557,6 +593,10 @@ static void atmci_dma_complete(void *arg
 
 	dev_vdbg(&host->pdev->dev, "DMA complete\n");
 
+	if (atmci_is_mci2())
+		/* Disable DMA hardware handshaking on MCI */
+		mci_writel(host, DMA, mci_readl(host, DMA) & ~MCI_DMAEN);
+
 	atmci_dma_cleanup(host);
 
 	/*
@@ -592,7 +632,7 @@ static void atmci_dma_complete(void *arg
 }
 
 static int
-atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
+atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	struct dma_chan			*chan;
 	struct dma_async_tx_descriptor	*desc;
@@ -624,6 +664,9 @@ atmci_submit_data_dma(struct atmel_mci *
 	if (!chan)
 		return -ENODEV;
 
+	if (atmci_is_mci2())
+		mci_writel(host, DMA, MCI_DMA_CHKSIZE(3) | MCI_DMAEN);
+
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
 	else
@@ -641,10 +684,6 @@ atmci_submit_data_dma(struct atmel_mci *
 	host->dma.data_desc = desc;
 	desc->callback = atmci_dma_complete;
 	desc->callback_param = host;
-	desc->tx_submit(desc);
-
-	/* Go! */
-	chan->device->device_issue_pending(chan);
 
 	return 0;
 unmap_exit:
@@ -652,13 +691,27 @@ unmap_exit:
 	return -ENOMEM;
 }
 
+static void atmci_submit_data(struct atmel_mci *host)
+{
+	struct dma_chan			*chan = host->data_chan;
+	struct dma_async_tx_descriptor	*desc = host->dma.data_desc;
+
+	if (chan) {
+		desc->tx_submit(desc);
+		chan->device->device_issue_pending(chan);
+	}
+}
+
 #else /* CONFIG_MMC_ATMELMCI_DMA */
 
-static int atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
+static int atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	return -ENOSYS;
 }
 
+static void atmci_submit_data(struct atmel_mci *host) {}
+
+
 static void atmci_stop_dma(struct atmel_mci *host)
 {
 	/* Data transfer was stopped by the interrupt handler */
@@ -672,7 +725,7 @@ static void atmci_stop_dma(struct atmel_
  * Returns a mask of interrupt flags to be enabled after the whole
  * request has been prepared.
  */
-static u32 atmci_submit_data(struct atmel_mci *host, struct mmc_data *data)
+static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 {
 	u32 iflags;
 
@@ -683,7 +736,7 @@ static u32 atmci_submit_data(struct atme
 	host->data = data;
 
 	iflags = ATMCI_DATA_ERROR_FLAGS;
-	if (atmci_submit_data_dma(host, data)) {
+	if (atmci_prepare_data_dma(host, data)) {
 		host->data_chan = NULL;
 
 		/*
@@ -729,6 +782,8 @@ static void atmci_start_request(struct a
 		mci_writel(host, CR, MCI_CR_SWRST);
 		mci_writel(host, CR, MCI_CR_MCIEN);
 		mci_writel(host, MR, host->mode_reg);
+		if (atmci_is_mci2())
+			mci_writel(host, CFG, host->cfg_reg);
 		host->need_reset = false;
 	}
 	mci_writel(host, SDCR, slot->sdc_reg);
@@ -744,6 +799,7 @@ static void atmci_start_request(struct a
 		while (!(mci_readl(host, SR) & MCI_CMDRDY))
 			cpu_relax();
 	}
+	iflags = 0;
 	data = mrq->data;
 	if (data) {
 		atmci_set_timeout(host, slot, data);
@@ -753,15 +809,17 @@ static void atmci_start_request(struct a
 				| MCI_BLKLEN(data->blksz));
 		dev_vdbg(&slot->mmc->class_dev, "BLKR=0x%08x\n",
 			MCI_BCNT(data->blocks) | MCI_BLKLEN(data->blksz));
+
+		iflags |= atmci_prepare_data(host, data);
 	}
 
-	iflags = MCI_CMDRDY;
+	iflags |= MCI_CMDRDY;
 	cmd = mrq->cmd;
 	cmdflags = atmci_prepare_command(slot->mmc, cmd);
 	atmci_start_command(host, cmd, cmdflags);
 
 	if (data)
-		iflags |= atmci_submit_data(host, data);
+		atmci_submit_data(host);
 
 	if (mrq->stop) {
 		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
@@ -857,6 +915,8 @@ static void atmci_set_ios(struct mmc_hos
 			clk_enable(host->mck);
 			mci_writel(host, CR, MCI_CR_SWRST);
 			mci_writel(host, CR, MCI_CR_MCIEN);
+			if (atmci_is_mci2())
+				mci_writel(host, CFG, host->cfg_reg);
 		}
 
 		/*
@@ -1095,6 +1155,8 @@ static void atmci_detect_change(unsigned
 				mci_writel(host, CR, MCI_CR_SWRST);
 				mci_writel(host, CR, MCI_CR_MCIEN);
 				mci_writel(host, MR, host->mode_reg);
+				if (atmci_is_mci2())
+					mci_writel(host, CFG, host->cfg_reg);
 
 				host->data = NULL;
 				host->cmd = NULL;
@@ -1644,6 +1706,10 @@ static void atmci_configure_dma(struct a
 	}
 	if (!host->dma.chan)
 		dev_notice(&host->pdev->dev, "DMA not available, using PIO\n");
+	else
+		dev_info(&host->pdev->dev,
+					"Using %s for DMA transfers\n",
+					dma_chan_name(host->dma.chan));
 }
 #else
 static void atmci_configure_dma(struct atmel_mci *host) {}


Best regards,
Yegor Yefremov


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.47.1254251488.2253.linux-arm-kernel@lists.infradead.org>

(and no testing of the actual patch), so it doesn't get merged.

Changes don't get merged until they themselves have been tested.


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.58.1254925451.2253.linux-arm-kernel@lists.infradead.org>

which sysfs node it is when dev_attr_store() is invoked? Which
may give some hint to where is wrong.


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.71.1255316041.2253.linux-arm-kernel@lists.infradead.org>

rc' is a virtual clock which can be set to be feed from the above (or an al=
ways on sys_clk not listed). The emu_src_clk is close to what you were comm=
enting on for etbclock.

> ATCLK - ATB interface clock
> CLK - main clock
> PCLKDBG - Debug APB clock or PCLK - APB clock
>
> I'm not sure why OMAP seems to have four clocks when the ETM has only
> three clocks itself.

The ALTCLK & PCLKDBG will be derived from one of the above clocks (emu_per,=
 emu_mpu, emu_core, emu_sys) based on routing.  Which one is used is select=
ed by CM_CLKSEL1_EMU.CLKSEL_ATCLK.  The main CLK comes from MPU DPLL tree.

A big chuck of ETM/ETB is generic coresight.  There is SOC specific emulati=
on logic which surrounds it.

Regards,
Richard W.



>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.73.1255453939.2253.linux-arm-kernel@lists.infradead.org>

screen
controller mode or in a direct operation mode (ADC mode).  The mode is
selected with the TS_SETUP_ENABLE bit.  Both modes are not able to =
operate
at the same time.  Plus, it really doesn't make any sense for them to =
work
together.  Either a touch screen will be connected or the signals will =
be
used to measure analog voltages.

The way you have partitioned this code it appears that the low-level i/o
is all handled in arch/arm/mach-ep93xx/adc.c.  The high-level stuff for
ADC mode is then handled by drivers/hwmon/ep93xx-hwmon.c.

This approach looks good to me.  When a touch screen driver is finally
created it should be able to reuse the functionality in adc.c in the =
same
way (hopefully).

Following are replies to your questions:

[snip]

>>> +	adc->clk =3D clk_get(dev, "ep93xx-analog");
>>=20
>> Did you try:
>> 	adc->clk =3D clk_get(dev, NULL);
>
> No I didn't, I guess that it will work if the names match. The goal=20
> was to define the clock "analog", and the two devices "adc" and=20
> "touchscreen", I don't know what's the best strategy to adopt here. I=20
> know that ADC and TS share the same ressources (regs, clock, irq, ...) =

> but as I said above I don't have the proper hardware to make any =
tests.
>
> So perhaps in the mean time, I should define everything as ADC centric =

> and forget completely the touchscreen controller.

I did some thinking on this.

The adc.c module is the only place that actually "gets" the clock.  The
upper-level hwmon, and eventually touchscreen, module don't even know
that the clock exists.  Based on that, the adc.c driver should be =
getting
the clock based on the dev_id since it is the only user.

>>=20
>>> +	if (IS_ERR(adc->clk)) {
>>> +		dev_err(dev, "failed to get ADC clock\n");
>>> +		ret =3D PTR_ERR(adc->clk);
>>> +		goto err_irq;
>>> +	}
>>> +
>>> +	regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!regs) {
>>> +		dev_err(dev, "failed to find registers\n");
>>> +		ret =3D -ENXIO;
>>> +		goto err_clk;
>>> +	}
>>=20
>> request_mem_region() before ioremap().
>
> Oops, didn't spot that one, thanks.
> BTW, doesn't platform_get_resource() do it automatically?

No.  From drivers/base/platform.c

/**
 * platform_get_resource - get a resource for a device
 * @dev: platform device
 * @type: resource type
 * @num: resource index
 */
struct resource *platform_get_resource(struct platform_device *dev,
				       unsigned int type, unsigned int num)

The function just walks thru the passed platform_device->resource[]
looking for the 'num' resource of 'type'.  Then the resource is
returned unmodified.

[snip]

>>> +static struct clk clk_analog =3D {
>>=20
>> 	.parent	=3D &clk_xtali,
>
> The parent clock patch is still not in Linus tree.

It just went it.

commit ebd00c08e28a0ab4dcb715d222214625fff6d62a
Author: Hartley Sweeten <hartleys@visionengravers.com>
Date:   Thu Oct 8 23:44:41 2009 +0100

    ARM: 5756/1: ep93xx: introduce clk parent

[snip]

>>> +#define EP93XX_TS_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x00100000)
>>=20
>> Should be:
>>=20
>> #define EP93XX_TS_PHYS_BASE			EP93XX_APB_PHYS(0x00100000)
>
> My current version (linus rc4) doesn't have EP93XX_APB_PHYS().

This also just went in:

commit 591006f830bcc8edf2841750d7543c5c5a672f89
Author: Hartley Sweeten <hartleys@visionengravers.com>
Date:   Fri Sep 25 17:54:31 2009 +0100

    ARM: 5729/1: ep93xx: define EP93XX_*_PHYS_BASE with macros

[snip]

>>> +	ep93xx_hwmon_device.dev.platform_data =3D &ts72xx_hwmon_info;
>>>  }
>>=20
>> Ugly... You shouldn't be setting up any type of device data in =
(*map_io).
>
> Yes, I don't remember the details but I think I ran into a problem of=20
> runtime order dependency, and doing this here have solved it. I will=20
> try to fix it.
> Well, the whole story is that it's what the S3c code is doing, I tried =

> to move it somewhere else for the same reason (it's ugly) and it=20
> didn't work so ...

Hmmm... This should not cause any problems as long as it is set before =
the:

	platform_device_register(&ep93xx_hwmon_device);

I'll take another look at it when you repost the updated patch.

[snip]

>> Can you just use struct ep93xx_hwmon_chcfg directly without using the
>> struct ep93xx_hwmon_data as a container?  Something like:
>
> Yes, actually i copied the S3c code and try to avoid to make any=20
> cosmetic change to keep both similar so that it will help if someday=20
> someone want to make the adc code ARM generic.

I'm not sure if that's possible but you never know...

I look forward to seeing the update patch.

Regards,
Hartley


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.75.1255710673.2253.linux-arm-kernel@lists.infradead.org>

default address (arch/arm/mach-kirkwood/pcie.c:kirkwood_pcie_setup) and
when initilizing the memory windows, it's remapping the i/o port address
to 0 (arch/arm/mach-kirkwood/addr-map.c:kirkwood_setup_cpu_mbus). If I
remove the mapping, the framebuffer driver is sort-of working. I've
something on the screen but it's garbled.
As I don't have a lot of confidence in the framebuffer driver, I don't
know if the problem comes from the driver or from an other bug in the
pci support for the kirkwood :(

Can someone test this patch (obviously, need a pci card using I/O port)
and report ? If it's successfull, I'll submit it again with proper
s-o-b.

Also, I'm surprised to see that the pci express bus is used like a
normal pci bus, which means no MSI/ASPM/AER. Does someone know if it's
in the work ? [ this is an open question, I'm not sure I'll be able to
use and test them on the OpenRD-client board ].


Thanks,
Arnaud


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=kirkwood_pcie_fix.patch

Index: linux-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h
===================================================================
--- linux-2.6.orig/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ linux-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -35,7 +35,7 @@
 
 #define KIRKWOOD_PCIE_IO_PHYS_BASE	0xf2000000
 #define KIRKWOOD_PCIE_IO_VIRT_BASE	0xfef00000
-#define KIRKWOOD_PCIE_IO_BUS_BASE	0x00000000
+#define KIRKWOOD_PCIE_IO_BUS_BASE	-1
 #define KIRKWOOD_PCIE_IO_SIZE		SZ_1M
 
 #define KIRKWOOD_REGS_PHYS_BASE		0xf1000000

--=-=-=--


>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.76.1255720404.2253.linux-arm-kernel@lists.infradead.org>

"There are currently three silicon revisions for OMAPL137. The JTAG IDs
 (DEVIDR register contents) for each silicon revision are shown below:

 0x0B7D F02F for silicon revision 1.0
 0x8B7D F02F for silicon revision 1.1
 0x9B7D F02F for silicon revision 2.0

 Corresponding errata documentation will be available in the next few
 weeks on the ti.com website."

Reported-by: Nick Thompson <Nick.Thompson@gefanuc.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da830.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index f0b2f96..a2f2bdc 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1143,7 +1143,21 @@ static struct davinci_id da830_ids[] = {
 		.part_no	= 0xb7df,
 		.manufacturer	= 0x017,	/* 0x02f >> 1 */
 		.cpu_id		= DAVINCI_CPU_ID_DA830,
-		.name		= "da830/omap l137",
+		.name		= "da830/omap-l137 rev1.0",
+	},
+	{
+		.variant	= 0x8,
+		.part_no	= 0xb7df,
+		.manufacturer	= 0x017,
+		.cpu_id		= DAVINCI_CPU_ID_DA830,
+		.name		= "da830/omap-l137 rev1.1",
+	},
+	{
+		.variant	= 0x9,
+		.part_no	= 0xb7df,
+		.manufacturer	= 0x017,
+		.cpu_id		= DAVINCI_CPU_ID_DA830,
+		.name		= "da830/omap-l137 rev2.0",
 	},
 };
 
-- 
1.6.4.3
