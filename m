From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 22 Aug 2014 16:33:09 +0300
Subject: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
In-Reply-To: <20140821182035.GM24407@sirena.org.uk>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
 <20140821182035.GM24407@sirena.org.uk>
Message-ID: <53F74695.3010902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/21/2014 09:20 PM, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:25:06PM +0300, Grygorii Strashko wrote:
> 
>> +- ti,davinci-spi-wdelay : delay between transmissions.
> 
> I don't understand why this is here - there is already standard support
> in the SPI core for client drivers specifying inter-transfer delays.  If
> there is a need to provide platform configuration for this in addition
> to that then it should also be a standard property, there is nothing
> device specific about these.

Sorry, may be I've missed smth, because I was not able to find such common 
property in SPI bindings document and code. Could you point me on, pls?

In our case it's hardware delay applied between transmissions:
"Delay in between transmissions. Idle time that will be applied at
 the end of the current transmission if the bit WDEL is
set in the current buffer. The delay to be applied is equal to:
WDELAY ? PSPI module clock + 2 ? PSPI module clock
 PSPI module clock -> Period of SPI module clock"

> 
>> +- ti,davinci-spi-odd-parity : odd partity enabled
>> +   OR
>> +  ti,davinci-spi-even-parity : even parity enabled
> 
> What do these mean?

Supported by OMAP-L138/da830:
"
SPIFMTn[23].PARPOL - Parity polarity: even or odd. PARPOL can be modified in privilege mode only.
 0 An even parity flag is added at the end of the transmit data stream.
 1 An odd parity flag is added at the end of the transmit data stream.

SPIFMTn[22].PARENA - Parity enable.
 0 - No parity generation/ verification is performed.
 1 - A parity is transmitted at the end of each transmit data stream. At the end of a transfer the parity
 generator compares the received parity bit with the locally calculated parity flag. If the parity bits do
 not match the PARERR flag is set in the corresponding control field. The parity type (even or odd)
 can be selected via the PARPOL bit.
"

> 
>> +- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.h)
> 
> The bindings should be independent of the kernel, the values need to be
> included here (and the defines moved to include/dt-bindings so they can
> be used when writing DTs).

Allowed values here are:
#define SPI_IO_TYPE_INTR	0
#define SPI_IO_TYPE_POLL	1
#define SPI_IO_TYPE_DMA		2

I'll update.

> 
>> +- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
>> +- ti,davinci-spi-c2t-delay: c2t delay
>> +- ti,davinci-spi-t2c-delay: t2c delay
>> +- ti,davinci-spi-t2e-delay: t2e delay
>> +- ti,davinci-spi-c2e-delay: c2e delay
> 
> What are all these timers/delays - at least some reference to the
> datasheet please?
> 

Sorry, I'll update bindings with links on datasheet.

Keystone 2:
http://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf

Davinci:
dm644x - http://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf

Regards,
-grygorii
