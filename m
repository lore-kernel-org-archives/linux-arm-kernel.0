From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Oct 2014 08:46:59 +0200
Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <3cd0b028391140b9a75cddf58dbe40b8@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
 <20141003075441.GA1349@katana>
 <3cd0b028391140b9a75cddf58dbe40b8@DM2PR03MB349.namprd03.prod.outlook.com>
Message-ID: <20141008064659.GA1264@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 06:30:14AM +0000, Yao Yuan wrote:
> > -----Original Message-----
> > From: Wolfram Sang [mailto:wsa at the-dreams.de]
> > Sent: Friday, October 03, 2014 3:55 PM
> > To: Yuan Yao-B46683
> > Cc: marex at denx.de; LW at KARO-electronics.de; mark.rutland at arm.com; Duan
> > Fugang-B38611; shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-
> > arm-kernel at lists.infradead.org; linux-i2c at vger.kernel.org
> > Subject: Re: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> > driver
> > > -#include <linux/init.h>
> > > -#include <linux/kernel.h>
> > > -#include <linux/module.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/dmaengine.h>
> > > +#include <linux/dmapool.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/err.h>
> > >  #include <linux/interrupt.h>
> > > -#include <linux/delay.h>
> > >  #include <linux/i2c.h>
> > > +#include <linux/init.h>
> > >  #include <linux/io.h>
> > > -#include <linux/sched.h>
> > > -#include <linux/platform_device.h>
> > > -#include <linux/clk.h>
> > > -#include <linux/slab.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/of_dma.h>
> > >  #include <linux/platform_data/i2c-imx.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/slab.h>
> > 
> > This is a seperate patch.
> 
> [Yuan Yao] 
> Here I just adjust the order of the include file as alphabetical order.
> If it looks strange I can only add the include files about DMA.

It doesn't look strange, it makes sense to do that. However, this should
be a seperate patch.

a) sort includes
b) add the dma includes in the dma patch

> After DMA callback, I must wait until the last byte transfer completely.
> It's a very short time which less than 10us.
> By the way, how about use udelay(10) instead of schedule()?
> udelay(10) is waiting a appropriate time.
> schedule() is waiting too long for i2c but may be good for whole system.
> Can you give me some suggestion?

It doesn't matter much. Leave it as it is. If somebody wants to change
it, it can be patched.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/584dfe2f/attachment.sig>
