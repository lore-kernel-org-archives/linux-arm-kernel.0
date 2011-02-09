From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 9 Feb 2011 09:06:16 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110209001710.GF6963@S2100-06.ap.freescale.net>
References: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<19793.22067.960689.669543@ipc1.ka-ro>
	<20110209001710.GF6963@S2100-06.ap.freescale.net>
Message-ID: <19794.19192.351501.395360@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Shawn Guo writes:
> On Tue, Feb 08, 2011 at 03:41:55PM +0100, Lothar Wa?mann wrote:
[...]
> > What's behinde the 'PIO' transfers is programming controller registers
> > via DMA along with the actual DMA data transfer. DMA_NONE simply
> > means, that the DMA transfer does only the register programming but
> > does not transfer any payload. The 'pio_words' are the values that are
> > being written to consecutive locations of e.g. the SPI controller
> > register address space.
> > The programming is actually done by DMA, in any case.
> > 
> I'm waiting for this reply ;)
> 
> i.MX23/28 Reference Manual uses word "PIO" for the working mode that
> Lothar has explained.  It seems that "PIO" in mxs-dma needs some more
> documents.
> 
> It's true that mxs dma hardware is designed to program peripheral
> registers along with data transfer with ccw chain.  But it's hard
> for generic dmaengine model to implement that.  The client device
> driver gets the data in scatter-gather list to transfer.  It requires
> client driver to manipulate the sgl to get pio ccw inserted properly
> to get the "along with" implemented.  This is not a reasonable
> implementation to me.
> 
> I still chose to keep the pio mode in the implementation in "single
> step" rather than "along with" way.  That means client driver has to
> issue one dma request to program client device registers, and issue
> another one to transfer data.  The natural thought is that the pio
>
which defeats the purpose of the whole thing. If the software has to
issue a single request for DMA to program the registers it could as
well directly write the registers without any DMA. The purpose of the
embedded 'PIO' transfers is, that you can set up a whole chain of
commands and associated data transfers and have that executed
without any further software intervention.

> support can totally be saved with cpu programming.  But looking at
> any mxs dma client device in reference manual, you will find it gets
> two irq lines, irq_dma and irq_error.  For ssp (mmc) example, when
> one mmc command is issued and completed without error, you have to
> either polling ssp status register or use pio dma and irq_dma
> interrupt to know the completion.  That's to say I keep the pio
>
You could use the SSP IRQ as well.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
