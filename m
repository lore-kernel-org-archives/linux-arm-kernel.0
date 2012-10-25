From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Oct 2012 14:57:48 +0200
Subject: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
In-Reply-To: <1350899218-13624-8-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-8-git-send-email-balbi@ti.com>
Message-ID: <20121025145748.760c218b@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe, Shubhrajyoti,

On Mon, 22 Oct 2012 12:46:57 +0300, Felipe Balbi wrote:
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> In case of a NACK, it's wise to tell our clients
> drivers about how many bytes were actually transferred.
> 
> Support this by adding an extra field to the struct
> i2c_msg which gets incremented the amount of bytes
> actually transferred.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  include/uapi/linux/i2c.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> index 0e949cb..4b35c9b 100644
> --- a/include/uapi/linux/i2c.h
> +++ b/include/uapi/linux/i2c.h
> @@ -77,6 +77,7 @@ struct i2c_msg {
>  #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
>  #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
>  	__u16 len;		/* msg length				*/
> +	__u16 transferred;	/* actual bytes transferred             */
>  	__u8 *buf;		/* pointer to msg data			*/
>  };

On the principle I am fine with this, however you also need to define
who should initialize this field, and to what value.

Not all i2c bus drivers will implement this functionality at first.
Some may even be unable to ever implement it. As soon as i2c chip
drivers start checking this value, you will hit combinations of chip
driver checking the value and bus driver not setting it. And it has to
work.

We have to decide whether it is enough to initialize "transferred" to
0, or if we need a more reliable way to distinguish between "0 bytes
transferred" and "the bus driver can't tell". What's your take on this?
If we need to distinguish, this could be done using a new I2C_FUNC_*
flag, or by initializing "transferred" to (__u16)(-1) instead of 0 for
example.

Then we have to decide whether initialization is done by the individual
drivers, or by i2c-core. By the drivers might be faster, but this may
also mean more code (and bugs more likely) than letting i2c-core handle
it. The exact balance probably depends on the answer to the previous
question (initializing a field to 0 is free in many cases.)

-- 
Jean Delvare
