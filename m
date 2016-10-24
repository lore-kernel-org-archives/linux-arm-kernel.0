From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 24 Oct 2016 19:55:32 +0800
Subject: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <e2972b59-b648-88ed-ca0a-acd827b63c2b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:


On 2016?10?22? 16:43, David Wu wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
>
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>   drivers/i2c/busses/i2c-rk3x.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 50702c7..df22066 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -694,6 +694,8 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
>   	t_calc->div_low--;
>   	t_calc->div_high--;
>   
> +	/* Give the tuning value 0, that would not update con register */
> +	t_calc->tuning = 0;
>   	/* Maximum divider supported by hw is 0xffff */
>   	if (t_calc->div_low > 0xffff) {
>   		t_calc->div_low = 0xffff;

rk3066a based board can't boot up(with endless i2c irq messages print 
out) from linux-4.8 without this fix.

Tested-by: Andy Yan <andy.yan@rock-chips.com>
