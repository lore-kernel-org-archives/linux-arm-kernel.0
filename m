From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 03 Feb 2012 15:43:43 -0500 (EST)
Subject: [PATCH 00/17] SA11x0 cleanups (mainly assabet/neponset)
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1202031533030.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012, Russell King - ARM Linux wrote:

> This is a series of cleanups and improvements to the SA11x0 code, in
> particular the Assabet, and Assabet with the Neponset daughter board.
> 
> The main SA11x0 change is to switch to using the DEFINE_RES_xxx() for
> resources, which obviously reduces the lines of code quite a bit.
> 
> The Assabet-only changes reduce power consumption of the board, and
> illustrate why pins left as inputs when they're supposed to be outputs
> are bad news - while it's undriven, it floats and increases the power
> consumption by a measurable amount.
> 
> Neponset wise, there's fixes in here to restore it to fully working
> state (rather than just being buildable.)  Unfortunately, genirq had
> seriously broken the Neponset interrupt support code by genirq having
> some 'improved checks' added without auditing the genirq users.
> 
> Neponset also gets ready for sparse IRQ support, meaning that its
> interrupt numbers are no longer statically fixed.  We also move the
> registration of the neponset device to assabet, which helps reduce
> the knowledge spread of whether the board is fitted.
> 
> The random places which the NCR_0 board register is written are turned
> into a function call instead, so that the NCR_0 register access can be
> centralized and properly protected against concurrent access for this
> platform.
> 
> Since neponset becomes mostly self-contained, most of the boards CPLD
> register definitions are moved to the board file rather than exposing
> them in the board header file.  That then paves the way to get rid of
> its static mapping for its own registers, using ioremap() instead.

I've quickly looked through this series and this all looks sensible.

Acked-by: Nicolas Pitre <nico@linaro.org>

My knowledge of the SA1111 chip was never extensive, and the little I 
had did fade away at this point.  So it might not be relevant for me to 
give any comment on the other series.  Except that I thought that DMA 
was terminally broken on that chip, hence I'm surprized to see OHCI 
support for it.


Nicolas
