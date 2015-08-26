From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Wed, 26 Aug 2015 21:02:02 +0530
Subject: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
 MPSoC GQSPI controller
In-Reply-To: <CAD6G_RQhWBsUTZNBB44W98Fjzw82H_D_E9nY0aDWezj729mkoA@mail.gmail.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <CAD6G_RQhWBsUTZNBB44W98Fjzw82H_D_E9nY0aDWezj729mkoA@mail.gmail.com>
Message-ID: <CAGnW=BZtsVtT+Z7gTq5jybXsHWp+RNpjc6ckk6-MXWxAS7u8Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 5:49 PM, Jagan Teki <jteki@openedev.com> wrote:
> On 26 August 2015 at 11:56, Ranjit Waghmode <ranjit.waghmode@xilinx.com> wrote:
>> This series adds dual parallel mode support for Zynq Ultrascale+
>> MPSoC GQSPI controller driver.
>>
>> What is dual parallel mode?
>> ---------------------------
>> ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
>> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
>> 2) Chip selects and clock are shared to both the flash devices
>> 3) This mode is targeted for faster read/write speed and also doubles the size
>> 4) Commands/data can be transmitted/received from both the devices(mirror),
>>    or only upper or only lower flash memory devices.
>> 5) Data arrangement:
>>    With stripe enabled,
>>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
>>
>> This series also updated MTD layer files for adding parallel mode support.
>>
>> 1) Added Support for two flashes
>> 2) Support to enable/disable data stripe as and when required.
>> 3) Added required parameters to spi_nor structure. Initialized all
>>    added parameters in spi_nor_scan()
>> 4) Added support for dual parallel in spi_nor_read/write/erase functions by:
>>    a) Increasing page_size, sector_size, erase_size and toatal flash size
>>       as and when required.
>>    b) Dividing address by 2
>>    c) Updating spi->master->flags for qspi driver to change CS
>> 5) Updated read_sr() to get status of both flashes
>> 6) Also updated read_fsr() to get status of both flashes
>>
>> These all are very high level changes and expected to make an idea clear.
>> Comments and suggestions are always welcomed
>>
>> ---
>> V2 Changes:
>> a) Splitted patches based on logical changes
>> b) Added error handling for newly added APIs in SPI core
>> ---
>>
>> Ranjit Waghmode (4):
>>   spi: add support of two chip selects & data stripe
>>   mtd: add spi_device instance to spi_nor struct
>>   spi-nor: add dual parallel mode support
>>   spi: zynqmp: gqspi: add support for dual parallel mode configuration
>
> I don't find any previous discussion about way to inform flash
> dual-ness into spi-nor
> from spi drivers.
>
> Here is my idea, probably others may think same.
> Informing dual_flash from drivers/spi through flags or any other mode
> bits is not a better approach as dual flash feature is specific to
> spi-nor flash controller (controller specially designed for spi-nor
> flash not the generic spi controller).  So if the driver sits on
> drivers/mtd/spi-nor/ (ex: fsl-quadspi.c), may be we can inform flash
> specific things to spi-nor as it's not touching generic spi stack in
> Linux. But there is a defined-drawback if the driver is moved to
> drivers/mtd/spi-nor ie it can't use spi core API's at-all.

Xilinx GQSPI is a generic quad spi controller. The primary goal is to support
Generic/Future command sequences and Future NOR/NAND flash devices.
This core can also be used for legacy SPI devices. Due to the generic nature
of the core, software can generate any command sequence. It also has additional
features like parallel and stacked configurations to double the data
rate and size.
Accessing spi-nor flash device is one particular use case and like
that there will be
many. So, we decided to keep this driver in generic spi framework and
that is the ideal
thing to do for the GQSPI controller.

Regards,
Punnaiah

>
> thanks!
> --
> Jagan | openedev.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
