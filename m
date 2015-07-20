From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 20 Jul 2015 11:25:00 +0300
Subject: [PATCH V4 2/7] qup: i2c: factor out common code for reuse
In-Reply-To: <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
 <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <1437380700.6267.1.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan, 

On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:
> 

>  static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>  {
> -       unsigned long left;
> -       int ret;
> +       int ret = 0;
> 
> -       qup->msg = msg;
> -       qup->pos  = 0;
> +       /*
> +               * The QUP block will issue a NACK and STOP on the bus when reaching
> +               * the end of the read, the length of the read is specified as one byte
> +               * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
> +               */
> +       if (msg->len > QUP_READ_LIMIT) {
> +               dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
> +                       QUP_READ_LIMIT);
> +               return -EINVAL;
> +       }
> 

This should be removed. Please see qup_i2c_quirks.

Regards,
Ivan
