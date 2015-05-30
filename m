From: richard@nod.at (Richard Weinberger)
Date: Sat, 30 May 2015 21:33:55 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add driver for NXP SPI Flash Interface
 (SPIFI)
In-Reply-To: <5569FC99.1060706@vanguardiasur.com.ar>
References: <1432921816-10765-1-git-send-email-manabian@gmail.com>	<1432921816-10765-2-git-send-email-manabian@gmail.com>	<5569DAB9.9070105@vanguardiasur.com.ar>
 <CAGhQ9VwsiPaFw=cMXhQrKfg8zWGa7RMOd+H6_VXfRepOwWbtYQ@mail.gmail.com>
 <5569FC99.1060706@vanguardiasur.com.ar>
Message-ID: <556A10A3.6000406@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.05.2015 um 20:08 schrieb Ezequiel Garcia:
> +Richard
> 
> On 05/30/2015 01:51 PM, Joachim Eastwood wrote:
>> Hi Ezequiel,
>>
>> On 30 May 2015 at 17:43, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
>>> Hi Joachim,
>>>
>>> Looks pretty neat. I've just a couple comments.
>>>
>>> On 05/29/2015 02:50 PM, Joachim Eastwood wrote:
>>>> Add SPI-NOR driver for the SPI Flash Interface (SPIFI)
>>>> controller that is found newer NXP MCU devices.
>>>>
>>>> The controller supports serial SPI Flash devices with 1-, 2-
>>>> and 4-bit width in either SPI mode 0 or 3. The controller
>>>> can operate in either command or memory mode. In memory mode
>>>> the Flash is exposed as normal memory and can be directly
>>>> accessed by the CPU.
>>>>
>>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/Kconfig     |  10 +
>>>>  drivers/mtd/spi-nor/Makefile    |   1 +
>>>>  drivers/mtd/spi-nor/nxp-spifi.c | 508 ++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 519 insertions(+)
>>>>  create mode 100644 drivers/mtd/spi-nor/nxp-spifi.c
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>>>> index 64a4f0edabc7..f10a37f1a4ef 100644
>>>> --- a/drivers/mtd/spi-nor/Kconfig
>>>> +++ b/drivers/mtd/spi-nor/Kconfig
>>>> @@ -28,4 +28,14 @@ config SPI_FSL_QUADSPI
>>>>         This enables support for the Quad SPI controller in master mode.
>>>>         We only connect the NOR to this controller now.
>>>>
>>>> +config SPI_NXP_SPIFI
>>>> +     tristate "NXP SPI Flash Interface (SPIFI)"
>>>> +     depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
>>>
>>> Since you are adding COMPILE_TEST, maybe you want
>>> 'depends on HAS_IOMEM' as well?
>>
>> Since MTD depends on GENERIC_IO is that needed?
>> Or am I confusing the config options here(?)
>>
> 
> I think you need HAS_IOMEM for ioremap stuff.
> Maybe Brian or Richard will know better.

Yes, if you need ioremap() your driver has to depend on HAS_IOMEM.

We have GENERIC_IO to allow non-physical MTD stuff
on architectures without io memory, namely s390 and UML.
Some time ago I've implemented GENERIC_IO to make nandsim
and UBI work on UML.

Thanks,
//richard
