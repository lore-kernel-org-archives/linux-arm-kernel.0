From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Nov 2016 17:53:54 -0700
Subject: [PATCH fpga 3/9] fpga zynq: Fix incorrect ISR state on bootup
In-Reply-To: <CAAtXAHeaaxf4L7aQ455Yrpm1fgqr=L-LxMd7yDQOKjLsBvp38w@mail.gmail.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-4-git-send-email-jgunthorpe@obsidianresearch.com>
 <CAAtXAHeaaxf4L7aQ455Yrpm1fgqr=L-LxMd7yDQOKjLsBvp38w@mail.gmail.com>
Message-ID: <20161111005354.GA21685@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:44:39PM -0800, Moritz Fischer wrote:
> > +       zynq_fpga_write(priv, INT_MASK_OFFSET, 0xFFFFFFFF);
> 
> Named constant please.

This line gets fixed in the next patch that, lets just leave it, less
churn..

> > +       zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
> > +       err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
> > +                              priv);
> > +       if (err) {
> > +               dev_err(dev, "unable to request IRQ\n");
> > +               clk_unprepare(priv->clk);
> 
> Your enable count is off in that case. This should be a clk_disable_unprepare()
> call.

Yep.

FWIW, it feels wrong to leave the ISR enabled but the clk
disabled..

Jason
