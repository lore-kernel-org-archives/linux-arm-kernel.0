From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 10 Sep 2014 20:02:54 +0300
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <20140909195819.GJ2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk> <540F3447.3020609@ti.com>
 <20140909172057.GH2601@sirena.org.uk> <540F44EB.8090700@ti.com>
 <20140909195819.GJ2601@sirena.org.uk>
Message-ID: <5410843E.5020301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/09/2014 10:58 PM, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 02:20:27PM -0400, Murali Karicheri wrote:
>> On 09/09/2014 01:20 PM, Mark Brown wrote:
> 
>>> If these delays are not related to chip select then the documentation
>>> needs to be fixed to not refer to chip select.
> 
>> Ok. So what I understand is the issue is not having the right description to
>> indicate that these parameters are delays associated with tranmission of
>> successive words on the wire. Personally I like these description match with
>> what is described in the device spec/ user guide and what is described above
>> match with that. However we could add additional description as below to to
>> make it more explicit.
> 
>> spi-c2t-delay - delay after CS is asserted before output bits on wire
>> spi-t2c-delay - delay after tramission of bits and before deasserting CS
> 
>> Do you think this will help?
> 
> No, that doesn't help at all.  You keep claiming that these parameters
> are related to the intervals between words but then providing
> descriptions of these parameters which relate to intervals around
> changes in /CS which is patently not something connected with the gaps
> between words.  Either your description of parameters which do not
> relate to /CS should not need to mention /CS or the parameters are in
> fact related to /CS, both can't simultaneously be true.
> 

This is what we have in DM (http://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf):
=========================================
2.5.1.3 Automatic Delay Between Transfers

The SPI master can automatically insert a delay of between 2 and 65 SPI module clock
cycles between transmissions. This delay is controlled by the WDELAY field in the SPI
data format register n (SPIFMTn) and is enabled by setting the WDEL bit in the SPI
transmit data register (SPIDAT1) to 1. The WDELAY period begins when the
T2EDELAY period terminates (if T2E delay period is enabled) or when
the T2CDELAY period terminates (if T2E delay period was disabled and T2C delay
period was enabled) or when the master deasserts SPISCS[n] (if T2E and T2C delay
periods are disabled). If a transfer is initiated by writing a 32-bit value to SPIDAT1,
then the new values of SPIDAT1.WDEL and SPIFMTn.WDELAY are used; otherwise,
the old values of SPIDAT1.WDEL and SPIFMTn.WDELAY are used. The WDELAY
delay period is specified by:

2.5.1.4 Chip Select Hold Option
There are slave devices available that require the chip select signal to be held
continuously active during several consecutive data word transfers. Other slave devices
require the chip select signal to be deactivated between consecutive data word transfers.
The SPI can support both types of slave devices. The CSHOLD bit in the SPI transmit
data register (SPIDAT1) selects between the two options.

If the chip select hold option is enabled, the chip select will not toggle between two
consecutive accesses. Therefore, the SPIDELAY.T2CDELAY of the first transfer and
the SPIDELAY.C2TDELAY of the second transfer will not be applied. However, the
wait delay could still be applied between the two transactions, if the WDEL bit in
SPIDAT1 is set to 1.

When the CSHOLD bit is 0, during the data transmission, the value of the chip select
number field (CSNR[n:0]) in the SPIDAT1 register is put on the chip select SPISCS[n]
to SPISCS[0] pins. When the transmission finishes, the chip select default pattern
(CSDEF[n:0]) is put on the SPISCS[n] to SPISCS[0] pins.
=========================================

And according to above the final delay between consecutive data word transfers can
be formed as sum of T2CDELAY  WDELAY, C2TDELAY and can include CS toggling
(exactly as shown on diagram).

I'm going to drop "spi-c2t-delay"/"spi-t2c-delay" properties, because CSHOLD is always
set now by Davinci SPI driver, so these delays will not be applied (this feature can be
enabled later). 
But WDELAY is important for us as we have issue with custom SPI device (FPGA based).

So, next version will only have "ti,spi-word-delay". Is it okay for you?

Best regards,
-grygorii
