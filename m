From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 18 May 2016 12:36:35 +0530
Subject: [PATCH v2 2/2] i2c: qup: support SMBus block read
In-Reply-To: <1463006736-24652-2-git-send-email-nkaje@codeaurora.org>
References: <1463006736-24652-1-git-send-email-nkaje@codeaurora.org>
 <1463006736-24652-2-git-send-email-nkaje@codeaurora.org>
Message-ID: <000d01d1b0d3$d70e1f30$852a5d90$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip..>

> +static bool qup_i2c_check_msg_len(struct i2c_msg *msg) {
> +	return ((msg->flags & I2C_M_RD) && (msg->flags &
> I2C_M_RECV_LEN)); }
> +
> +static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev
> *qup,
> +			struct i2c_msg *msg)
> +{
> +	int len = 0;
> +	int data_len = qup_i2c_get_data_len(qup);
> +
> +	if (msg->len > 1) {
> +		tags[len++] = QUP_TAG_V2_DATARD_STOP;
> +		tags[len++] = data_len - 1;
> +	} else {
    So we hit this else part for msg->len = 1 and this case blk.pos = 0
    will always be true right ?

> +		if (qup->blk.pos == 0) {
> +			tags[len++] = QUP_TAG_V2_START;
> +			tags[len++] = addr & 0xff;
> +
> +			if (msg->flags & I2C_M_TEN)
> +				tags[len++] = addr >> 8;
> +		}
> +
> +		tags[len++] = QUP_TAG_V2_DATARD;
> +		/* 0 implies 256 bytes */
> +		if (data_len == QUP_READ_LIMIT)
> +			tags[len++] = 0;
> +		else
> +			tags[len++] = data_len;
> +	}
       Even data_len will always be '1' right ?
> +	return len;
> +}
> +
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>  			    struct i2c_msg *msg,  int is_dma)  { @@ -526,6
> +559,10 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
> 
>  	int last = (qup->blk.pos == (qup->blk.count - 1)) && (qup->is_last);
> 
> +	/* Handle tags for SMBus block read */
> +	if (qup_i2c_check_msg_len(msg))
> +		return qup_i2c_set_tags_smb(addr, tags, qup, msg);
> +
>  	if (qup->blk.pos == 0) {
>  		tags[len++] = QUP_TAG_V2_START;
>  		tags[len++] = addr & 0xff;
> @@ -1065,9 +1102,17 @@ static int qup_i2c_read_fifo_v2(struct
> qup_i2c_dev *qup,
>  				struct i2c_msg *msg)
>  {
>  	u32 val;
> -	int idx, pos = 0, ret = 0, total;
> +	int idx, pos = 0, ret = 0, total, msg_offset = 0;
> 
> +	/*
> +	 * If the message length is already read in
> +	 * the first byte of the buffer, account for
> +	 * that by setting the offset
> +	 */
> +	if (qup_i2c_check_msg_len(msg) && (msg->len > 1))
> +		msg_offset = 1;
>  	total = qup_i2c_get_data_len(qup);
> +	total -= msg_offset;
> 
>  	/* 2 extra bytes for read tags */
>  	while (pos < (total + 2)) {
> @@ -1087,8 +1132,8 @@ static int qup_i2c_read_fifo_v2(struct
> qup_i2c_dev *qup,
> 
>  			if (pos >= (total + 2))
>  				goto out;
> -
> -			msg->buf[qup->pos++] = val & 0xff;
> +			msg->buf[qup->pos+msg_offset] = val & 0xff;
	A space around '+' ?

> +			qup->pos++;
>  		}
>  	}
> 
> @@ -1128,6 +1173,22 @@ static int qup_i2c_read_one_v2(struct
> qup_i2c_dev *qup, struct i2c_msg *msg)
>  			goto err;
> 
>  		qup->blk.pos++;
> +
> +		/* Handle SMBus block read length */
> +		if (qup_i2c_check_msg_len(msg) && (msg->len == 1)) {
> +			if (msg->buf[0] > I2C_SMBUS_BLOCK_MAX) {
> +				ret = -EPROTO;
> +				goto err;
> +			}
> +			msg->len += msg->buf[0];
> +			qup->pos = 0;
> +			qup_i2c_set_read_mode_v2(qup, msg->len);
> +			qup_i2c_issue_xfer_v2(qup, msg);
> +			ret = qup_i2c_wait_for_complete(qup, msg);
> +			if (ret)
> +				goto err;
		Is the issue_xfer_v2 needed inside this here ? 

> +			qup_i2c_set_blk_data(qup, msg);
> +		}
>  	} while (qup->blk.pos < qup->blk.count);
   Regards,
     Sricharan
