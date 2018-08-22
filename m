From: ggdavisiv@gmail.com (George G. Davis)
Date: Wed, 22 Aug 2018 14:08:20 -0400
Subject: [PATCH v3 2/3] Input: atmel_mxt_ts: Wait for device be ready for
 communication
In-Reply-To: <1533050291-11502-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1533050291-11502-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180822180820.GB4102@gandalf.middle.earth.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pawe?,

On Tue, Jul 31, 2018 at 05:18:10PM +0200, Pawe? Chmiel wrote:
> According to documentation, device isn't ready for communication,
> until firmware asserts the CHG line. Add missing wait for this.
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 2cd7f6db6ba9..79e08916359f 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -202,6 +202,7 @@ enum t100_type {
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> +#define MXT_POWERON_DELAY	150	/* msec */
>  
>  /* Command to unlock bootloader */
>  #define MXT_UNLOCK_CMD_MSB	0xaa
> @@ -3046,6 +3047,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
>  		msleep(MXT_REGULATOR_DELAY);
>  		gpiod_set_value(data->reset_gpio, 1);
>  		msleep(MXT_RESET_INVALID_CHG);
> +
> +retry_wait:
> +		reinit_completion(&data->bl_completion);
> +		data->in_bootloader = true;
> +		error = mxt_wait_for_completion(data, &data->bl_completion,
> +										MXT_POWERON_DELAY);

Please fix the following checkpatch issues:

drivers/input/touchscreen/atmel_mxt_ts.c:3078: WARNING:LONG_LINE: line over 80 characters
drivers/input/touchscreen/atmel_mxt_ts.c:3078: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis

Thanks!

--
Regards,
George

> +		if (error == -EINTR)
> +			goto retry_wait;
> +
> +		data->in_bootloader = false;
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
