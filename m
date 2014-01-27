From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 27 Jan 2014 04:18:59 -0300
Subject: [PATCH v3 04/15] watchdog: orion: Handle IRQ
In-Reply-To: <52E5FFCB.5000802@roeck-us.net>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE84A6.6090909@roeck-us.net> <20140127063040.GA17506@localhost>
 <52E5FFCB.5000802@roeck-us.net>
Message-ID: <20140127071858.GB17506@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 10:42:19PM -0800, Guenter Roeck wrote:
> On 01/26/2014 10:30 PM, Ezequiel Garcia wrote:
> > Hi Guenter,
> >
> > On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
> > [..]
> >>> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
> >>>    	if (!wdt_reg)
> >>>    		return -ENOMEM;
> >>>
> >>> +	irq = platform_get_irq(pdev, 0);
> >>> +	if (irq > 0) {
> >>
> >> 0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
> >> Should be >= 0.
> >>
> >
> > I'm revisiting this one. I believe this is not the hardware interrupt
> > number, but the one mapped into virq space. So, 0 is not a valid
> > interrupt number.
> >
> > Right?
> >
> 
> If so, the entire interrupt numbering scheme appears broken. Conceptually it should
> not make a difference where the interrupt is coming from. If the virq system
> returns 0 for invalid (non-configured) interrupts, and non-configured 'real'
> interrupts are reported as -ENXIO, all bets are off. How would a driver know
> what to expect ? And how would one be expected to review such non-deterministic
> code ?
> 

I wouldn't know that much. I'm just pointing out that '0' doesn't seem
to be a valid IRQ number in this context (i.e. virq space).

> FWIW, platform_get_irq() does return -ENXIO for invalid interrupts. If there
> is an independent notion of "0 is an invalid interrupt", it is well hidden.
> 

Yes, AFAICS platform_get_irq() returns a negative error or a positive
irq number. I fail to see how it's able return '0' (of course, I can be
wrong).

> Anyway, if you think the driver should treat 0 as invalid interrupt, go ahead.
> Who am I to know. Just please don't use my Reviewed-by in this case.
> 

Quite frankly not sure how to handle this best. A quick grep through the
code doesn't help either: lots of drivers treat 0 as a valid interrupt
and lots treat it as invalid. So I guess it doesn't really matter...

Can someone shed a light on this?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
