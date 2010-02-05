From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 5 Feb 2010 03:12:16 -0800
Subject: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
In-Reply-To: <309424b61002042151i2a762d41md3521a820fd45622@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	<20100204103530.65429c04@hyperion.delvare>
	<309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
	<f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
	<20100204141451.3e0f865e@hyperion.delvare>
	<309424b61002042151i2a762d41md3521a820fd45622@mail.gmail.com>
Message-ID: <f17812d71002050312o3625caaake318e909e09f2cd0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi, Jean
>
> Thanks for your instruction.
> Here is patch to modify some comments of i2c_master_send &
> i2c_master_recv, is this OK.
>

Where's the screaming things, dude?

> Thanks
> Zhangfei
>
> From 30fbf1ebf1facba3d280c887e2ecfd0499e7b04b Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Sat, 6 Feb 2010 05:38:59 +0800
> Subject: [PATCH] i2c: notes of i2c_master_send & i2c_master_recv
>
> ? ? ? ?i2c_master_send & i2c_master_recv not support more than 64bytes
> transfer, since msg.len is __u16 type
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
> ?Documentation/i2c/writing-clients | ? ?3 ++-
> ?drivers/i2c/i2c-core.c ? ? ? ? ? ?| ? ?4 ++--
> ?include/linux/i2c.h ? ? ? ? ? ? ? | ? ?1 +
> ?3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/i2c/writing-clients
> b/Documentation/i2c/writing-clients
> index 7860aaf..929a3c3 100644
> --- a/Documentation/i2c/writing-clients
> +++ b/Documentation/i2c/writing-clients
> @@ -318,7 +318,8 @@ Plain I2C communication
> ?These routines read and write some bytes from/to a client. The client
> ?contains the i2c address, so you do not have to include it. The second
> ?parameter contains the bytes to read/write, the third the number of bytes
> -to read/write (must be less than the length of the buffer.) Returned is
> +to read/write (must be less than the length of the buffer, also should be
> +less than 64K since msg.len is __u16 type.) Returned is
> ?the actual number of bytes read/written.
>
> ? ? ? ?int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 8d80fce..9607dcc 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1112,7 +1112,7 @@ EXPORT_SYMBOL(i2c_transfer);
> ?* i2c_master_send - issue a single I2C message in master transmit mode
> ?* @client: Handle to slave device
> ?* @buf: Data that will be written to the slave
> - * @count: How many bytes to write
> + * @count: How many bytes to write, should be less than 64K since
> msg.len is u16
> ?*
> ?* Returns negative errno, or else the number of bytes written.
> ?*/
> @@ -1139,7 +1139,7 @@ EXPORT_SYMBOL(i2c_master_send);
> ?* i2c_master_recv - issue a single I2C message in master receive mode
> ?* @client: Handle to slave device
> ?* @buf: Where to store data read from slave
> - * @count: How many bytes to read
> + * @count: How many bytes to read, should be less than 64K since msg.len is u16
> ?*
> ?* Returns negative errno, or else the number of bytes read.
> ?*/
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 57d41b0..b2dea18 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -53,6 +53,7 @@ struct i2c_board_info;
> ?* on a bus (or read from them). Apart from two basic transfer functions to
> ?* transmit one message at a time, a more complex version can be used to
> ?* transmit an arbitrary number of messages without interruption.
> + * Parameter count should be less than 64K since msg.len is __u16
> ?*/
> ?extern int i2c_master_send(struct i2c_client *client, const char *buf,
> ? ? ? ? ? ? ? ? ? ? ? ? ? int count);
> --
> 1.6.0.4
>
