From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Wed, 13 Apr 2016 05:21:25 +0000
Subject: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
In-Reply-To: <57067694.8030806@atmel.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
 <57067694.8030806@atmel.com>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C720DE@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille and Mark,

>-----Original Message-----
>From: Cyrille Pitchen [mailto:cyrille.pitchen at atmel.com]
>Sent: Thursday, April 07, 2016 8:33 PM
>To: Lakshmi Sai Krishna Potthuri <lakshmis@xilinx.com>; Michal Simek
><michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>; David
>Woodhouse <dwmw2@infradead.org>; Brian Norris
><computersforpeace@gmail.com>; Mark Brown <broonie@kernel.org>;
>Javier Martinez Canillas <javier@osg.samsung.com>; Boris Brezillon
><boris.brezillon@free-electrons.com>; Stephen Warren
><swarren@nvidia.com>; Geert Uytterhoeven <geert+renesas@glider.be>;
>Andrew F. Davis <afd@ti.com>; Marek Vasut <marex@denx.de>; Jagan Teki
><jteki@openedev.com>; Rafa? Mi?ecki <zajec5@gmail.com>
>Cc: linux-mtd at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
>spi at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Harini Katakam
><harinik@xilinx.com>; Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
>Anirudha Sarangi <anirudh@xilinx.com>; Lakshmi Sai Krishna Potthuri
><lakshmis@xilinx.com>; R, Vignesh <vigneshr@ti.com>
>Subject: Re: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
>spi_transfer structure.
>
>Hi all,
>
>Le 07/04/2016 16:39, P L Sai Krishna a ?crit :
>> This patch adds dummy_cycles entry in the spi_transfer structure.
>> len field in the transfer structure contains dummy bytes along with
>> actual data bytes, controllers which requires dummy bytes use len
>> field and simply Ignore the dummy_cycles field. Controllers which
>> expects dummy cycles won't work directly by using len field because
>> host driver doesn't know that len field of a particular transfer
>> includes dummy bytes or not (and also number of dummy bytes included
>> in len field). In such cases host driver use this dummy_cycles field
>> to identify the number of dummy cycles and based on that it will send
>> the required number of dummy cycles.
>
>Dummy cycles are only used with SPI NOR flashes, aren't they?

Yes, with SPI NOR flashes.

>I guess so since there is also a patch dedicated to the m25p80 driver.
>
>So why not using the spi_flash_read() API already introduced by Vignesh
>in the SPI layer?

ZynqMP GQSPI controller driver use "transfer_one" hook. Since this is generic
Controller majorly interfaced to flash devices and it might extend to NAND
flashes in future. This patch does not disturb the existing implementation of
accessing the flash or other slave devices. It adds an additional optional
feature. So there is no harm to controllers that don't need dummy cycles -
they can ignore it and still work with the existing implementation.

Regards
Sai Krishna
>
>struct spi_flash_read_message already includes a 'dummy_bytes' member.
>
>>
>> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
>> ---
>> v2:
>>  - Changed the structure member name from dummy to dummy_cycles.
>>  - Updated the documentation of dummy_cycles.
>>  - m25p80 changes split into another patch.
>>
>>  include/linux/spi/spi.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 857a9a1..63135b3 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -664,6 +664,9 @@ extern void spi_res_release(struct spi_master
>*master,
>>   * @len: size of rx and tx buffers (in bytes)
>>   * @speed_hz: Select a speed other than the device default for this
>>   *      transfer. If 0 the default (from @spi_device) is used.
>> + * @dummy_cycles: number of dummy cycles. If host controller requires
>> + *  dummy cycles rather than dummy bytes which send along with Cmd
>> + *  and address then this dummy_cycles is used.
>>   * @bits_per_word: select a bits_per_word other than the device default
>>   *      for this transfer. If 0 the default (from @spi_device) is used.
>>   * @cs_change: affects chipselect after this transfer completes
>> @@ -752,6 +755,7 @@ struct spi_transfer {
>>      u8              bits_per_word;
>>      u16             delay_usecs;
>>      u32             speed_hz;
>> +    u32             dummy_cycles;
>>
>>      struct list_head transfer_list;
>>  };
>>
>
>Best regards,
>
>Cyrille


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
