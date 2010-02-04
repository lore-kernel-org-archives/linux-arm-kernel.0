From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 4 Feb 2010 07:37:59 +0000
Subject: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
In-Reply-To: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
Message-ID: <20100204073759.GC13267@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 02:04:03PM +0800, zhangfei gao wrote:
> Hi, Jean
> 
> 
> We found type of i2c_msg.len is __u16, while parameter count in
> i2c_master_send is int.
> The mismatch will truncate count from int to u16.
> For example we downloading firmware which is more than 64K (64K+8) via i2c,
> i2c would transfer u16 (8 bytes) in fact.

I would be wary of changing the i2c_msg structure as this is exported to
userspace.

I think a better fix would be to test the count parameter to i2c_master_send
and return something like EMSGSIZE to inform the user it is too long.

If you really want i2c transfers of 64K and above, then you might have to
add a new struct i2c_msg and update all the callsites to use it. Either that
or chain a set of msgs together and pass them to the i2c controller in one
go.

Please discuss on the i2c list.
 
> >From 69ec7599bf0fa28441281be1df76a2f573bb9127 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 5 Feb 2010 05:12:19 +0800
> Subject: [PATCH] i2c: i2c_msg.len modify to __u32 type
> 
>     int i2c_master_send(struct i2c_client *client,const char *buf ,int
> count)
>     {
>         ~
>         msg.len = count;
>         ~
>     }
>     Parameter count would truncate from int to __u16
> 
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
>  include/linux/i2c.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 57d41b0..4769ce9 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -491,7 +491,7 @@ struct i2c_msg {
>  #define I2C_M_IGNORE_NAK    0x1000    /* if I2C_FUNC_PROTOCOL_MANGLING */
>  #define I2C_M_NO_RD_ACK        0x0800    /* if I2C_FUNC_PROTOCOL_MANGLING
> */
>  #define I2C_M_RECV_LEN        0x0400    /* length will be first received
> byte */
> -    __u16 len;        /* msg length                */
> +    __u32 len;        /* msg length                */
>      __u8 *buf;        /* pointer to msg data            */
>  };
> 
> -- 
> 1.6.0.4


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
