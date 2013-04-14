From: marex@denx.de (Marek Vasut)
Date: Sun, 14 Apr 2013 20:09:01 +0200
Subject: [PATCH] mxs/spi: Add SPI slave mode operation DT prop
In-Reply-To: <CA+7tXiheWUsKstWRYOR-kQoTrkDSivnYrxVuxNSNYE+rk6u79w@mail.gmail.com>
References: <1345776161-9778-1-git-send-email-marex@denx.de>
 <201303210035.52984.marex@denx.de>
 <CA+7tXiheWUsKstWRYOR-kQoTrkDSivnYrxVuxNSNYE+rk6u79w@mail.gmail.com>
Message-ID: <201304142009.01829.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Wed, Mar 20, 2013 at 4:35 PM, Marek Vasut <marex@denx.de> wrote:
> >> On Thu, Aug 23, 2012 at 7:42 PM, Marek Vasut
> >> 
> >> > +              - The DMA has to wait indefinitelly for the arriving
> >> > data.
> >> 
> >> Is there a reason that this must be done?  I'd guess that after the
> >> SSP is told to start a transfer in slave mode it waits for the master
> >> to assert the SSn line and begin the transfer.  If the completion
> >> times out before this happens then it makes sense it wouldn't work.
> >> But does it still not work if the SPI transfer completes before the
> >> completion timeout?  Or is this necessary because in your application
> >> there might be a long wait before the master chooses to initiate a
> >> transfer after you program it on the Linux side?
> > 
> > The problem is the SPI block in slave mode ignores SS being pulled back
> > up.
> 
> I've setup a board with a spi-gpio port looped to a spi-mxs port in
> slave mode so I can test this.  I did not need to change the DMA
> timeout to get it to work.  If the master does not send enough within
> the SSP timeout the slave transaction will timeout.  It does not seem
> to ignore SS, but rather the DMA will not finish until all the
> requested words are received, no matter how many SS pulses that
> happens to take.  For general purpose slave support it would of course
> be nice to be able to end the message when the master drops SS, but
> the SSP either doesn't support this or a different technique is
> needed.

It ignores the SS getting back up, confirmed by FSL. Sad :-(

> I've found that if PHASE = 0, the SSP expects the SS to be pulsed high
> between each word (w/ current driver, word == 8 bits).  This is
> slightly alluded to in the imx28 manual, where the PHASE = 0
> descriptions in sections 17.5.3 and 17.5.5 contain, "... in the case
> of continuous back-to-back transmissions, the SSn signal must be
> pulsed high between each data word[.]"  While for the PHASE = 1
> descriptions in sections 17.5.4 and 17.5.6 it says, "For continuous
> back-to-back transfers, the SSn pin is held low between successive
> data words[.]"

When it comes to slave mode, you can not trust anything you don't research 
yourself, sorry :-(

> One would think this is talking about master mode like the rest of the
> section, but it seems to only apply to slave mode.  In master mode one
> can easily produce a SPI signal without SS pulsed between each word
> with either phase setting.
> 
> Testing with the master TX sending 1 byte per SS asserted period:
> $ echo abcd1234ABCDwxyz | dd of=/dev/spidev4.0 bs=1
> 
> Slave RX receives the first four bytes:
> $ dd if=/dev/spidev2.0 count=1 bs=4 | hd
> [  638.673625] spidev spi2.0: Start POL 0 PHA 0
> 00000000  61 62 63 64                                       |abcd|
> 
> Trying with 4 bytes per SS assertion:
> $ echo abcd1234ABCDwxyz | dd of=/dev/spidev4.0 bs=4
> $ dd if=/dev/spidev2.0 count=1 bs=4 | hd
> 00000000  61 31 41 77                                       |a1Aw|
> 
> The slave receives the first byte of each SS assertion pulse.  If I
> change the protocol to PHASE=1, then this case works as well and I
> receive the first four bytes.  I didn't need to set POLARITY to 1,
> just phase.
> 
> $ dd if=/dev/spidev2.0 count=1 bs=16 | hd
> [  261.277000] spidev spi2.0: Start POL 0 PHA 1
> $ echo abcd1234ABCDwxyz | dd of=/dev/spidev4.0 bs=4
> 00000000  61 62 63 64 31 32 33 34  41 42 43 44 77 78 79 7a 
> |abcd1234ABCDwxyz|
> 
> The same thing happens if the bs for the master size is to 1, 2, 8, or
> 16.  Setting it to another values like 3, 5, 32 doesn't work.  Maybe
> the slave ignores extra SS pulses in the middle of a transfer, but
> will fail to complete the transfer if it doesn't get SS de-asserted at
> the end as expected?

Fabio , can you tell?

> >> another application but was never happy with it.  I imagine this is
> >> why no one has ever created a general spi slave framework for Linux.
> > 
> > SPI slave is hard because you can not anticipate the amount of data you
> > will receive. You can not anticipate when you will receive those either.
> 
> The same can be said for a serial UART or an ethernet MAC, yet those
> don't seem to be too hard.

You have a fixed-size MTU for those. But you can do gigabytes-long continuous 
transfer on generic SPI slave.

> I think the problem is that these devices
> usually have things like FIFOs, IRQ trigger levels, pools of buffer
> descriptors, etc. that are designed to handle this.  The design of
> slave mode in SPI and I2C controllers seems to be more of an
> afterthought, with none of the features one would except to deal with
> it.  Also, the slave protocol design for things like EEPROMs often
> have nanosecond scale latencies that are nearly impossible to achieve
> in a general purpose CPU running a multitasking OS.  No one would
> design a network protocol that requires an ACK packet within 10 ns of
> receiving a REQ, and expect the CPU to handle that.  Yet that can be
> expected of a SPI EEPROM.

That can be handled with the DMA ... more or less. The problem really is that 
you generally can't anticipate the length of transfer.

Note that UART will either start dropping characters if it's buffers blow or 
something, ethernet will start dropping packets. 

> However, there are applications where one can predict what the master
> will do ahead of time and don't have these problems.  In my case I
> know what and when the master will do something and can prime the SSP
> with a matching slave mode transaction before the master initiates.  I
> know I'm not the first person who has needed to do this on Linux.  So
> maybe it's worthwhile to add a limited slave support system without
> solving the problem of general purpose slave support.

You're welcome to try this, many people did before and failed :(

Best regards,
Marek Vasut
