From: b32955@freescale.com (Huang Shijie)
Date: Thu, 16 Jan 2014 17:11:19 +0800
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
Message-ID: <52D7A237.8@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?01?16? 03:15, Jagan Teki ??:
> Hi,
>
> On Wed, Dec 25, 2013 at 11:20 AM, Huang Shijie<b32955@freescale.com>  wrote:
>> 1.) Why add a new framework for SPI NOR?
>>    The SPI-NOR controller such as Freescale's Quadspi controller is working
>>    in a different way from the SPI bus. It should knows the NOR commands to
>>    find the right LUT sequence. Unfortunately, the current code can not meet
>>    this requirement.
>>
>> 2.) How does this patch set do?
>>     This patch set adds a new spi-nor layer.
>>     Before this patch, the layer is like:
>>
>>                     MTD
>>           ------------------------
>>                    m25p80
>>           ------------------------
>>                 spi bus driver
>>           ------------------------
>>                  SPI NOR chip
>>
>>     After this patch, the layer is like:
>>                     MTD
>>           ------------------------
>>                    spi-nor
>>           ------------------------
>>                    m25p80
>>           ------------------------
>>                 spi bus driver
>>           ------------------------
>>                 SPI NOR chip
>>
>>    With the spi-nor controller driver(Freescale Quadspi), it looks like:
>>                     MTD
>>           ------------------------
>>                    spi-nor
>>           ------------------------
>>                  fsl-quadspi
>>           ------------------------
>>                 SPI NOR chip
> I'm new to this thread, may be I'll ask basic questions.
> 1) what does m25p80 contains with your new framework - will excludes
> quad stuff if they add
sorry, i do not understand your meaning.

do you think the m25p80 can not support the quad read after this patch set?


> 2) I didn't understand why the controller driver fsl-quadspi will be
> in mtd becuase as it's (q)spi driver
> may does flash or non-flash functionalities if ie, the case should be
> part of drivers/spi/*
Please read this thread, Mark though it should be spi nor driver:

http://marc.info/?l=linux-arm-kernel&m=137782885415953&w=2
> 3) Can you explain your framework precisely take an example of like
> spi_controller_A with spi_flash_A
> and qspi_controller_B and qspi_flash_B - how will this new framework operates.
>
The framework is just cloned from the m25p80.c, and extract the common 
code, and provides more
hooks such as

@prepare/unpreare: used to do some work before or after the
              read/write/erase/lock/unlock.
     @read_xfer/write_xfer: We can use these two hooks to code all
              the following hooks if the driver tries to implement them
              by itself.
     @read_reg: used to read the registers, such as read status register,
              read configure register.
     @write_reg: used to write the registers, such as write enable,
              erase sector.
     @read_id: read out the ID info.
     @wait_till_ready: wait till the NOR becomes ready.
     @read: read out the data from the NOR.
     @write: write data to the NOR.
     @erase: erase a sector of the NOR.



The drivers can implement these hooks.

thanks
Huang Shijie
