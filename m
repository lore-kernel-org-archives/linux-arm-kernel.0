From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 8 Dec 2015 15:32:51 +0100
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
In-Reply-To: <5666B01B.9040707@atmel.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <20151207193441.GO120110@google.com> <5666B01B.9040707@atmel.com>
Message-ID: <5666EA13.6040605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/12/2015 11:25, Cyrille Pitchen a ?crit :
> Hi Brian,
> 
> Le 07/12/2015 20:34, Brian Norris a ?crit :
[...]
>> Also, I see a lot of good comments in patch 2 about Spansion vs.
>> Macronix vs. Micron memories. I wonder if previous developers have
>> completely tested their patches, or if they're just reading the
>> datasheets... so, what kind have testing have you done? Do you have
>> samples of all these flash to test?
>>
> 
> I want to be totally honest on this point: I did NOT test with Macronix
> memories yet simply because I have no such memory from this manufacturer.
> I guess Atmel planed to purchase some samples because we also need to test
> their support in the sama5d2 romcode when booting from QSPI.
> So for the Macronix case, the patches are only based on my current
> understanding of Macronix datasheets (MX66L1G45G, 3V, 1Gb, v1.0.pdf).
> 
> On the other hand I did many tests with both Micron and Spansion memories
> with sama5d2 SoCs, either with Linux or with the sama5d2 romcode ("normal"
> Fast Read x-y-4 but also eXecution In Place using the Continuous Read mode:
> the XIP mode is not relevant for the Linux spi-nor framework but it should
> take care of the "dummy cycles" it sends to avoid entering into the
> Continuous Read mode by mistake).
> I used at least these memories under Linux:
> - Micron n25q128a13: sama5d2 xplained ultra + linux-next 20151207 /
>   at91 linux 4.1
> - Micron n25q256: sama5d2 prototype (FPGA) + at91 linux 3.18
> - Spansion s25fl512: sama5d2 prototype (FPGA) + at91 linux 3.18
> 

I forgot few points. First, I did all Quad SPI tests using the Atmel QSPI
controller and driver.

I did no Dual SPI protocol test yet, only Quad SPI.

I'm able to test neither Quad nor Dual SPI protocols with the Atmel QSPI
protocol + m25p80 driver: this driver is not really suited for handling
the Atmel QSPI controller in its Serial Memory Mode.

However I did some non regression tests with the m25p80 driver used on the
regular Atmel SPI controller and driver (drivers/spi/spi-atmel.c) to
access a at25df312a memory (SPI 1-1-1 protocol).


Nonetheless the m25p80 driver was taken into account when I wrote the series.
Indeed Micron, Macronix and Spansion's datasheets provide tables giving the
number of dummy cycles to use depending on both the SPI bus clock
frequency and the Fast Read command. Hence in spi-nor.c, patch 2 sets
nor->read_dummy to the relevant number of dummy cycles (not bits).

Taking Spansion memories as an example, for their factory default Latency
Code value of 0, they expect:
- 8 dummy cycles for Fast Read 1-1-1 (0x0b / 0x0c)
- 8 dummy cycles for Fast Read 1-1-2 (0x3b / 0x3c)
- 8 dummy cycles for Fast Read 1-1-4 (0x6b / 0x6c)

Fast Read 1-2-2 and 1-4-4 are not used with Spansion memories since the
number of dummy cycles to be used with one of these op codes is not suited
for the m25p80 driver.

For Micron and Macronix, except when their Quad SPI mode is enabled, the
Fast Read 1-1-4 or Fast Read 1-1-2 commands are preferred to the
Fast Read 1-4-4 or Fast Read 1-2-2 commands. The number of dummy cycles is
set to 0 for Read command (0x03) and 8 for other Fast Read commands since
this setting update can be done safely writing into volatile bits inside
configuration registers. A multiple of 8 dummy cycles is suited for the
m25p80_read() implementation.

Then looking at the m25p80 driver, the original (unchanged) cycles/bytes
conversion from the m25p80_read() hook only works with SPI 1-1-x protocols:

 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;

As a matter of fact, 8 dummy cycles stand for:
-  8 bits (1 byte ) for SPI 1-1-z protocols
- 16 bits (2 bytes) for SPI x-2-z protocols
- 32 bits (4 bytes) for SPI x-4-z protocols

So I should also fix the above conversion in patch 3 to cover more SPI
protocols.


Best Regards,

Cyrille
