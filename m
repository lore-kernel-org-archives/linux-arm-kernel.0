From: sr@denx.de (Stefan Roese)
Date: Mon, 2 May 2016 12:33:21 +0200
Subject: [PATCH v6] spi: orion.c: Add direct access mode
In-Reply-To: <8919835.yGyvx4h0Tr@wuerfel>
References: <1461147068-4829-1-git-send-email-sr@denx.de>
 <5726F7F3.9070700@denx.de> <8919835.yGyvx4h0Tr@wuerfel>
Message-ID: <57272CF1.9060706@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 02.05.2016 09:28, Arnd Bergmann wrote:
> On Monday 02 May 2016 08:47:15 Stefan Roese wrote:
>> On 20.04.2016 12:11, Stefan Roese wrote:
>>> This patch adds support for the direct write mode to the Orion SPI
>>> driver which is used on the Marvell Armada based SoCs. In this direct
>>> mode, all data written to (or read from) a specifically mapped MBus
>>> window (linked to one SPI chip-select on one of the SPI controllers)
>>> will be transferred directly to the SPI bus. Without the need to control
>>> the SPI registers in between. This can improve the SPI transfer rate in
>>> such cases.
>>>
>>> Currently only the direct write mode is supported. This mode especially
>>> benefits from the SPI direct mode, as the data bytes are written
>>> head-to-head to the SPI bus, without any additional addresses, that
>>> are also written in the direct read mode.
>>>
>>> One use-case for this direct write mode is, programming a FPGA bitstream
>>> image into the FPGA connected to the SPI bus at maximum speed.
>>>
>>> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
>>> Marvell Armada XP Functional Spec Datasheet.
>>>
>>> It should be possible to support SPI-NOR and SPI-NAND devices via
>>> this direct access mode as well. But this needs further work, e.g.:
>>> - The mapping of the MBus window needs to get extended to span
>>>     the complete flash device size
>>> - The address / control data needs to get inserted into the SPI
>>>     controller registers
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Mark Brown <broonie@kernel.org>
>>
>> Its been a while since v6 of this direct write access mode has been
>> posted. This is a gentle ping on its status.
>>
>> Arnd / Mark, do you have any additional change requests or are you okay
>> with the current version?
> 
> No objections, please add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.
 
> Two questions though:
> 
> - you now always send a multiple of four byte in each transfer, are
>    there any downsides in doing this, e.g. some SPI devices that might
>    get confused by receiving additional uninitialized data?

Yes, this is something that might happen on such devices. AFAIK, my
device (Altera FPGA) has no such restriction though. IIRC, the
size of the bitfiles is always 4-byte aligned.

I'll try to send v7 of this patch with a fully byte-size correct 
handling later today.
 
> - How does the performance compare to the normal mode, is it basically
>    unchanged, or does this patch make things faster?

The performance is increased. The factor of course depends on the SPI
transfer speed. Here the numbers for a ~70KiB image transferred at
27MHz SPI speed:

Using the PIO SPI transfer:

real    0m0.128s
user    0m0.010s
sys     0m0.120s

Using the direct write mode:

real    0m0.040s
user    0m0.000s
sys     0m0.020s

Thanks,
Stefan
