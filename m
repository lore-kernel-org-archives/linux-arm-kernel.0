From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 4 Feb 2010 10:35:30 +0100
Subject: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
In-Reply-To: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
Message-ID: <20100204103530.65429c04@hyperion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gao,

I'm adding the linux-i2c list to Cc.

On Thu, 4 Feb 2010 14:04:03 +0800, zhangfei gao wrote:
> We found type of i2c_msg.len is __u16, while parameter count in
> i2c_master_send is int.
> The mismatch will truncate count from int to u16.
> For example we downloading firmware which is more than 64K (64K+8) via i2c,
> i2c would transfer u16 (8 bytes) in fact.
> 
> 
> From 69ec7599bf0fa28441281be1df76a2f573bb9127 Mon Sep 17 00:00:00 2001
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

Unfortunately struct i2c_msg is part of the user-space ABI so you don't
get to modify it.

What you can do is add a check on "count" in both i2c_master_send() and
i2c_master_recv() so that messages which will not fit are rejected
rather than being silently truncated. Alternatively, the count
parameters could be turned into u16, so that the limitation is
immediately visible. This would be more efficient.

I don't think it makes a lot of sense to transfer more than 64 kB at
once over I2C. I don't know at which speed you operate your bus, but
even at 400 kHz, it takes 1.5 second to transfer 64 kB. At the regular
100 kHz, it takes no less than 6 seconds. This incurs pretty high
latency over the bus in question... Not to mention the system in its
entirety if your bus is backed by the never-sleeping i2c-algo-bit or
similar.

So if the hardware allows it, you should simply split the firmware in
smaller chunks so that it fits into the current interface.

If this is really impossible, then we'd have to introduce a new
structure for these long messages. As we can't use these in user-space
for compatibility reasons, we would have to translate from one
structure type to the other and back for every user-space transaction.
Obviously there would be a performance penalty, which is why I'd like
to avoid it if possible.

-- 
Jean Delvare
