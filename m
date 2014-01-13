From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 22:19:00 +0800
Subject: [PATCH V4 2/6] ARM: imx: add suspend in ocram support on i.mx6q
In-Reply-To: <20140113124445.GV15937@n2100.arm.linux.org.uk>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
 <1389614031-7253-2-git-send-email-b20788@freescale.com>
 <20140113124445.GV15937@n2100.arm.linux.org.uk>
Message-ID: <20140113141858.GV23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 12:44:45PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 13, 2014 at 07:53:47PM +0800, Anson Huang wrote:
> >  #ifdef CONFIG_PM
> > +void imx6_suspend(void);
> 
> So, imx6_suspend() takes no arguments.
> 
> > +static int (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
> 
> Oh, it takes one argument.

Great catch.

Anson,

The return type of imx6_suspend() and imx6_suspend_in_ocram_fn should be
aligned too.

Shawn

> 
> > +		/*
> > +		 * call low level suspend function in ocram,
> > +		 * as we need to float DDR IO.
> > +		 */
> > +		local_flush_tlb_all();
> > +		imx6_suspend_in_ocram_fn(suspend_ocram_base);
> 
> Yes, definitely takes one argument...
> 
> > +	imx6_suspend_in_ocram_fn = (void *)fncpy(
> > +		suspend_ocram_base + sizeof(*pm_info),
> > +		&imx6_suspend,
> > +		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
> 
> This cast here is needed to work around the above confusion.
> 
> > +ENTRY(imx6_suspend)
> > +	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
> > +	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
> > +	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
> > +	ldr	r4, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
> 
> Yes, definitely takes one argument.
> 
> If you fix the prototype for imx6_suspend, you don't need to cast the
> result of fncpy().  Casts should always be avoided where possible.
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
