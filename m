From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 24 Nov 2015 17:44:24 +0100
Subject: SAMA5D3x: I2C, USART1 and DMA.
In-Reply-To: <56548CD7.4010705@lysator.liu.se>
References: <56548CD7.4010705@lysator.liu.se>
Message-ID: <20151124164424.GA28794@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Nov 24, 2015 at 05:14:15PM +0100, Peter Rosin wrote:
> Hi!
> 
> I have a board similar to the atmel sama5d31ek with some devices
> on the i2c0 bus and an async serial line on usart1 that communicates
> with a baudrate of 125000. The usart is mostly receiving.
> 
> In a divine moment, our designers failed to add handshaking signals
> for the usart, and now we have trouble with the occational lost interrupt
> and hence lost data (at least that is my current understanding of
> what is going on).
> 
> The lost data is clearly tied to i2c traffic, and specifically to i2c writes.
> i2c reads seems to go by unnoticed by usart1. Of course, other stuff
> may also cause trouble, but if I test by temporarily switching off the
> i2c writes a BIG part of the problem is gone. But the i2c writes also
> have a reason to be there of course, so that is not a long term
> solution...
> 
> What immediately springs to mind is to reduce the number of interrupts
> needed on the usart by enabling DMA. DMA is apparently disabled by
> arch/arm/boot/dts/sama5d3xmb.dtsi with this:
> 
>             usart1: serial at f0020000 {
>                 dmas = <0>, <0>;    /*  Do not use DMA for usart1 */
> 
> However, cutting out the "dmas" line does not improve things. So, how
> do I enable DMA on usart1?

You are probably running out of available DMA channels on the DMAC0. 
There is 8 channels available per DMAC and this is quite a scarce 
resource.

See "DMA Channels Definition" tables from the SAMA5D3 datasheet. I hope 
you balanced well the peripherals you are using in your design on the 
two DMAC to prevent running out of DMA channels.


> And why is it not enabled in the first place?
> I mean, who would not want to use DMA for these things?

Because there is unfortunely not enough available DMA channels to meet 
the need of all peripherals used on the -EK boards. A compromise has to 
be made between peripherals that really need DMA and those which can 
cope acceptably using PIO access.


> Any thoughts on why i2c writes stomps usart1 reception interrupts is
> also welcome.

That's expected behavior without DMA, there is unfortunately no FIFO in 
Atmel SoC so any interrupt which isn't handled in time cause data loss.


Sylvain
