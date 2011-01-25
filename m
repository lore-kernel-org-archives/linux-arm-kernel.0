From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 25 Jan 2011 02:44:28 +0100
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <20110124232302.GQ24104@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
	<4D3DDD07.1030809@bluewatersys.com>
	<Pine.LNX.4.64.1101242126570.3167@ask.diku.dk>
	<4D3DE35B.1030102@bluewatersys.com>
	<Pine.LNX.4.64.1101242200500.3167@ask.diku.dk>
	<4D3DE9CD.2040800@bluewatersys.com>
	<Pine.LNX.4.64.1101242231240.3167@ask.diku.dk>
	<4D3DF46A.1030009@bluewatersys.com>
	<20110124232302.GQ24104@n2100.arm.linux.org.uk>
Message-ID: <20110125014428.GO24284@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:23 Mon 24 Jan     , Russell King - ARM Linux wrote:
> On Tue, Jan 25, 2011 at 10:51:38AM +1300, Ryan Mallon wrote:
> > You could, but it would not be helpful. Clock associations are used so
> > that _different_ devices can have the same function and map to the
> > correct clock. This is used when there are multiple instances of a
> > single peripheral. For example, the uart clocks work like this:
> > 
> > 	at91_clock_associate("usart1_clk", &pdev->dev, "usart");
> > 
> > so then you can do this in a driver:
> > 	
> > 	uart_clk = clk_get(&pdev->dev, "usart");
> > 
> > Rather than:
> > 
> > 	uart_clk = clk_get(NULL, "usart1_clk");
> > 
> > The former will find the correct uart clock for the device. Because each
> > uart is a separate device the correct clock will be selected for each uart.
> > 	
> > My point was that there should be no overlap between clk->name and
> > clk->function otherwise clk_get will not be able to return the correct
> > clock.
> 
> It would be nice if AT91 could switch over to using clkdev at some
> point, which greatly helps with associating struct clk's with their
> device/function names - and reduces the amount of "different" code.
I working on it that's was one of the reason I move clkdev to drivers
as AT91 and AVR32 need to switch

Best Regards,
J.
