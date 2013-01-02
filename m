From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 2 Jan 2013 15:09:41 +0100
Subject: [PATCH 2/2] pwm: vt8500: Add support for .set_polarity
In-Reply-To: <1356899005-8876-2-git-send-email-linux@prisktech.co.nz>
References: <1356899005-8876-1-git-send-email-linux@prisktech.co.nz>
 <1356899005-8876-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130102140941.GC4414@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 09:23:25AM +1300, Tony Prisk wrote:
> Add support to set polarity on pwm devices, allowing for inverted
> duty cycles.

"PWM devices", please. Maybe the subject could be something less API
specific, like "pwm: vt8500: Add polarity support".

>  .../devicetree/bindings/pwm/vt8500-pwm.txt         |    7 ++++---
>  drivers/pwm/pwm-vt8500.c                           |   21 ++++++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> index bcc6367..f71cc8d 100644
> --- a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> @@ -3,14 +3,15 @@ VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
>  Required properties:
>  - compatible: should be "via,vt8500-pwm"
>  - reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2.  The first cell specifies the per-chip index
> -  of the PWM to use and the second cell is the period in nanoseconds.
> +- #pwm-cells: should be 3.  The first cell specifies the per-chip index
> +  of the PWM to use, the second cell is the period in nanoseconds, and the
> +  third cell is for flags.

This needs to document what flags the third cell encodes and how. Either
that or refer to the generic PWM binding documentation.

> diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> index 27ed0f4..9abf561 100644
> --- a/drivers/pwm/pwm-vt8500.c
> +++ b/drivers/pwm/pwm-vt8500.c
> @@ -164,10 +164,31 @@ static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clk_disable(vt8500->clk);
>  }
>  
> +static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   enum pwm_polarity polarity)
> +{
> +	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
> +	u32 val;
> +
> +	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
> +
> +	if (polarity == PWM_POLARITY_INVERSED)
> +		val |= CTRL_INVERT;
> +	else
> +		val &= ~CTRL_INVERT;
> +
> +	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
> +	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
> +
> +	return 0;
> +}
> +
>  static struct pwm_ops vt8500_pwm_ops = {
>  	.enable = vt8500_pwm_enable,
>  	.disable = vt8500_pwm_disable,
>  	.config = vt8500_pwm_config,
> +	.set_polarity = vt8500_pwm_set_polarity,
>  	.owner = THIS_MODULE,
>  };

This patch is missing the corresponding changes to the DT code. You need
to override the pwm_chip's .of_xlate() and .of_pwm_n_cells fields. You
can look at the TI EHRPWM driver if you need inspiration.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130102/c6bd63da/attachment.sig>
