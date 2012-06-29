From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Jun 2012 14:40:02 +0200
Subject: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
In-Reply-To: <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120629144002.3b4a31ee@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2012 16:35:27 +0530, Shubhrajyoti D wrote:
> In i2c_smbus_xfer_emulated initialise the actual bytes
> to zero.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/i2c-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a6ad32b..fa7f799 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1949,8 +1949,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>  	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>  	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
> -	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 },
> -	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
> +	struct i2c_msg msg[2] = { { addr, flags, 1, 0, msgbuf0 },
> +				  { addr, flags | I2C_M_RD, 0, 0, msgbuf1 }
>  	                        };
>  	int i;
>  	u8 partial_pec = 0;

Please convert to C99-style initialization while you're there. And this
should be done first. Initializing i2c_msg.actual maybe rather belong
to i2c_transfer though, so that all callers don't have to care.

Are you sure there are no other places that need the same fix in the
kernel tree?

-- 
Jean Delvare
