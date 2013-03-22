From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 10:26:06 +0100
Subject: [PATCH v7 00/14] spi/spi-atmel: add dmaengine support for atmel
 spi controller and to test the device tree support
In-Reply-To: <514AD3A2.50203@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <514AD3A2.50203@atmel.com>
Message-ID: <514C23AE.7080101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 10:32 AM, Nicolas Ferre :
> On 03/19/2013 08:41 AM, Wenyou Yang :
>> Hi All, 
>>
>> This set of patches is to add dmaengine support for atmel spi and to test device tree support.
>>
>> The work is based on Nicolas and Richard's work.
>>
>> Because the dma engine device tree support isn't available now, to at91sam9x5ek and at91sam9n12ek
>> with dma support, it doesn't work on the dmaengine mode, only on PIO mode so far.
>>
>> It has been tested as below:
>>  1./tested on v3.9-rc3, by using mtd utils, "mount", "umount" and "cp" commands.
>>  2./tested on "spi/next" git tree after changing master->num_chipselect which fixed in v3.9-rc1.
>>  3./tested by using Documentation/spi/spidev_test.c on "/dev/spidev".
>>  4./tested on on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and at91sam9g20ek boards.
>>
>> It is based on v3.9-rc3 + Joachim Eastwood's spi/atmel: fix speed_hz check in atmel_spi_transfer().
>>
>> Changelog:
>> v7:
>>      1./ remove patch: fix probing failure after xfer->speed_hz set.
>>      2./ remove patch: add pinctrl support for atmel spi.
> 
> 
> It it makes sense, you can add my:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> on patches that I did not acknowledged yet.
> 
> Grant,
> 
> Can we move forward with this patch series so that we can build on solid
> bases for future developments on atmel SPI.

Moreover, if it can ease the process, I can take patches 11, 12, 13 and
14 with at91-dt branch and submit that to arm-soc.

Tell me if you feel it is better...

Bye,


>> v6:
>>      1./ remove: fix master->num_chipselect wrongly set patch which isn't a issue in v3.9-rc1.
>>      2./ fix probing failure after xfer->speed_hz set.
>>
>> v5:
>>      1./ add pinctrl patches.
>>      2./ detect capabilities by reading spi version register to replace multiple compatiles.
>>      3./ change the "cs-gpios" property of spi node.
>>      4./ rebase on v3.8.
>>
>> v4:
>>      1./ Take Joe Perches's adivce, rewrite atmel_spi_is_v2(struct atmel_spi *as) 
>>          and atmel_spi_use_dma(struct atmel_spi *as),
>> 	 and remove atmel_spi_use_pdc(struct atmel_spi *as).
>>      2./ Rebase on v3.8-rc3.
>>
>> V3:
>>      1./ Rebase on v3.8-rc2.
>>      2./ Remove some Jean-Christophe's patches which has been applied on v3.8-rc2.
>>      3./ Remove spi property "cs-gpios" from the SoC dtsi files to the board dts files
>>          to avoid some useless pin conflicts.
>>
>> v2: 
>>      1./ Remove the patch :PATCH]mtd: m25p80: change the m25p80_read to reading page to page
>> 	 which purpose to fix the BUG: when run "flashcp /bin/busybox /dev/mtdX" in the at91sam9g25ek
>> 	 with DMA mode, it arises a OOPS. Now fix it in this patch:
>> 	    [PATHC] spi/atmel_spi: add dmaengine support changing to fix the [BUG].
>>      2./ Remove two patches:
>>    	    which purpose to read dts property to select SPI IP version and DMA mode
>> 	    Now they will be gat from device tree different compatile.
>>      3./ Fix DMA: when enable both spi0 AND spi1, the spi0 doesn't work BUG.
>>      4./ Rebase v3.7-rc8.
>>
>> Best Regards,
>> Wenyou Yang.
>>
>>
>> Nicolas Ferre (5):
>>   spi/spi-atmel: add physical base address
>>   spi/spi-atmel: call unmapping on transfers buffers
>>   spi/spi-atmel: status information passed through controller data
>>   spi/spi-atmel: add flag to controller data for lock operations
>>   spi/spi-atmel: add dmaengine support
>>
>> Richard Genoud (6):
>>   spi/spi-atmel: fix spi-atmel driver to adapt to slave_config changes
>>   spi/spi-atmel: correct 16 bits transfers using PIO
>>   spi/spi-atmel: correct 16 bits transfers with DMA
>>   ARM: at91: add clocks for spi dt entries
>>   ARM: dts: add spi nodes for atmel SoC
>>   ARM: dts: add spi nodes for the atmel boards
>>
>> Wenyou Yang (3):
>>   spi/spi-atmel: detect the capabilities of SPI core by reading the
>>     VERSION register.
>>   spi/spi-atmel: add support transfer on CS1,2,3, not only on CS0
>>   ARM: dts: add pinctrl property for spi node for atmel SoC
>>
>>  arch/arm/boot/dts/at91sam9260.dtsi          |   40 ++
>>  arch/arm/boot/dts/at91sam9263.dtsi          |   40 ++
>>  arch/arm/boot/dts/at91sam9263ek.dts         |   10 +
>>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   10 +
>>  arch/arm/boot/dts/at91sam9g45.dtsi          |   40 ++
>>  arch/arm/boot/dts/at91sam9m10g45ek.dts      |   10 +
>>  arch/arm/boot/dts/at91sam9n12.dtsi          |   40 ++
>>  arch/arm/boot/dts/at91sam9n12ek.dts         |   10 +
>>  arch/arm/boot/dts/at91sam9x5.dtsi           |   40 ++
>>  arch/arm/boot/dts/at91sam9x5ek.dtsi         |   10 +
>>  arch/arm/mach-at91/at91sam9260.c            |    2 +
>>  arch/arm/mach-at91/at91sam9g45.c            |    2 +
>>  arch/arm/mach-at91/at91sam9n12.c            |    2 +
>>  arch/arm/mach-at91/at91sam9x5.c             |    2 +
>>  drivers/spi/spi-atmel.c                     |  753 ++++++++++++++++++++++++---
>>  15 files changed, 945 insertions(+), 66 deletions(-)
>>
> 
> 


-- 
Nicolas Ferre
