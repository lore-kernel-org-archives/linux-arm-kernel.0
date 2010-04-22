From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 23 Apr 2010 09:29:23 +1200
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100422054519.GA26418@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422054519.GA26418@gw.healthdatacare.com>
Message-ID: <4BD0BFB3.9060907@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg wrote:
> On Wed, Apr 21, 2010 at 01:00:56PM -0500, H Hartley Sweeten wrote:
>> Same results are your v4 driver.  But, I think your on the right track.
> 
> Thanks for testing.
> 
>> I think the problem is in the ep93xx_spi_read_write routine.  That function
>> returns 0 as long as there is still data left in the current transfer.  The
>> only time it doesn't return 0, which will cause the can_continue, is when:
>>
>> 	if (espi->rx == t->len) {
>> 		msg->actual_length += t->len;
>> 		return t->len;
>> 	}
>>
>> At this point the tx and rx fifos will both be empty, which causes the SSP
>> peripheral to raise the SFRM signal.
> 
> True.
> 
>> A picture is worth a thousand words... Attached is a logic analyzer capture
>> of the Read-ID command and response from the SPI Flash.  EGPIO7 is my chip
>> select to the flash.  The first 4 SPI MOSI (Tx) blocks are the 0x90, 0x00,
>> 0x00, 0x00 command to the flash.  You will notice that the SFRM line is
>> asserted for those bytes.  A bit later are the 2 SPI MISO (Rx) responses
>> from the flash with the ManID/DevID, again with the SFRM line asserted.
> 
> Yeah, it clearly shows that SFRMOUT is deasserted between transfers :(
> 
> I will try to work out some sort of hack which will keep the FIFOs from
> emptying.
> 
> MW

I still have not found time to test this, but I think this is the
problem we had we resulted in us using polling mode rather than
interrupts. If the spi fifo empties then it will deassert the frame
signal. By using polling code we could ensure that the fifos would not
drain at the incorrect time. The other solution is to use an externally
drivable signal for the frame (such as a gpio), but this is obviously
not possible on some existing hardware.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
