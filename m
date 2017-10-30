From: ludovic.barre@st.com (Ludovic BARRE)
Date: Mon, 30 Oct 2017 09:05:03 +0100
Subject: [PATCH v2 1/3] mtd: spi-nor: stm32-quadspi: Fix uninitialized
 error return code
In-Reply-To: <ed1ca205-830e-3f5b-e251-8d863a512eda@wedev4u.fr>
References: <1509030755-19044-1-git-send-email-ludovic.Barre@st.com>
 <1509030755-19044-2-git-send-email-ludovic.Barre@st.com>
 <ed1ca205-830e-3f5b-e251-8d863a512eda@wedev4u.fr>
Message-ID: <3dc4ff33-77a3-be2e-c20f-675b800dca2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks Cyrille

indeed, the "Signed-off" on Geert'commit was a mistake

BR
Ludo
On 10/29/2017 06:50 PM, Cyrille Pitchen wrote:
> Hi Ludovic,
> 
> Le 26/10/2017 ? 17:12, Ludovic Barre a ?crit?:
>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> With gcc 4.1.2:
>>
>>      drivers/mtd/spi-nor/stm32-quadspi.c: In function ?stm32_qspi_tx_poll?:
>>      drivers/mtd/spi-nor/stm32-quadspi.c:230: warning: ?ret? may be used uninitialized in this function
>>
>> Indeed, if stm32_qspi_cmd.len is zero, ret will be uninitialized.
>> This length is passed from outside the driver using the
>> spi_nor.{read,write}{,_reg}() callbacks.
>>
>> Several functions in drivers/mtd/spi-nor/spi-nor.c (e.g. write_enable(),
>> write_disable(), and erase_chip()) call spi_nor.write_reg() with a zero
>> length.
>>
>> Fix this by returning an explicit zero on success.
>>
>> Fixes: 0d43d7ab277a048c ("mtd: spi-nor: add driver for STM32 quad spi flash controller")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: Ludovic Barre <ludovic.barre@st.com>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> I removed your "Signed-off" because I think this is a mistake but kept
> your "Acked-by" tag.
> 
> Applied to the spi-nor/next branch of l2-mtd.
> 
> Thanks!
> 
>> ---
>>   drivers/mtd/spi-nor/stm32-quadspi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
>> index 86c0931..ad6a3e1 100644
>> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
>> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
>> @@ -240,12 +240,12 @@ static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
>>   						 STM32_QSPI_FIFO_TIMEOUT_US);
>>   		if (ret) {
>>   			dev_err(qspi->dev, "fifo timeout (stat:%#x)\n", sr);
>> -			break;
>> +			return ret;
>>   		}
>>   		tx_fifo(buf++, qspi->io_base + QUADSPI_DR);
>>   	}
>>   
>> -	return ret;
>> +	return 0;
>>   }
>>   
>>   static int stm32_qspi_tx_mm(struct stm32_qspi *qspi,
>>
> 
