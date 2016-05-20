From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 20 May 2016 14:01:17 +0530
Subject: [PATCH v2 2/2] i2c: qup: support SMBus block read
In-Reply-To: <757c18e2-562a-9f43-0fb6-ab3e7ac3af88@codeaurora.org>
References: <1463006736-24652-1-git-send-email-nkaje@codeaurora.org>
 <1463006736-24652-2-git-send-email-nkaje@codeaurora.org>
 <000d01d1b0d3$d70e1f30$852a5d90$@codeaurora.org>
 <757c18e2-562a-9f43-0fb6-ab3e7ac3af88@codeaurora.org>
Message-ID: <000501d1b271$fef3bc90$fcdb35b0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip..>
>>> @@ -1128,6 +1173,22 @@ static int qup_i2c_read_one_v2(struct
>>> qup_i2c_dev *qup, struct i2c_msg *msg)
>>>   			goto err;
>>>
>>>   		qup->blk.pos++;
>>> +
>>> +		/* Handle SMBus block read length */
>>> +		if (qup_i2c_check_msg_len(msg) && (msg->len == 1)) {
>>> +			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
>>> +				ret = -EPROTO;
>>> +				goto err;
>>> +			}
>>> +			msg->len += msg->buf[0];
>>> +			qup->pos = 0;
>>> +			qup_i2c_set_read_mode_v2(qup, msg->len);
>>> +			qup_i2c_issue_xfer_v2(qup, msg);
>>> +			ret = qup_i2c_wait_for_complete(qup, msg);
>>> +			if (ret)
>>> +				goto err;
>> 		Is the issue_xfer_v2 needed inside this here ?
>No, qup_i2c_issue_xfer_v2 is needed so that we read rest of the data
>that is indicated by the length we read earlier.

So qup_i2c_issue_xfer_v2 writes the tags and there is one already in the loop above this
 check. So if you just do qup_i2c_set_read_mode_v2 and qup_i2c_set_blk_data inside this
 check, will not be enough ?

Regards,
 Sricharan
