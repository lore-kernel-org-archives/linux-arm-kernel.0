From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 19 Nov 2012 14:01:50 +0100
Subject: [PATCH v2 2/2] pwm: vt8500: Ensure pwm clock is enabled during
 pwm_config
In-Reply-To: <1353310254-21581-3-git-send-email-linux@prisktech.co.nz>
References: <1353310254-21581-1-git-send-email-linux@prisktech.co.nz>
 <1353310254-21581-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121119130150.GA31093@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 08:30:54PM +1300, Tony Prisk wrote:
> This patch corrects a bug reported by Peter Vasil.
> 
> When all PWMs are disabled, PWM module may be disabled during
> calls to pwm_config. This patch enables/disables the clock in
> pwm_config to ensure the module is active before register read/
> writes.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Tested-by: Peter Vasil <petervasil@gmail.com>
> ---
>  drivers/pwm/pwm-vt8500.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> index 806f72c..9fdb70d 100644
> --- a/drivers/pwm/pwm-vt8500.c
> +++ b/drivers/pwm/pwm-vt8500.c
> @@ -62,6 +62,13 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
>  	unsigned long long c;
>  	unsigned long period_cycles, prescale, pv, dc;
> +	int err;
> +
> +	err = clk_enable(vt8500->clk);
> +	if (err < 0) {
> +		dev_err(chip->dev, "failed to enable clock in pwm_config()\n");
> +		return err;
> +	};

I'm not entirely happy about this error message. What bugs me about it is
that the clock doesn't fail to enable in pwm_config() but rather in
vt8500_pwm_config(), so it might be slightly misleading. I'm not sure if
the failure location is needed at all. "failed to enable clock" sounds
useful enough. Furthermore I think that if it fails here it will likely
also fail elsewhere.

If you really absolutely want to specify where clk_enable() failed, then
I'd be slightly happier with "%s(): failed to enable clock", __func__.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/4bb0c7a6/attachment.sig>
