From: sr@denx.de (Stefan Roese)
Date: Thu, 24 Mar 2016 06:45:35 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160323183952.GK5250@lunn.ch>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com> <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk> <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk> <56F295E1.4030505@denx.de>
 <20160323132732.GN2566@sirena.org.uk> <56F2D19A.7020604@denx.de>
 <20160323183952.GK5250@lunn.ch>
Message-ID: <56F37EFF.2090605@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.03.2016 19:39, Andrew Lunn wrote:
>> Please note that this direct access mode is really not suitable
>> for "normal" SPI devices like SPI NOR chips. As the direct read
>> mode (as described in chapter 22.5.1 of the Armada XP datasheet)
>> always generates:
>>
>> a) a write command to the SPI bus (opcode configurable via register)
>>
>> and
>>
>> b) writes 1-4 address bytes to the SPI bus
>>
>> before the data is read from the SPI bus.
>>
>> So its definitely nothing that should be enabled per default for
>> all SPI devices.
> 
> Looking at the Kirkwood datasheet, it suggests it can be used with SPI
> flash:
> 
> 	If using SPI flash, set the <Attr> field in the CPU address
> 	decoding windows to match the SPI interface (see Section 2,
> 	Address Map, on page 34 for more details). Any CPU read to
> 	this address space is converted by the SPI controller to a SPI
> 	flash read transaction, composed of an address phase, followed
> 	by a data phase.
> 
> 	The actual sequence that is driven on the SPI interface is:
> 
> 	1. Assert SPI_CSn. Write command to the SPI. The command is
> 	either Read or Fast_Read, based on the configuration of the
> 	<DirectRdCommand> field.
> 
> 	2. Write the address. The Address is driven in 1 to 4 phases
> 	based on the configuration of the <DirectAddrLen>> field. The order of
> 	the bytes is MSB to LSB.
> 
> 	3. In Fast_Read mode, add a one-byte dummy write.
> 
> 	4. Read the data, according to the length given by the request.
> 
> 	5. De-assert the SPI_CSn signal.

Right. It is of course possible to use this direct mode to access
SPI flash. Its just not the way how the SPI MTD driver uses the
SPI controller. All information that is written to the SPI flash
(e.g. commands, addresses) are passed as plain tx-data in the SPI
message to the SPI controller. And it would be not easy to detect
commands / addresses vs. "real data" in this orion SPI driver
to put these values into the specific registers.
 
> There is also something interesting in the Direct Write to SPI
> section:
> 
> 	4. Address Phase.
> 
> 	This is a 1-4 byte field that is taken from the address of the
> 	request.  The size of the address is configured via the
> 	<DirectAddrLen> field in the Serial Memory Interface
> 	Configuration Register (Table 629 p. 686).  The entire Address
> 	phase is omitted when <Direct Wr Addr Enable> field in the
> 	Serial Memory Direct Write Configuration Register (Table 634
> 	p. 688) is cleared.
> 
> Turning off the address phase may mean it is possible to do normal SPI
> writes using the direct mode.

Correct. And this is exactly why I'm using this direct write mode
for the FPGAs connected via SPI. To implement normal, optimized SPI
writes using this direct write mode.

> Quite a few Kirkwood boards have SPI flash, so if this brings better
> performance, it would be nice to be able to use it.

Yes. But I hope my explanation above makes it clear that this is not
easily implemented. So I suggest to just use the implementation I've
added with this patch for these special SPI devices like FPGAs
for fast bitstream downloading. And for this it is necessary, to make
this direct access mode optionally configurable on a per-SPI-device
basis.

Thanks,
Stefan
