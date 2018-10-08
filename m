From: vigneshr@ti.com (Vignesh R)
Date: Mon, 8 Oct 2018 21:06:02 +0530
Subject: [PATCH 0/3] spi-nor: Add Octal SPI support
In-Reply-To: <20181004131732.4c9e2ae9@bbrezillon>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003212017.653e739f@bbrezillon>
 <1074d503-71ef-2998-7096-de6135bb965d@ti.com>
 <20181004131732.4c9e2ae9@bbrezillon>
Message-ID: <e4af1014-2008-440c-a017-bb8e7e960d3b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Sorry I missed this mail.

On Thursday 04 October 2018 04:47 PM, Boris Brezillon wrote:
> On Thu, 4 Oct 2018 16:05:36 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>>>>
>>>>  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
>>>>  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++  
>>>
>>> On a slightly different topic, do you plan to convert the Cadence
>>> driver to spi-mem? And if you don't, is it because you don't have time
>>> or because some features are missing in spi-mem (I remember you
>>> mentioned a few things back when you were reviewing the spi-mem series)?
>>>   
>>
>> I do not have plans to convert cadence QSPI driver to spi-mem yet,
>> mainly due to lack of time. Also, not sure if original author Marek and
>> other altera people are okay with that.
>>
>> I see couple of issues in the way of conversion:
>> 1. I would wait to know what direction would direct mapping APIs[1] go
>> before starting spi-mem conversion for Cadence QSPI driver. Else, we
>> have may to re write again if direct mapping APIs are merged.
> 
> I'd suggest reviewing the proposal I posted so that you can influence
> the design of this new API ;-).
> 

I did take a look and proposal seems fine. Will try to prototype and
test cadence QSPI driver with these. Thanks for the patches!


>> 2. New Cadence OSPI IP has an integrated PHY to support high throughput
>> OSPI flashes operating up 200MHz in Octal DDR mode. In order to work
>> with such flashes, PHY DLLs need to be calibrated. Highly simplified
>> calibration sequence is as below(See [2] for actual sequence):
>> -Read flash ID at low speed and store it.
>> -Enable PHY and set DLLs to a defined initial value
>> -Increment RX DLL value
>> -Read flash ID and check for correctness of data read
>> -repeat above two steps until a band of passing values is obtained for
>> RX DLL where flash ID is correctly read.
>> -DLL needs to set to middle of the passing band.
> 
> Is the Read ID operation hardcoded or do you just use it as a way to
> trigger predictable transfers on the IO bus?
> 

Just a way to trigger predictable data reads.

>>
>> I am trying to figure out how to fit this into the spi-mem framework as
>> controller would to need to store READ ID opcode and expected JEDEC ID
>> before starting calibration sequence.
> 
> I think this should be split in 2:
> 
> - the SPI NOR framework passing the operation to use to do the
>   calibration (here a READ ID)
> - the SPI controller framework replaying the same operation with
>   different DLL configs until it finds the best match
> 
> So, it would basically be added as a new hook:
> 
> 	int (*calibrate)(struct spi_mem *mem,
> 			 const struct spi_mem_op *tmpl);
> 
> and a new function provided by the spi-mem API
> 
> int spi_mem_calibrate(struct spi_mem *mem,
> 		      const struct spi_mem_op *tmpl);
> 
> and calibration outcome would be somehow attached to the spi_mem
> object.
> 
> This way we stay memory agnostic but still provide the necessary blocks
> at the spi-mem level to do such callibrations.
> 
> Would that work?
> 

That would work and hopefully is not intrusive to spi-mem framework.

-- 
Regards
Vignesh
