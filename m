From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Tue, 8 Dec 2015 01:33:18 +0100
Subject: [PATCH v5 08/11] spi: imx: allow only WML aligned transfers to
 use DMA
In-Reply-To: <20151207094224.GC11966@pengutronix.de>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1449334629-4715-9-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151207094224.GC11966@pengutronix.de>
Message-ID: <5666254E.2070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015-12-07 10:42, Sascha Hauer wrote:
> On Sat, Dec 05, 2015 at 05:57:06PM +0100, Anton Bondarenko wrote:
>> RX DMA tail data handling doesn't work correctly in many cases with current
>> implementation. It happens because SPI core was setup to generates both RX
>> and RX TAIL events. And RX TAIL event does not work correctly.
>> This can be easily verified by sending SPI transaction with size modulus
>> WML(32 in our case) not equal 0.
>>
>> Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
>> since this change only fix usecases with transfer size from 33 to 128 bytes
>> and does not fix 129 bytes etc.
>>
>> This is output from transaction with len 138 bytes in loopback mode at 10Mhz:
>> TX0000: a3 97 a2 55 53 be f1 fc f9 79 6b 52 14 13 e9 e2
>> TX0010: 2d 51 8e 1f 56 08 57 27 a7 05 d4 d0 52 82 77 75
>> TX0020: 1b 99 4a ed 58 3d 6a 52 36 d5 24 4a 68 8e ad 95
>> TX0030: 5f 3c 35 b5 c4 8c dd 6c 11 32 3d e2 b4 b4 59 cf
>> TX0040: ce 23 3d 27 df a7 f9 96 fc 1e e0 66 2c 0e 7b 8c
>> TX0050: ca 30 42 8f bc 9f 7b ce d1 b8 b1 87 ec 8a d6 bb
>> TX0060: 2e 15 63 0e 3c dc a4 3a 7a 06 20 a7 93 1b 34 dd
>> TX0070: 4c f5 ec 88 96 68 d6 68 a0 09 6f 8e 93 47 c9 41
>> TX0080: db ac cf 97 89 f3 51 05 79 71
>>
>> RX0000: a3 97 a2 55 53 be f1 fc f9 79 6b 52 14 13 e9 e2
>> RX0010: 2d 51 8e 1f 56 08 57 27 a7 05 d4 d0 52 82 77 75
>> RX0020: 1b 99 4a ed 58 3d 6a 52 36 d5 24 4a 68 8e ad 95
>> RX0030: 5f 3c 35 00 00 b5 00 00 00 c4 00 00 8c 00 00 dd
>> RX0040: 6c 11 32 3d e2 b4 b4 59 cf ce 23 3d 27 df a7 f9
>> RX0050: 96 fc 1e e0 66 2c 0e 7b 8c ca 30 42 8f 1f 1f bc
>> RX0060: 9f 7b ce d1 b8 b1 87 ec 8a d6 bb 2e 15 63 0e ed
>> RX0070: ed 3c 58 58 58 dc 3d 3d a4 6a 6a 3a 52 52 7a 36
>> RX0080: 06 20 a7 93 1b 34 dd 4c f5 ec
>>
>> Zeros at offset 33 and 34 caused by reading empty RX FIFO which not possible
>> if DMA RX read was triggered by RX event. This mean DMA was triggered
>> by RX TAIL event.
>>
>> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
>> ---
>>   drivers/spi/spi-imx.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index fa24637..7a68c62 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -204,8 +204,8 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   {
>>   	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
>>
>> -	if (spi_imx->dma_is_inited &&
>> -	    transfer->len > spi_imx->wml * sizeof(u32))
>> +	if (spi_imx->dma_is_inited && transfer->len > spi_imx->wml &&
>> +	    (transfer->len % spi_imx->wml) == 0)
>>   		return true;
>
> Must transfer->len really be bigger than spi_imx->wml? I would assume it
> should be >= instead. And where is the * sizeof(u32) gone? If that's
> unnecessary I heven't understood why.
>
> Sascha
>
>

Agree on '>='. Will be in V6.
As for missing sizeof(u32).
According to SoC specification it's possible to operate with 8- or 16 
bits word directly by setting proper value in word_width field in CFG 
register. I do not know the what exactly is fixed by f6ee9b582d, but I 
could suspect such scenario:
Some SPI client (spi-nor?) trying to perform SPI transaction with len 
mod 32 not equal zero. It could be any value between 33 and 127, 
excluding 64. But since DMA RX tail functionality does not work 
correctly RX contains some garbage.

But since this commit make can_dma more strict there is no need in old 
fix anymore.

I'll double check with oscilloscope to be sure SPI stream looks good.

Sascha, if you still thinks we need to have sizeof(32) please provide 
the use case or example so I can work on it.

BTW, we need to multiply WML by word size to correctly support 16- and 
32-bits words, but this is done in following commit.

Regards, Anton
