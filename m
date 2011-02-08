From: John.Linn@xilinx.com (John Linn)
Date: Tue, 8 Feb 2011 08:06:54 -0700
Subject: [PATCH 3/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <20110208143514.GB27521@n2100.arm.linux.org.uk>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<7803ac06-421f-455a-86af-ea9d480be64d@VA3EHSMHS012.ehs.local>
	<20110208143514.GB27521@n2100.arm.linux.org.uk>
Message-ID: <f3101c62-0bd1-4ad5-8ace-d81a1fd58890@VA3EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, February 08, 2011 7:35 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
glikely at secretlab.ca; Kiran
> Sutariya
> Subject: Re: [PATCH 3/4] ARM: Xilinx: Adding timer support to the
platform
> 
> On Sat, Feb 05, 2011 at 09:08:43AM -0700, John Linn wrote:
> > +/*
> > + * Definitions of the timer read/write macro
> > + */
> > +#define xttcpss_read(addr)	__raw_readl((void __iomem *)addr)
> > +#define xttcpss_write(addr, val) __raw_writel(val, (void __iomem
*)(addr))
> 
> Get rid of these casts.  You should never need to cast to void __iomem
*.

Thanks for continuing, I appreciate your time and will try not to waste
it.

Agreed, that's done and makes sense.

> 
> > +
> > +
> > +/**
> > + * struct xttcpss_timer - This definition defines local timer
structure
> > + *
> > + * @name:	Name of Timer
> > + * @base_addr:	Base address of timer
> > + * @timer_irq:	irqaction structure for the timer device
> > + * @mode:       only valid for an clock event, periodic or one-shot
> > + **/
> > +struct xttcpss_timer {
> > +	char *name;
> > +	unsigned long base_addr;
> 
> Replace this with void __iomem *base_addr.
> 

Agreed, that's done and makes sense.

> > +		timer->base_addr = XTTCPSS_TIMER_BASE + (4*timer_id);
> 
> Right, so XTTCPSS_TIMER_BASE should be typed as void __iomem *.
> 
> > +#define XTTCPSS_TIMER_BASE	TTC0_BASE
> 
> which means TTC0_BASE should be void __iomem * as well as this is an
> iomem cookie, not a physical address.

In my latest revision of the patches I'm working on, here's what I did.

void __iomem *base_addr;

base_addr = IOMEM(XTTCPSS_TIMER_BASE)

This seems equivalent to what you're saying, but maybe I'm missing
something.

> 
> From your other patch:
> 
> > +#define TTC0_BASE              (PERIPH_BASE + 0x1000)
> 
> So, PERIPH_BASE is also an iomem cookie, not a physical address, so it
> too should be void __iomem *.
> 
> Hence:
> 
> > +#define PERIPH_BASE            0xF8000000
> 
> should be:
> 
> #define PERIPH_BASE            IOMEM(0xF8000000)
> 
> But then in a different patch you do:
> +               .virtual        = TTC0_BASE,
> +               .pfn            = __phys_to_pfn(TTC0_BASE),
> 
> So it's also used as a physical address.  Yuck.

I have been mapping everything flat (virt = phys) and I should have been
clearer on that.

It seems like there are two sets of #defines expected, virtual and
physical, even if they
are the same.

Thanks,
John



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
