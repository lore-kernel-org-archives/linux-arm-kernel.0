From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 22:27:23 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953
	and	ENGcm09472
In-Reply-To: <20101005200414.GA11737@pengutronix.de>
References: <20101005094510.GJ28242@pengutronix.de>
	<1286280012-19809-1-git-send-email-eric@eukrea.com>
	<20101005183308.GX11737@pengutronix.de>
	<4CAB7D0F.9020600@eukrea.com>
	<20101005194659.GY11737@pengutronix.de>
	<4CAB83C2.3040301@eukrea.com>
	<20101005200414.GA11737@pengutronix.de>
Message-ID: <4CAB8A2B.7020306@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 05/10/2010 22:04, Uwe Kleine-K?nig a ?crit :
>> That may seems bad, but I find this solution better than having an oops
>> after a few IRQs which makes the CPU unusable for real life applications
>> :-)
> Ack, but it makes me think if the caches should be enabled in the irq
> entry point, too.

If I understand well the following link, you are right.

Adding checks to enable cache at the IRQ entry point will execute 
aditional code at each interrupt which may have more cost than executing 
one ISR after WFI without cache (I may be totally wrong here).

More details here (click c7, Cache Operations Register > The Wait For 
Interrupt operation in the left menu) :
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0211h/I1014942.html

which says :

MCR p15,0,<Rd>,c7,c0,4               ; Wait For Interrupt

This puts the processor into a low-power state and stops it executing 
following instructions until an interrupt, an imprecise external abort, 
or a debug request occurs, regardless of whether the interrupts or 
external imprecise aborts are disabled by the masks in the CPSR. When an 
interrupt does occur, the MCR instruction completes. If interrupts are 
enabled, the IRQ or FIQ handler is entered as normal. The return link in 
r14_irq or r14_fiq contains the address of the MCR instruction plus 8, 
so that the normal instruction used for interrupt return (SUBS 
PC,R14,#4) returns to the instruction following the MCR.

Eric
