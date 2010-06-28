From: roman.tereshonkov@nokia.com (roman.tereshonkov at nokia.com)
Date: Mon, 28 Jun 2010 11:12:39 +0200
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI 	transfer
In-Reply-To: <4C24A182.4060009@gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
Message-ID: <E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: ext jason [mailto:jason77.wang at gmail.com] 
>Sent: 25 June, 2010 15:31
>To: Grant Likely
>Cc: Tereshonkov Roman (Nokia-D/Helsinki); david-b at pacbell.net; 
>spi-devel-general at lists.sourceforge.net; 
>linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>between each SPI transfer
>
>Grant Likely wrote:
>> On Thu, Jun 24, 2010 at 6:12 AM, Jason Wang 
><jason77.wang@gmail.com> wrote:
>>   
>>> In current design, the SPI channel is always enable during 
>the period
>>> of handling a SPI message, it is risky when more than one 
>SPI transfer
>>> are included in a message. Current working route like that:
>>> [
>>>  SPI channel enable
>>>  configure channel
>>>  handle transfer #1
>>>  configure channel
>>>  handle transfer #2
>>>  ...
>>>  SPI channel disable
>>> ]
>>> If we can disable channel before configure it and reenable
>>> channel after it is configured, it will be more safe.
>>>
>>> The commit a330ce2 "omap2_mcspi: Flush posted writes" make this risk
>>> to a real problem for ads7846 driver on omap3530evm. The
>>> ads7846 driver will send a SPI messge which includes,
>>> [
>>>  TX_ONLY transfer (1 byte)
>>>  RX_ONLY transfer (2 bytes)
>>>  TX_ONLY transfer (1 byte)
>>>  RX_ONLY transfer (2 bytes)
>>> ]
>>> If we don't add disable/reenable channel between TX and RX 
>transfers,
>>> the RX transfer will get wrong datas sent from slave.
>>>     
>>
>> I don't understand the problem description.  Are you talking about
>> manipulation of the SS line, or a problem with the internal state on
>> the mcspi controller device?  What is the cause of the wrong 
>data (ie.
>> is there a protocol error on the wire, or is the SPI controller not
>> performing the read correctly?)
>>
>> Thanks,
>> g.
>>
>>   
>Sorry for unclear description.  The problem is like that, when 
>a TX_ONLY 
>transfer is
>followed by a RX_ONLY transfer, the first data received in RX_ONLY 
>transfer will be
>the last data(random data) which is received in TX_ONLY 
>transfer instead 
>of a meaningful data.
>
>Thing like following logic,
>In TX_ONLY transfer:
>write data1(trigger transmit), (will receive a data 
>simultaneously, and 
>keep it in RX register)
>...
>write dataN(last data), (will receive the last random data and keep it 
>in RX register)
>in the following RX_ONLY transfer:
>change SPI controller to RX_ONLY mode,
>the RXS bit will be set to status register immediately,
>write a dummy data to TX register to trigger this session(in 
>fact this  
>trigger  doesn't take  effect),
>check the RXS bit and read the first data(the first data is the last 
>random data received in TX_ONLY transfer).
>

For me it is very strange that you have RXS bit set after TX_ONLY transmission.
The problem might be elsewhere and your solution will just mask the real problem.
Can you enable the spi debug and error logs and show them for your broken case.

Regards
Roman Tereshonkov

>
>But if we disable this channel after the TX_ONLY  transfer and 
>reenable 
>it  before  the RX_ONLY  transfer,
>the trigger action will take effect and a meaningful data  will be  
>transfered to RX register.
>
>Thanks,
>Jason.
>
>>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>>> ---
>>>  drivers/spi/omap2_mcspi.c |   16 ++++++----------
>>>  1 files changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>>>     
>[snip]
>
