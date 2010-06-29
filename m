From: jason77.wang@gmail.com (jason)
Date: Tue, 29 Jun 2010 21:17:27 +0800
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI 	transfer
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C289CCB.7010409@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
Message-ID: <4C29F267.9030007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

roman.tereshonkov at nokia.com wrote:
> Hi Jason,
>
> It is a little bit hard to analyze your logs.
> 1. You showed the bytes read in your own way but there is the data reading in omap2_mcspi_txrx_pio function also.
>   
I add polling RXS bit and read rx register after TX_ONLY and before 
triggering RX_ONLY just to prove
this triggering is not necessary(test case1).
> 2. For your third test case. You try to read data after TX_ONLY, before triggering RX_ONLY, and get the right word.
> Looks like there is something wrong.
>   
My 2nd test case is to read data after TX_ONLY and after triggering 
RX_ONLY, get wrong word just as
test case 1.
My 3rd test case revert a commit at first, then to read data after 
TX_ONLY and after triggering RX_ONLY,
this time get right word, the difference between case 3 and case 2 is 
only reverting a commit.
> Try to log MCSPI_CHxSTAT register to follow when RXS bit (register RX is full) is set.
> And do not use the RX register reading in you own way. If you need RX logging do it from omap2_mcspi_txrx_pio function.
>
>   
OK, i will try to generate a log as your suggestion.

Thanks,
Jason.
> Regards
> Roman Tereshonkov
>
>
>   
>> -----Original Message-----
>> From: ext jason [mailto:jason77.wang at gmail.com] 
>> Sent: 28 June, 2010 16:00
>> To: Tereshonkov Roman (Nokia-D/Helsinki)
>> Cc: grant.likely at secretlab.ca; david-b at pacbell.net; 
>> spi-devel-general at lists.sourceforge.net; 
>> linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>> between each SPI transfer
>>
>> roman.tereshonkov at nokia.com wrote:
>>     
>>>  
>>>
>>>   
>>>       
>>>> -----Original Message-----
>>>> From: ext jason [mailto:jason77.wang at gmail.com] 
>>>> Sent: 25 June, 2010 15:31
>>>> To: Grant Likely
>>>> Cc: Tereshonkov Roman (Nokia-D/Helsinki); david-b at pacbell.net; 
>>>>     
>>>>     
>>>>         
>> [snip]
>>     
>>>> the RXS bit will be set to status register immediately,
>>>> write a dummy data to TX register to trigger this session(in 
>>>> fact this  
>>>> trigger  doesn't take  effect),
>>>> check the RXS bit and read the first data(the first data is 
>>>>         
>> the last 
>>     
>>>> random data received in TX_ONLY transfer).
>>>>
>>>>     
>>>>         
>>> For me it is very strange that you have RXS bit set after 
>>>       
>> TX_ONLY transmission.
>>     
>>> The problem might be elsewhere and your solution will just 
>>>       
>> mask the real problem.
>>     
>>> Can you enable the spi debug and error logs and show them 
>>>       
>> for your broken case.
>>     
>>> Regards
>>> Roman Tereshonkov
>>>
>>>   
>>>       
>> Hi Roman,
>> I don't know how to enable the spi debug and generate an error 
>> log, but 
>> i design
>> 3 testcases to investigate this issue. These 3 testcases are based off 
>> the latest upstream.
>> test1: After TX_ONLY transfer, we will change this channel to RX_ONLY 
>> mode. And then we
>> will write a dummy data to trigger this RX transaction, here i add a 
>> polling RXS bit
>> before write triggering data, from the result, we can see we 
>> successfully to get a RXS
>> bit and read an unmeaningful data.(this prove the write 
>> triggering data 
>> is not necessary
>> to start a rx transaction).
>> test2: This time i move the polling RXS bit to the location after the 
>> write trigger data, we can get
>> RXS bit as well and read an unmeaningful data too. The data 
>> read out is 
>> identical to the one
>> in test1.(This prove the write trigger data don't take effect in fact).
>> test3: Except i revert the commit a330ce2 "omap2_mcspi: Flush posted 
>> writes", other is same as the test2.
>> But this time, we read out a correct data ads7846 sending out. 
>> (I don't 
>> know why this commit can
>> affect the result, maybe it is time issue. If we can disable this 
>> channel after TX_ONLY transfer and
>> reenable it before RX_ONLY transfer, we will not get RXS bit in test1, 
>> and will read out a correct data
>> both in test2 and test3).
>>
>> Test1 result output & patch:
>> # =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> *****SPI MESSAGE END*****
>> =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> *****SPI MESSAGE END*****
>>
>>
>> Subject: [PATCH] SPI/test1: get rx_data in RX_ONLY transfer before 
>> trigger writing
>>
>> get rx_data in RX_ONLY transfer before trigger writing dummy data to
>> TX register.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 19 ++++++++++++++-----
>> 1 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..ddfe4b0 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -893,7 +893,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> + printk("=====SPI MESSAGE BEGIN=====\n");
>> omap2_mcspi_set_enable(spi, 1);
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> @@ -928,17 +928,26 @@ static void omap2_mcspi_work(struct work_struct 
>> *work)
>> if (t->len > ((cs->word_len + 7) >> 3))
>> chconf |= OMAP2_MCSPI_CHCONF_TURBO;
>> }
>> -
>> + printk("tansfer%s: conf=%x, data=%x\n", t->tx_buf ? "TX" : "RX",
>> + chconf, t->tx_buf ? *(u8 *)(t->tx_buf) : 0);
>> mcspi_write_chconf0(spi, chconf);
>>
>> if (t->len) {
>> unsigned count;
>>
>> /* RX_ONLY mode needs dummy data in TX reg */
>> - if (t->tx_buf == NULL)
>> + if (t->tx_buf == NULL) {
>> + u8 rx_data;
>> + if (mcspi_wait_for_reg_bit(cs->base + OMAP2_MCSPI_CHSTAT0,
>> + OMAP2_MCSPI_CHSTAT_RXS) < 0)
>> + dev_err(&spi->dev, "RXS timed out\n");
>> +
>> + rx_data = __raw_readl(cs->base + OMAP2_MCSPI_RX0);
>> + printk("rx_data = %x\n", rx_data);
>> +
>> __raw_writel(0, cs->base
>> + OMAP2_MCSPI_TX0);
>> -
>> + }
>> if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
>> count = omap2_mcspi_txrx_dma(spi, t);
>> else
>> @@ -971,7 +980,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk("*****SPI MESSAGE END*****\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>> Test2 result output & patch:
>> # =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> *****SPI MESSAGE END*****
>> =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = f0
>> *****SPI MESSAGE END*****
>>
>> Subject: [PATCH] SPI/test2: get rx_data in RX_ONLY transfer after 
>> trigger writing
>>
>> get rx_data in RX_ONLY transfer after trigger writing dummy data to
>> TX register.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 18 ++++++++++++++----
>> 1 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..96c508a 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -893,7 +893,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> + printk("=====SPI MESSAGE BEGIN=====\n");
>> omap2_mcspi_set_enable(spi, 1);
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> @@ -928,17 +928,27 @@ static void omap2_mcspi_work(struct work_struct 
>> *work)
>> if (t->len > ((cs->word_len + 7) >> 3))
>> chconf |= OMAP2_MCSPI_CHCONF_TURBO;
>> }
>> -
>> + printk("tansfer%s: conf=%x, data=%x\n", t->tx_buf ? "TX" : "RX",
>> + chconf, t->tx_buf ? *(u8 *)(t->tx_buf) : 0);
>> mcspi_write_chconf0(spi, chconf);
>>
>> if (t->len) {
>> unsigned count;
>>
>> /* RX_ONLY mode needs dummy data in TX reg */
>> - if (t->tx_buf == NULL)
>> + if (t->tx_buf == NULL) {
>> + u8 rx_data;
>> __raw_writel(0, cs->base
>> + OMAP2_MCSPI_TX0);
>>
>> + if (mcspi_wait_for_reg_bit(cs->base + OMAP2_MCSPI_CHSTAT0,
>> + OMAP2_MCSPI_CHSTAT_RXS) < 0)
>> + dev_err(&spi->dev, "RXS timed out\n");
>> +
>> + rx_data = __raw_readl(cs->base + OMAP2_MCSPI_RX0);
>> + printk("rx_data = %x\n", rx_data);
>> +
>> + }
>> if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
>> count = omap2_mcspi_txrx_dma(spi, t);
>> else
>> @@ -971,7 +981,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk("*****SPI MESSAGE END*****\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>> Test3 result output & patch:
>> # =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = 77
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = 76
>> *****SPI MESSAGE END*****
>> =====SPI MESSAGE BEGIN=====
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = 75
>> tansferTX: conf=1123d4, data=93
>> tansferRX: conf=1113d4, data=0
>> rx_data = 74
>> *****SPI MESSAGE END*****
>>
>> Subject: [PATCH] SPI/test3: get rx_data in RX_ONLY transfer after 
>> trigger writing
>>
>> At frist revert the commit a330ce2 "omap2_mcspi: Flush posted writes",
>> then get rx_data in RX_ONLY transfer after trigger writing dummy data
>> to TX register.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 19 ++++++++++++++-----
>> 1 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index b3a94ca..5d71cad 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -204,7 +204,6 @@ static inline void 
>> mcspi_write_chconf0(const struct 
>> spi_device *spi, u32 val)
>>
>> cs->chconf0 = val;
>> mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
>> - mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
>> }
>>
>> static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
>> @@ -893,7 +892,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> spi = m->spi;
>> cs = spi->controller_state;
>> cd = spi->controller_data;
>> -
>> + printk("=====SPI MESSAGE BEGIN=====\n");
>> omap2_mcspi_set_enable(spi, 1);
>> list_for_each_entry(t, &m->transfers, transfer_list) {
>> if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
>> @@ -928,17 +927,27 @@ static void omap2_mcspi_work(struct work_struct 
>> *work)
>> if (t->len > ((cs->word_len + 7) >> 3))
>> chconf |= OMAP2_MCSPI_CHCONF_TURBO;
>> }
>> -
>> + printk("tansfer%s: conf=%x, data=%x\n", t->tx_buf ? "TX" : "RX",
>> + chconf, t->tx_buf ? *(u8 *)(t->tx_buf) : 0);
>> mcspi_write_chconf0(spi, chconf);
>>
>> if (t->len) {
>> unsigned count;
>>
>> /* RX_ONLY mode needs dummy data in TX reg */
>> - if (t->tx_buf == NULL)
>> + if (t->tx_buf == NULL) {
>> + u8 rx_data;
>> __raw_writel(0, cs->base
>> + OMAP2_MCSPI_TX0);
>>
>> + if (mcspi_wait_for_reg_bit(cs->base + OMAP2_MCSPI_CHSTAT0,
>> + OMAP2_MCSPI_CHSTAT_RXS) < 0)
>> + dev_err(&spi->dev, "RXS timed out\n");
>> +
>> + rx_data = __raw_readl(cs->base + OMAP2_MCSPI_RX0);
>> + printk("rx_data = %x\n", rx_data);
>> +
>> + }
>> if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
>> count = omap2_mcspi_txrx_dma(spi, t);
>> else
>> @@ -971,7 +980,7 @@ static void omap2_mcspi_work(struct 
>> work_struct *work)
>> omap2_mcspi_force_cs(spi, 0);
>>
>> omap2_mcspi_set_enable(spi, 0);
>> -
>> + printk("*****SPI MESSAGE END*****\n");
>> m->status = status;
>> m->complete(m->context);
>>
>> -- 
>> 1.5.6.5
>>
>>
>>
>>
>>
>>
>>     
>>>> But if we disable this channel after the TX_ONLY  transfer and 
>>>> reenable 
>>>> it  before  the RX_ONLY  transfer,
>>>> the trigger action will take effect and a meaningful data  will be  
>>>> transfered to RX register.
>>>>
>>>> Thanks,
>>>> Jason.
>>>>
>>>>     
>>>>         
>>>>>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>>>>>> ---
>>>>>>  drivers/spi/omap2_mcspi.c |   16 ++++++----------
>>>>>>  1 files changed, 6 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>>>>>>     
>>>>>>         
>>>>>>             
>>>> [snip]
>>>>
>>>>     
>>>>         
>>     
