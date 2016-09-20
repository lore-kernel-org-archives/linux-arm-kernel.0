From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 20 Sep 2016 09:19:13 +0200
Subject: [PATCH 2/3] i2c: bcm2835: Add support for combined write-read
 transfer
In-Reply-To: <1474298777-5858-2-git-send-email-noralf@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
 <1474298777-5858-2-git-send-email-noralf@tronnes.org>
Message-ID: <c47a0a10-4e0b-9025-8d38-af299d5f55da@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Noralf!

On 19.09.2016 17:26, Noralf Tr?nnes wrote:
> Some SMBus protocols use Repeated Start Condition to switch from write
> mode to read mode. Devices like MMA8451 won't work without it.
>
> When downstream implemented support for this in i2c-bcm2708, it broke
> support for some devices, so a module parameter was added and combined
> transfer was disabled by default.
> See https://github.com/raspberrypi/linux/issues/599
> It doesn't seem to have been any investigation into what the problem
> really was. Later there was added a timeout on the polling loop.
>
> One of the devices mentioned to partially stop working was DS1307.
>
> I have run thousands of transfers to a DS1307 (rtc), MMA8451 (accel)
> and AT24C32 (eeprom) in parallel without problems.
>
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
> ---
>   drivers/i2c/busses/i2c-bcm2835.c | 107 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 98 insertions(+), 9 deletions(-)
...
> @@ -209,8 +289,17 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>   	int i;
>   	int ret = 0;
>   
> +	/* Combined write-read to the same address (smbus) */
> +	if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
> +	    !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
> +	    (msgs[0].len <= 16)) {
> +		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
> +
> +	return ret ? ret : 2;
> +	}
> +
>   	for (i = 0; i < num; i++) {
> -		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i]);
> +		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i], NULL);
>   		if (ret)
>   			break;
>   	}
This does not seem to implement the i2c_msg api correctly.

As per comments in include/uapi/linux/i2c.h on line 58 only the last message
in a group should - by default - send a STOP.

As far as I understand  you would need to implement the I2C_M_STOP flag
(by exposing  I2C_FUNC_PROTOCOL_MANGLING in bcm2835_i2c_func)
to make this work correctly:

  	for (i = 0; i < num; i++) {
+		bool send_stop = (i == num - 1) ||msgs[i] <http://lxr.free-electrons.com/ident?i=msg>->flags <http://lxr.free-electrons.com/ident?i=flags>  &I2C_M_STOP <http://lxr.free-electrons.com/ident?i=I2C_M_STOP>;
-		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i]);
+		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i], send_stop);
  		if (ret)
  			break;
  	}

The corresponding device driver (or userspace) will need to set the flag 
correctly.

Martin
