From: vigneshr@ti.com (Vignesh R)
Date: Thu, 4 Oct 2018 16:05:36 +0530
Subject: [PATCH 0/3] spi-nor: Add Octal SPI support
In-Reply-To: <20181003212017.653e739f@bbrezillon>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003212017.653e739f@bbrezillon>
Message-ID: <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 October 2018 12:50 AM, Boris Brezillon wrote:
> On Wed, 3 Oct 2018 22:26:00 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> This series adds support for octal mode of mt35x flash. Also, adds
>> support for OSPI version of Cadence QSPI controller.
>>
>> Based on top of patches adding basic support for mt35xu512aba here:
>> https://patchwork.ozlabs.org/cover/971437/
>>
>> Vignesh R (3):
>>   mtd: spi-nor: Add Octal mode support for mt35xu512aba
>>   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
>>   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller
> 
> The patchset looks good to me, I'll just wait the next release cycle
> before applying it, since I'd prefer to have it stay a bit longer in
> -next. This should leave enough time to let other people review this
> stuff.
> 

Ok, thats fine...

>>
>>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
> 
> On a slightly different topic, do you plan to convert the Cadence
> driver to spi-mem? And if you don't, is it because you don't have time
> or because some features are missing in spi-mem (I remember you
> mentioned a few things back when you were reviewing the spi-mem series)?
> 

I do not have plans to convert cadence QSPI driver to spi-mem yet,
mainly due to lack of time. Also, not sure if original author Marek and
other altera people are okay with that.

I see couple of issues in the way of conversion:
1. I would wait to know what direction would direct mapping APIs[1] go
before starting spi-mem conversion for Cadence QSPI driver. Else, we
have may to re write again if direct mapping APIs are merged.
2. New Cadence OSPI IP has an integrated PHY to support high throughput
OSPI flashes operating up 200MHz in Octal DDR mode. In order to work
with such flashes, PHY DLLs need to be calibrated. Highly simplified
calibration sequence is as below(See [2] for actual sequence):
-Read flash ID at low speed and store it.
-Enable PHY and set DLLs to a defined initial value
-Increment RX DLL value
-Read flash ID and check for correctness of data read
-repeat above two steps until a band of passing values is obtained for
RX DLL where flash ID is correctly read.
-DLL needs to set to middle of the passing band.

I am trying to figure out how to fit this into the spi-mem framework as
controller would to need to store READ ID opcode and expected JEDEC ID
before starting calibration sequence.


[1]https://patchwork.ozlabs.org/cover/924041/
[2]http://www.ti.com/lit/ug/spruid7a/spruid7a.pdf(12.3.2.4.14 PHY Module
page 9770-9772)

-- 
Regards
Vignesh
