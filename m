From: sourav.poddar@ti.com (Sourav Poddar)
Date: Wed, 27 Nov 2013 16:26:36 +0530
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <201311271106.09624.marex@denx.de>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <201311271027.06982.marex@denx.de> <5295BFB3.5020109@ti.com>
 <201311271106.09624.marex@denx.de>
Message-ID: <5295CFE4.70404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,
On Wednesday 27 November 2013 03:36 PM, Marek Vasut wrote:
> Dear Sourav Poddar,
>
>> Dear Marek Vasut, Huang,
>>
>> On Wednesday 27 November 2013 02:57 PM, Marek Vasut wrote:
>>> Dear Huang Shijie,
>>>
>>>> 1.) Why add a new framework for SPI NOR?
>>>>
>>>>     The SPI-NOR controller such as Freescale's Quadspi controller is
>>>>     working in a different way from the SPI bus. It should knows the NOR
>>>>     commands to find the right LUT sequence. Unfortunately, the current
>>>>     code can not meet this requirement.
>>> Is there any kind of documentation for this controller available? I
>>> cannot quite understand how this controller works and why can it not be
>>> used with our current infrastructure.
>> I do have a similar requirement where my controller need to be configured
>> from slave info. I have submiited a series in the mtd list adding that
>> portion
>> of handling such cases. Here, is the patch which specific to m25p80 part.
>> http://patchwork.ozlabs.org/patch/294285/
>>
>> The whole series can be found here:
>> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg98691.html
> Is this TI QSPI the same thing as the Altera QSPI controller please ?
>
No, its differenet.
> Otherwise, I seriously believe you and Huang should work on a common
> infrastructure. I would first like to understand how is the controller in DRA7xx
> different from regular SPI controller though. Is there any kind of documentation
> I could study please?
>
Sorry, we dont have a public document yet.

Though, this is what ti qspi contoller has

It supports two modes of operation, one is SPI mode(normal), other is
the memory mapped read mode.

For SPI mode, the state machine remains the same as it is with other spi 
controller
available.

For memory mapped, there is something more which we need to do around ..

1. There is a qspi "set up" register available, which needs to be filled 
with
      information like flash opcode, dummy bytes etc. In short, flash 
specific
      details.
2   if the above register is configured with the required opcodes, then 
whenever
      we need to use memory mapped operations, we need to do is to 
switch our
      qspi controller to memory mapped mode.
     Switching of this mode to memory mapped needs
      a )  write to a particular qspi register
      b)   write to control module(optional based on SOC).

3. Once the above steps are configured, then the flash data will be 
mapped to a
     particular memory address(SOC specific) from where the flash data  
can be read.

The series 
https://www.mail-archive.com/linux-omap at vger.kernel.org/msg98691.html
tries to work on the above features, and tries to add a support for the 
same in the
spi framework and m25p80 code.

As you see in my patches, once we take care of the above points and add 
support
for memory mapped in m25p80 and qspi, then while doing a read in m25p80 
we can
do memcpy at the beginning of m25p80_read and can bypass the entire SPI
framework for memory mapped read operation. Throughput almost gets 
doubles with this,
as compared to normal SPI operations.

Please get back, if you need more info on this concept.

> Best regards,
> Marek Vasut
