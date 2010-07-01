From: jason77.wang@gmail.com (jason)
Date: Fri, 02 Jul 2010 07:35:02 +0800
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI 	transfer
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C289CCB.7010409@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C2C82E9.2010103@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
Message-ID: <4C2D2626.4010809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

roman.tereshonkov at nokia.com wrote:
> Hi Jason,
>
> Your logs do not show what I wanted to see.
> But what I can see now at least is the case when TX is full and RX is full at the same time.
>
> 1.  Put 
> 	dev_dbg(&spi->dev, "status reg: %08x\n", __raw_readl(chstat_reg));
> 	after "do" and before "while (c)" in omap2_mcspi_txrx_pio function.
> 	I want to see how status is changed before and after TX or RX transaction.
> 2. Also try to make fake reading 
> 	__raw_readl(tx_reg)
> 	 after TX write in omap2_mcspi_txrx_pio.
> 	and 
> 	__raw_readl(cs->base + OMAP2_MCSPI_TX0);
> 	in mcspi_work function.
> 	This should exclude the posted write effect if such present.
>
> If you put more logging info from other spi registers it might be also usefull in problem analyzing.
> And it is better to concentrate on your test case 1. 
> So as it is the test which gives the bug with unknown yet nature.
>
>
>
> Regards
> Roman Tereshonkov
>
>   
OK.

Thanks,
Jason.
>> -----Original Message-----
>> From: ext jason [mailto:jason77.wang at gmail.com] 
>> Sent: 01 July, 2010 14:59
>> To: Tereshonkov Roman (Nokia-MS/Helsinki)
>> Cc: grant.likely at secretlab.ca; david-b at pacbell.net; 
>> spi-devel-general at lists.sourceforge.net; 
>> linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>> between each SPI transfer
>>
>> roman.tereshonkov at nokia.com wrote:
>>     
>>> Hi Jason,
>>>
>>> It is a little bit hard to analyze your logs.
>>> 1. You showed the bytes read in your own way but there is 
>>>       
>> the data reading in omap2_mcspi_txrx_pio function also.
>>     
>>> 2. For your third test case. You try to read data after 
>>>       
>> TX_ONLY, before triggering RX_ONLY, and get the right word.
>>     
>>> Looks like there is something wrong.
>>>
>>> Try to log MCSPI_CHxSTAT register to follow when RXS bit 
>>>       
>> (register RX is full) is set.
>>     
>>> And do not use the RX register reading in you own way. If 
>>>       
>> you need RX logging do it from omap2_mcspi_txrx_pio function.
>>     
>>> Regards
>>> Roman Tereshonkov
>>>
>>>
>>>   
>>>       
>> Hi roman,
>>
>> This time i enable SPI_DEBUG first then design 3 test cases to
>> investigate spi issue.
>> test 1: print tx data, status reg(when RXS bit set) and rx data in 
>> txrx_pio func.
>> test 2: revert the commit a330ce2 "omap2_mcspi: Flush posted writes",
>> other is same as test 1.
>> test 3: disable and enable channel between each SPI transfer, other is
>> same as test 1.
>>
>> The output of test2 and test3 is same and is right, while 
>> test1's output is
>> wrong.
>>
>> The ads7846 driver works like that, when i touch the top-left 
>> corner of the
>> touchscreen, it will send a READ-Y command first(8 bit word 0x93,
>> TX_ONLY transfer), then it will receive y coordinate(two 8 bit 
>> words, MSB
>> 12bits are meaningful, correct data should be around 0x77nn, RX_ONLY 
>> transfer).
>>
>> the output of test1 is:
>> <4>======SPI MESSAGE BEGIN======
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000005
>> <7>ads7846 spi1.0: read-8 f0
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000005
>> <7>ads7846 spi1.0: read-8 f0
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <4>.....SPI MESSAGE END.....
>>
>> the output of test2 is:
>> <4>======SPI MESSAGE BEGIN======
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 b0
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 88
>> <4>.....SPI MESSAGE END.....
>>
>> the output of test3 is:
>> <4>======SPI MESSAGE BEGIN======
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 68
>> <7>ads7846 spi1.0: write-8 93
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 77
>> <7>ads7846 spi1.0: status reg: 00000007
>> <7>ads7846 spi1.0: read-8 98
>> <4>.....SPI MESSAGE END.....
>>
>>
>> test1 patch:
>> Subject: [PATCH] SPI/test1: print tx data & rx data when ads7846 works
>>
>> when we touch the top-left corner of the touchscreen, the ads7846
>> driver will send a read-y command(one 8-bit word, 0x93) and receive
>> y coordinate(two 8-bit words, MSB 12bits are meaningful). now print
>> all tx word, staus reg and rx word when RXS bit is set. Test1 only
>> add debug output and have no other modification.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 11 +++++++++--
>> 1 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..893a124 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -40,6 +40,8 @@
>> #include <plat/clock.h>
>> #include <plat/mcspi.h>
>>
>> +#define VERBOSE
>> +
>> #define OMAP2_MCSPI_MAX_FREQ 48000000
>>
>> /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
>> @@ -502,6 +504,11 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> goto out;
>> }
>>
>> +#ifdef VERBOSE
>> + dev_dbg(&spi->dev, "status reg: %08x\n",
>> + __raw_readl(chstat_reg));
>> +#endif
>> +
>> if (c == 1 && tx == NULL &&
>> (l & OMAP2_MCSPI_CHCONF_TURBO)) {
>> omap2_mcspi_set_enable(spi, 0);
>> @@ -893,7 +900,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> + printk("======SPI MESSAGE BEGIN======\n");
>> omap2_mcspi_set_enable(spi, 1);
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> @@ -971,7 +978,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk(".....SPI MESSAGE END.....\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>> test2 patch:
>> Subject: [PATCH] SPI/test2: print tx data & rx data when ads7846 works
>>
>> when we touch the top-left corner of the touchscreen, the ads7846
>> driver will send a read-y command(one 8-bit word, 0x93) and receive
>> y coordinate(two 8-bit words, MSB 12bits are meaningful). now print
>> all tx word and rx word. In test2, i revert the commit a330ce2
>> "omap2_mcspi: Flush posted writes".
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 13 ++++++++++---
>> 1 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..cf8066e 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -40,6 +40,8 @@
>> #include <plat/clock.h>
>> #include <plat/mcspi.h>
>>
>> +#define VERBOSE
>> +
>> #define OMAP2_MCSPI_MAX_FREQ 48000000
>>
>> /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
>> @@ -204,7 +206,7 @@ static inline void 
>> mcspi_write_chconf0(const struct 
>> spi_device *spi, u32 val)
>>
>> cs->chconf0 = val;
>> mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
>> - mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>> + /* mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0); */
>> }
>>
>> static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
>> @@ -502,6 +504,11 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> goto out;
>> }
>>
>> +#ifdef VERBOSE
>> + dev_dbg(&spi->dev, "status reg: %08x\n",
>> + __raw_readl(chstat_reg));
>> +#endif
>> +
>> if (c == 1 && tx == NULL &&
>> (l & OMAP2_MCSPI_CHCONF_TURBO)) {
>> omap2_mcspi_set_enable(spi, 0);
>> @@ -893,7 +900,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> + printk("======SPI MESSAGE BEGIN======\n");
>> omap2_mcspi_set_enable(spi, 1);
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> @@ -971,7 +978,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk(".....SPI MESSAGE END.....\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>> test3 patch:
>> Subject: [PATCH] SPI/test3: print tx data & rx data when ads7846 works
>>
>> when we touch the top-left corner of the touchscreen, the ads7846
>> driver will send a read-y command(one 8-bit word, 0x93) and receive
>> y coordinate(two 8-bit words, MSB 12bits are meaningful). now print
>> all tx word and rx word. In test3, i add disable channel and reenable
>> channel between each SPI transfer.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 21 +++++++++++++++------
>> 1 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..7449365 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -40,6 +40,8 @@
>> #include <plat/clock.h>
>> #include <plat/mcspi.h>
>>
>> +#define VERBOSE
>> +
>> #define OMAP2_MCSPI_MAX_FREQ 48000000
>>
>> /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
>> @@ -408,7 +410,6 @@ omap2_mcspi_txrx_dma(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> count -= (word_len <= 8) ? 2 :
>> (word_len <= 16) ? 4 :
>> /* word_len <= 32 */ 8;
>> - omap2_mcspi_set_enable(spi, 1);
>> return count;
>> }
>> }
>> @@ -430,8 +431,10 @@ omap2_mcspi_txrx_dma(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> (word_len <= 16) ? 2 :
>> /* word_len <= 32 */ 4;
>> }
>> - omap2_mcspi_set_enable(spi, 1);
>> }
>> +
>> + omap2_mcspi_set_enable(spi, 0);
>> +
>> return count;
>> }
>>
>> @@ -502,6 +505,11 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> goto out;
>> }
>>
>> +#ifdef VERBOSE
>> + dev_dbg(&spi->dev, "status reg: %08x\n",
>> + __raw_readl(chstat_reg));
>> +#endif
>> +
>> if (c == 1 && tx == NULL &&
>> (l & OMAP2_MCSPI_CHCONF_TURBO)) {
>> omap2_mcspi_set_enable(spi, 0);
>> @@ -646,7 +654,7 @@ omap2_mcspi_txrx_pio(struct spi_device 
>> *spi, struct 
>> spi_transfer *xfer)
>> dev_err(&spi->dev, "EOT timed out\n");
>> }
>> out:
>> - omap2_mcspi_set_enable(spi, 1);
>> + omap2_mcspi_set_enable(spi, 0);
>> return count - c;
>> }
>>
>> @@ -893,8 +901,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> - omap2_mcspi_set_enable(spi, 1);
>> + printk("======SPI MESSAGE BEGIN======\n");
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> status = -EINVAL;
>> @@ -931,6 +938,8 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>>
>> mcspi_write_chconf0(spi, chconf);
>>
>> + omap2_mcspi_set_enable(spi, 1);
>> +
>> if (t->len) {
>> unsigned count;
>>
>> @@ -971,7 +980,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk(".....SPI MESSAGE END.....\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>>
>>     
