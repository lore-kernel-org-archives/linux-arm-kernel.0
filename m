From: absahu@codeaurora.org (Abhishek Sahu)
Date: Wed, 11 May 2016 23:13:58 +0530
Subject: [PATCH 2/2] i2c: qup: Fixed the DMA segments length
In-Reply-To: <000b01d1aba0$c2fea380$48fbea80$@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
 <000b01d1aba0$c2fea380$48fbea80$@codeaurora.org>
Message-ID: <699f798ccc0a7d36640cef42ac26a697@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-05-11 21:48, Sricharan wrote:
> Hi,
> 
>> 1. The current QCOM I2C driver code is failing for transfer length 
>> greater
>> than 255. This is happening due to improper segments length as the I2C 
>> DMA
>> segments can be maximum of 256 bytes.
>> 
>> 2. The transfer length tlen was being initialized with 0 for 256 
>> bytes,
>> which is
>> being passed for DMA mappings resulting in improper DMA mapping 
>> length.
>> 
>> This patch fixes the above said problems by initializing the block 
>> count
>> with
>> the values calculated in qup_i2c_set_blk_data and calculating the
> remaining
>> length for last DMA segment. Also, the block data length need to be
>> decremented after each transfer. Additionally, this patch corrects the
>> tlen
>> assignment for DMA mapping.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index
>> 8c2f1bc..6d6b7dc 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -651,23 +651,24 @@ static int qup_i2c_bam_do_xfer(struct
>> qup_i2c_dev *qup, struct i2c_msg *msg,
>>  	u8 *tags;
>> 
>>  	while (idx < num) {
>> -		blocks = (msg->len + limit) / limit;
>> -		rem = msg->len % limit;
>>  		tx_len = 0, len = 0, i = 0;
>> 
>>  		qup->is_last = (idx == (num - 1));
>> 
>>  		qup_i2c_set_blk_data(qup, msg);
>> 
>> +		blocks = qup->blk.count;
>> +		rem = msg->len - (blocks - 1) * limit;
>> +
>       Same if we had blocks = (msg->len + limit - 1) / limit instead of 
> the
> above ?
Yes. We calculating this inside qup_i2c_set_blk_data and assigning the 
same value to
qup->blk.count so I am using this to avoid redundant arithmetic 
operations.
>      Otherwise,
>      Reviewed-by: Sricharan at codeaurora.org
> 
> Regards,
>  Sricharan

-- 
Abhishek Sahu
