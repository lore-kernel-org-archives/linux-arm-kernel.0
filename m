From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 22 Apr 2016 08:28:57 +1000
Subject: [PATCH v2 10/11] arm: Add Aspeed machine
In-Reply-To: <6245614.OXDTEyrM2z@wuerfel>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-11-git-send-email-joel@jms.id.au>
 <6245614.OXDTEyrM2z@wuerfel>
Message-ID: <1461277737.3135.14.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-21 at 10:35 +0200, Arnd Bergmann wrote:
> 
> > +#define SCU_PASSWORD	0x1688A8A8
> > +
> > +static void __init aspeed_init_early(void)
> > +{
> > +	u32 reg;
> > +
> > +	/*
> > +	?* Unlock SCU
> > +	?*/
> > +	writel(SCU_PASSWORD, AST_IO(AST_BASE_SCU));
> > +
> > +	/* We enable the UART clock divisor in the SCU's misc control
> > +	?* register, as the baud rates in aspeed.dtb all assume that the
> > +	?* divisor is active
> > +	?*/
> > +	reg = readl(AST_IO(AST_BASE_SCU | 0x2c));
> > +	writel(reg | 0x00001000, AST_IO(AST_BASE_SCU | 0x2c));

> Can you explain a bit more about this? I would assume that the UART
> that is used for the console is working at the point that the bootloader
> hands over to the kernel, while the other uarts don't need to be
> active this early. Why do you need to do this at such an early stage

It may or may not be already correct, you don't necessarily have a
serial enabled bootloader or it might be using a UART driver that
doesn't use the 'standard' divisors etc... This just sanitizes it.

This register contains misc controls. That specific bit controls a
clock divisor by 13 from the main 24Mhz source, which provides a
reasonably "standard" 1.84 Mhz input to the UARTs.

> > 
> > +	/*
> > +	?* Disable the watchdogs
> > +	?*/
> > +	writel(0, AST_IO(AST_BASE_WDT | 0x0c));
> > +	writel(0, AST_IO(AST_BASE_WDT | 0x2c));
> > +}
> Similarly here: why so early? Is the initial timeout too short to wait
> for the watchdog driver to come up? I think it makes sense to require
> the watchdog driver to be loaded if a watchdog is enabled during boot,
> and that keeps the register access in one place.

Cheers
Ben.
