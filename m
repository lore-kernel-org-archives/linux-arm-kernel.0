From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 8 Oct 2014 06:30:14 +0000
Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <20141003075441.GA1349@katana>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
 <20141003075441.GA1349@katana>
Message-ID: <3cd0b028391140b9a75cddf58dbe40b8@DM2PR03MB349.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: Friday, October 03, 2014 3:55 PM
> To: Yuan Yao-B46683
> Cc: marex at denx.de; LW at KARO-electronics.de; mark.rutland at arm.com; Duan
> Fugang-B38611; shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-i2c at vger.kernel.org
> Subject: Re: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> driver
> > -#include <linux/init.h>
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dmapool.h>
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/init.h>
> >  #include <linux/io.h>
> > -#include <linux/sched.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/clk.h>
> > -#include <linux/slab.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> >  #include <linux/platform_data/i2c-imx.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> 
> This is a seperate patch.

[Yuan Yao] 
Here I just adjust the order of the include file as alphabetical order.
If it looks strange I can only add the include files about DMA.

> 
> 
> > +	while (1) {
> > +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +		if (temp & I2SR_ICF)
> > +			break;
> > +		if (time_after(jiffies, orig_jiffies +
> > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> > +			dev_dbg(dev, "<%s> Timeout\n", __func__);
> > +			return -ETIMEDOUT;
> > +		}
> > +		schedule();
> 
> That might have been asked before. Is there no interrupt for this?
> 

[Yuan Yao] No, there is no interrupt.
After DMA callback, I must wait until the last byte transfer completely.
It's a very short time which less than 10us.
By the way, how about use udelay(10) instead of schedule()?
udelay(10) is waiting a appropriate time.
schedule() is waiting too long for i2c but may be good for whole system.
Can you give me some suggestion?

Thanks for your review.

Best Regards,
Yuan Yao
