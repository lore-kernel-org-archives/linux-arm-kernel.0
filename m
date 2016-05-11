From: nkaje@codeaurora.org (Naveen Kaje)
Date: Wed, 11 May 2016 16:11:09 -0600
Subject: [PATCH 2/2] i2c: qup: support SMBus block read
In-Reply-To: <000b01d1aa8b$7317a300$5946e900$@codeaurora.org>
References: <1462317959-11632-1-git-send-email-nkaje@codeaurora.org>
 <1462317959-11632-2-git-send-email-nkaje@codeaurora.org>
 <000b01d1aa8b$7317a300$5946e900$@codeaurora.org>
Message-ID: <5298a5a9-77cf-ca51-8146-044c75498128@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/10/2016 1:13 AM, Sricharan wrote:
> +additional lists
>
>> I2C QUP driver relies on SMBus emulation support from the framework.
>> To handle SMBus block reads, the driver should check I2C_M_RECV_LEN flag
>> and should read the first byte received as the message length.
>>
>> The driver configures the QUP hardware to read one byte. Once the message
>> length is known from this byte, the QUP hardware is configured to read the
>> rest.
>>
>> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
>> ---
>>   drivers/i2c/busses/i2c-qup.c | 95 ++++++++++++++++++++++++++++++-------
>> -------
>>   1 file changed, 66 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index
>> ef31b26..2658b67 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -526,38 +526,49 @@ static int qup_i2c_set_tags(u8 *tags, struct
>> qup_i2c_dev *qup,
>>
>>   	int last = (qup->blk.pos == (qup->blk.count - 1)) && (qup->is_last);
>>
>> -	if (qup->blk.pos == 0) {
>> -		tags[len++] = QUP_TAG_V2_START;
>> -		tags[len++] = addr & 0xff;
>> +	/* Handle SMBus block data read */
>> +	if ((msg->flags & I2C_M_RD) && (msg->flags & I2C_M_RECV_LEN)
>> &&
>> +	    (msg->len > 1)) {
>> +		tags[len++] = QUP_TAG_V2_DATARD_STOP;
>> +		data_len = qup_i2c_get_data_len(qup);
>> +		tags[len++] = data_len - 1;
>> +	} else {
>> +		if (qup->blk.pos == 0) {
>> +			tags[len++] = QUP_TAG_V2_START;
>> +			tags[len++] = addr & 0xff;
>>
>> -		if (msg->flags & I2C_M_TEN)
>> -			tags[len++] = addr >> 8;
>> -	}
>> +			if (msg->flags & I2C_M_TEN)
>> +				tags[len++] = addr >> 8;
>> +		}
>>
>> -	/* Send _STOP commands for the last block */
>> -	if (last) {
>> -		if (msg->flags & I2C_M_RD)
>> -			tags[len++] = QUP_TAG_V2_DATARD_STOP;
>> -		else
>> -			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
>> -	} else {
>> -		if (msg->flags & I2C_M_RD)
>> +		/* Send _STOP commands for the last block */
>> +		if ((msg->flags & I2C_M_RD)
>> +			&& (msg->flags & I2C_M_RECV_LEN)) {
>>   			tags[len++] = QUP_TAG_V2_DATARD;
>> -		else
>> -			tags[len++] = QUP_TAG_V2_DATAWR;
>> -	}
>> +		} else if (last) {
>> +			if (msg->flags & I2C_M_RD)
>> +				tags[len++] = QUP_TAG_V2_DATARD_STOP;
>> +			else
>> +				tags[len++] = QUP_TAG_V2_DATAWR_STOP;
>> +		} else {
>> +			if (msg->flags & I2C_M_RD)
>> +				tags[len++] = QUP_TAG_V2_DATARD;
>> +			else
>> +				tags[len++] = QUP_TAG_V2_DATAWR;
>> +		}
>>
>> -	data_len = qup_i2c_get_data_len(qup);
>> +		data_len = qup_i2c_get_data_len(qup);
>>
>> -	/* 0 implies 256 bytes */
>> -	if (data_len == QUP_READ_LIMIT)
>> -		tags[len++] = 0;
>> -	else
>> -		tags[len++] = data_len;
>> +		/* 0 implies 256 bytes */
>> +		if (data_len == QUP_READ_LIMIT)
>> +			tags[len++] = 0;
>> +		else
>> +			tags[len++] = data_len;
>>
>> -	if ((msg->flags & I2C_M_RD) && last && is_dma) {
>> -		tags[len++] = QUP_BAM_INPUT_EOT;
>> -		tags[len++] = QUP_BAM_FLUSH_STOP;
>> +		if ((msg->flags & I2C_M_RD) && last && is_dma) {
>> +			tags[len++] = QUP_BAM_INPUT_EOT;
>> +			tags[len++] = QUP_BAM_FLUSH_STOP;
>> +		}
>>   	}
>>
>     Will it look simpler if we add a qup_i2c_set_tags_smb instead and add an
>     Comment ? Here it is not clear how this is different from a normal read.
Will rework this and send V2.
> <snip..>
>
>> +
>> +		/* Handle SMBus block read length */
>> +		if ((msg->flags & I2C_M_RECV_LEN) && (msg->len == 1)) {
>> +			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
>> +				ret = -EPROTO;
>> +				goto err;
>> +			}
>> +			msg->len += msg->buf[0];
>> +			qup->pos = 0;
>> +			qup_i2c_set_read_mode_v2(qup, msg->len);
>> +			qup_i2c_issue_xfer_v2(qup, msg);
>> +			ret = qup_i2c_wait_for_complete(qup, msg);
>> +			if (ret)
>> +				goto err;
>> +			qup_i2c_set_blk_data(qup, msg);
>> +		}
>>   	} while (qup->blk.pos < qup->blk.count);
>         
>           When v2 mode is not supported this should return an error,
>           in qup_i2c_xfer for msg->flags & I2C_M_RECV_LEN
Will add a check in qup_i2c_xfer in the next version of the patch.
>
> Regards,
>   Sricharan
>
