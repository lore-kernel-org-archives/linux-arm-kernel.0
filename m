From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Oct 2017 09:51:38 +0100
Subject: [PATCH 1/2] firmware: arm_scpi: drop unnecessary type cast to
 scpi_shared_mem
In-Reply-To: <54852f4b-78cc-061a-3c82-b753f289fee8@gmail.com>
References: <1507201911-27976-1-git-send-email-sudeep.holla@arm.com>
 <54852f4b-78cc-061a-3c82-b753f289fee8@gmail.com>
Message-ID: <2f742de8-3742-ef61-8d77-27adfbdce877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/17 20:06, Heiner Kallweit wrote:
> Am 05.10.2017 um 13:11 schrieb Sudeep Holla:
>> This patch drops the only present type cast of the SCPI payload pointer
>> to scpi_shared_mem inorder to align with other occurrences, IOW for
>> consistency.
>>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/arm_scpi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>> index c923d1ebfa3e..a888970f1347 100644
>> --- a/drivers/firmware/arm_scpi.c
>> +++ b/drivers/firmware/arm_scpi.c
>> @@ -453,7 +453,7 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>>  	unsigned long flags;
>>  	struct scpi_xfer *t = msg;
>>  	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
>> -	struct scpi_shared_mem *mem = (struct scpi_shared_mem *)ch->tx_payload;
>> +	struct scpi_shared_mem *mem = ch->tx_payload;
>>  
> This should work fine, however it might not be 100% clean with regard to __iomem
> annotation. ch->tx_payload is of type "void __iomem *" and I would assume that
> sparse complains about the new statement.

Yes sparse complains for both(with or without typecast)

> The old one casts away the __iomem, what isn't much better IMO.
> 

Agreed.

> By the way, I think this also applies to other places in this driver
> where ch->rx/tx_payload are used.
> 

Yes, but do you have any alternatives in your mind ? I am happy to hear
that.

-- 
Regards,
Sudeep
