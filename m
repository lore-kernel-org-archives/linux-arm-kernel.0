From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 20 Jul 2015 14:22:54 +0300
Subject: [PATCH V4 4/7] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
In-Reply-To: <1436412350-19519-5-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
 <1436412350-19519-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <1437391374.6267.7.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:

<snip>

>  #define ONE_BYTE                       0x1
> +#define QUP_I2C_MX_CONFIG_DURING_RUN   BIT(31)
> 
>  struct qup_i2c_block {
>         int     count;
> @@ -121,6 +122,7 @@ struct qup_i2c_block {
>         int     rx_tag_len;
>         int     data_len;
>         u8      tags[6];
> +       int     config_run;

This is not directly related to "block" control logic, right?
Could it made part of qup_i2c_dev structure?

>  };
> 
>  struct qup_i2c_dev {
> @@ -152,6 +154,10 @@ struct qup_i2c_dev {
> 
>         int (*qup_i2c_write_one)(struct qup_i2c_dev *qup,
>                                         struct i2c_msg *msg);
> +       /* Current i2c_msg in i2c_msgs */
> +       int     cmsg;
> +       /* total num of i2c_msgs */
> +       int     num;

I think it will be simpler with just "bool is_last" evaluated in main xfer loop.

<snip>

> 
> @@ -374,6 +383,9 @@ static void qup_i2c_get_blk_data(struct qup_i2c_dev *qup,
>         /* There are 2 tag bytes that are read in to fifo for every block */
>         if (msg->flags & I2C_M_RD)
>                 qup->blk.rx_tag_len = qup->blk.count * 2;
> +
> +       if (qup->cmsg)
> +               qup->blk.config_run = QUP_I2C_MX_CONFIG_DURING_RUN;

This could be moved to qup_i2c_xfer_v2() to avoid repeatedly setting it. 

>  }

Regards,
Ivan
