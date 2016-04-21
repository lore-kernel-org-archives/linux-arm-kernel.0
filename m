From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 21 Apr 2016 15:58:22 +0100
Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A57989B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-4-git-send-email-peter.griffin@linaro.org>
 <C246CAC1457055469EF09E3A7AC4E11A4A57989B@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160421145822.GA1725@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Appana,

Thanks for the review.

On Thu, 21 Apr 2016, Appana Durga Kedareswara Rao wrote:

> 
> 
> > -----Original Message-----
> > From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> > owner at vger.kernel.org] On Behalf Of Peter Griffin
> > Sent: Thursday, April 21, 2016 4:34 PM
> > To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > srinivas.kandagatla at gmail.com; maxime.coquelin at st.com;
> > patrice.chotard at st.com; vinod.koul at intel.com
> > Cc: peter.griffin at linaro.org; lee.jones at linaro.org;
> > dmaengine at vger.kernel.org; devicetree at vger.kernel.org; arnd at arndb.de;
> > broonie at kernel.org; ludovic.barre at st.com
> > Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
> > engine driver support
> > 
> > This patch adds support for the Flexible Direct Memory Access (FDMA) core
> > driver. The FDMA is a slim core CPU with a dedicated firmware.
> > It is a general purpose DMA controller capable of supporting 16
> > independent DMA channels. Data moves maybe from memory to memory
> > or between memory and paced latency critical real time targets and it
> > is found on al STi based chipsets.
> > 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/dma/Kconfig   |  12 +
> >  drivers/dma/Makefile  |   1 +
> >  drivers/dma/st_fdma.c | 967
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 980 insertions(+)
> >  create mode 100644 drivers/dma/st_fdma.c
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index d96d87c..5910c4f 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -527,6 +527,18 @@ config ZX_DMA
> >  	help
> >  	  Support the DMA engine for ZTE ZX296702 platform devices.
> > 
> > +config ST_FDMA
> > +	tristate "ST FDMA dmaengine support"
> > +	depends on ARCH_STI
> > +	select DMA_ENGINE
> > +	select FW_LOADER
> > +	select DMA_VIRTUAL_CHANNELS
> > +	help
> > +	  Enable support for ST FDMA controller.
> > +	  It supports 16 independent DMA channels, accepts up to 32 DMA
> > requests
> > +
> > +	  Say Y here if you have such a chipset.
> > +	  If unsure, say N.
> > 
> >  # driver files
> >  source "drivers/dma/bestcomm/Kconfig"
> > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> > index 6084127..b81ca99 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -65,6 +65,7 @@ obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
> >  obj-$(CONFIG_TI_EDMA) += edma.o
> >  obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
> >  obj-$(CONFIG_ZX_DMA) += zx296702_dma.o
> > +obj-$(CONFIG_ST_FDMA) += st_fdma.o
> > 
> >  obj-y += qcom/
> >  obj-y += xilinx/
> > diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> > new file mode 100644
> > index 0000000..9bf0100
> > --- /dev/null
> > +++ b/drivers/dma/st_fdma.c
> > @@ -0,0 +1,967 @@
> > +/*
> > + * st_fdma.c
> > + *
> > + * Copyright (C) 2014 STMicroelectronics
> > + * Author: Ludovic Barre <Ludovic.barre@st.com>
> > + * License terms:  GNU General Public License (GPL), version 2
> > + */
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/clk.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/firmware.h>
> > +#include <linux/elf.h>
> > +#include <linux/atomic.h>
> > +
> > +#include "st_fdma.h"
> > +#include "dmaengine.h"
> > +#include "virt-dma.h"
> > +
> > +static char *fdma_clk_name[CLK_MAX_NUM] = {
> > +	[CLK_SLIM]	= "fdma_slim",
> > +	[CLK_HI]	= "fdma_hi",
> > +	[CLK_LOW]	= "fdma_low",
> > +	[CLK_IC]	= "fdma_ic",
> > +};
> > +
> > +static int st_fdma_clk_get(struct st_fdma_dev *fdev)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < CLK_MAX_NUM; i++) {
> > +		fdev->clks[i] = devm_clk_get(fdev->dev, fdma_clk_name[i]);
> > +		if (IS_ERR(fdev->clks[i])) {
> > +			dev_err(fdev->dev,
> > +				"failed to get clock: %s\n", fdma_clk_name[i]);
> > +			return PTR_ERR(fdev->clks[i]);
> > +		}
> > +	}
> > +
> > +	if (i != CLK_MAX_NUM) {
> > +		dev_err(fdev->dev, "all clocks are not defined\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int st_fdma_clk_enable(struct st_fdma_dev *fdev)
> > +{
> > +	int i, ret;
> > +
> > +	for (i = 0; i < CLK_MAX_NUM; i++) {
> > +		ret = clk_prepare_enable(fdev->clks[i]);
> > +		if (ret < 0)
> 
> You should disable and unprepared the other clocks...

Good point, will fix in v4.

regards,

Perer
