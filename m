From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 11 May 2011 08:17:54 +0100
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
In-Reply-To: <4DCA0B77.8060700@st.com>
References: <4DCA0B77.8060700@st.com>
Message-ID: <20110511071754.GN26703@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 09:37:19AM +0530, viresh kumar wrote:
> Following is what i understood after reading m25p80 driver and spi 
> master drivers in drivers/spi folder.
> 
> "chip_select signal controls start and end of transfer. For ex: if we have to read
> status reg of spi memory, then we use write_and_then_read() routine. which writes
> 0x9F in one spi transfer and writes dummy bytes and reads rx reg in other transfer.
> And these two transfers are part of single spi_message.
> 
> Now, it is controllable to handle cs, and if we send cs_change == 0, then chip select
> is activated at start of message and deactivated at end of message, instead at end
> of every transfer.
> 
> Which means, even if there is a delay between command and dummy bytes received at
> spi memory, current transfer will not be terminated by memory as cs is low."
> 
> Is this correct??
> 
> Actually i am seeing a different behavior by some of the spi memories, like m25p10.
> If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
> returned in response. If there is no delay then transfer always passes.

What SPI controller are you using?  I've seen a similar issue with the 
Synopsys DesignWare SPI controller where the controller manages the chip 
select itself, and once the FIFO is emptied the CS goes away, but the 
flash chip requires it to stay high for the whole transaction.  In this 
case the workaround is to use a GPIO as a chip select and there are 
other controllers that do the same thing for the same reason (I think 
that pxa2xx_spi is one of them).

Jamie
