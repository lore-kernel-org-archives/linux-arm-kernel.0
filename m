From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 30 Aug 2010 09:39:44 +1200
Subject: [PATCH 1/7] mmc: at91_mci: fix pointer errors
In-Reply-To: <20100827193303.GB23079@void.printf.net>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<20100827193303.GB23079@void.printf.net>
Message-ID: <4C7AD3A0.40607@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2010 07:33 AM, Chris Ball wrote:
> Hi Andrew, Nicolas,
> 
> On Fri, Feb 26, 2010 at 07:39:29PM +0100, Nicolas Ferre wrote:
>> From: Wolfgang Muees <wolfgang.mues@auerswald.de>
>>
>> Fixes two pointer errors, one which leads to memory overwrites if used with
>> large chunks of data.
>>
>> Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/mmc/host/at91_mci.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
>> index 63924e0..6835104 100644
>> --- a/drivers/mmc/host/at91_mci.c
>> +++ b/drivers/mmc/host/at91_mci.c
>> @@ -227,11 +227,13 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
>>  			for (index = 0; index < (amount / 4); index++)
>>  				*dmabuf++ = swab32(sgbuffer[index]);
>>  		} else {
>> -			memcpy(dmabuf, sgbuffer, amount);
>> -			dmabuf += amount;
>> +			char *tmpv = (char *)dmabuf;
>> +			memcpy(tmpv, sgbuffer, amount);
>> +			tmpv += amount;
>> +			dmabuf = (unsigned *)tmpv;

I see this is already applied, but why all the type trickery here? Why
not just:

	memcpy(dmabuf, sgbuffer, amount);
	dmabuf += amount / sizeof(dmabuf);

>>  		}
>>  
>> -		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
>> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);

void * arithmetic is a gcc-ism. Isn't it better to cast to char *, since
the meaning will be a bit more clear.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
