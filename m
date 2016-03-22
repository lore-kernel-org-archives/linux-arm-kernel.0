From: sr@denx.de (Stefan Roese)
Date: Tue, 22 Mar 2016 17:44:52 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160322173546.40d24cc2@free-electrons.com>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
Message-ID: <56F17684.2010307@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 22.03.2016 17:35, Thomas Petazzoni wrote:
> On Tue, 22 Mar 2016 17:24:53 +0100, Stefan Roese wrote:
>> This patch adds support for the direct access mode to the Orion SPI
>> driver which is used on the Marvell Armada based SoCs. In this direct
>> mode, all data written to (or read from) a specifically mapped MBus
>> window (linked to one SPI chip-select on one of the SPI controllers)
>> will be transferred directly to the SPI bus. Without the need to control
>> the SPI registers in between. This can improve the SPI transfer rate in
>> such cases.
>>
>> Both, direct-read and -write mode are supported. But only the write
>> mode has been tested. This mode especially benefits from the SPI direct
>> mode, as the data bytes are written head-to-head to the SPI bus,
>> without any additional addresses.
>>
>> One use-case for this direct write mode is, programming a FPGA bitstream
>> image into the FPGA connected to the SPI bus at maximum speed.
>>
>> This mode is described in chapter "22.5.2 Direct Write to SPI" in the
>> Marvell Armada XP Functional Spec Datasheet.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Nadav Haklai <nadavh@marvell.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
>> Mark, sorry for the huge delay for v2 of this direct-access patch.
>> I was busy with other tasks in the meantime. And only found now
>> the time to address (hopefully all) of your comments.
>
> Thanks for this new version! To be honest, I don't remember all the
> discussions that took place on the v1, so maybe I'll just be re-asking
> the same question.

No problem. Thanks for looking into this.

> Has there been any discussion on whether dynamically adding the MBus
> window is a good idea, as opposed to statically defining it in the
> board .dts ?

Yes. My 1st patch version (still RFC) used fixed MBus windows instead:

http://www.spinics.net/lists/linux-spi/msg06536.html

Mark suggested to use dynamic windows, so that one area could be
used for all SPI devices by switching (re-configuring) the MBus
window:

http://www.spinics.net/lists/linux-spi/msg06537.html

> So far, the only driver that was using dynamically allocated MBus is
> the PCIe controller driver, because there is no way in advanced to know
> the number and memory window requirements of the PCIe devices that will
> be connected to the system.
>
> For all other windows (BootROM, crypto SRAM and more recently network
> related SRAM), we are using statically allocated windows.
>
> So I'm wondering if we should add this additional DT binding that
> describes the necessary information to allow the driver to dynamically
> allocate a window, or if we shouldn't rely on a statically allocated
> window.
>
> This is really an open discussion, I don't have a very well-defined
> opinion on the matter.

I also have no real preference here.

> Let's Cc: Arnd Bergmann on this question, he has followed the whole
> MBus story and might have some interesting insights.

Good idea.

Thanks,
Stefan
