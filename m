From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Nov 2012 16:07:55 +0100
Subject: [PATCH v2] pwm: Device tree support for PWM polarity.
In-Reply-To: <1353347472-26863-1-git-send-email-avinashphilip@ti.com>
References: <1353347472-26863-1-git-send-email-avinashphilip@ti.com>
Message-ID: <20121120150755.GB24545@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:21:12PM +0530, Philip, Avinash wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 112b314..70756f2 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -78,6 +78,10 @@ enum {
>  	PWMF_ENABLED = 1 << 1,
>  };
>  
> +/* flags in the third cell of the DT PWM specifier */
> +#define PWM_SPEC_POLARITY	(1 << 0)
> +
> +

This doesn't belong in this header. It should go into core.c in
drivers/pwm.

>  struct pwm_device {
>  	const char		*label;
>  	unsigned long		flags;
> @@ -176,6 +180,8 @@ void pwm_put(struct pwm_device *pwm);
>  
>  struct pwm_device *devm_pwm_get(struct device *dev, const char *consumer);
>  void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
> +struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
> +		const struct of_phandle_args *args);

The placement of this prototype is odd. I think a better place would be
between pwm_request_from_chip() and pwm_get(), separated by blank lines
to make it stand out as an OF specific function.

>  #else
>  static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
>  {
> @@ -223,6 +229,12 @@ static inline struct pwm_device *devm_pwm_get(struct device *dev,
>  static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
>  {
>  }
> +
> +static inline struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
> +		const struct of_phandle_args *args)
> +{
> +	return ERR_PTR(-ENODEV);
> +}

This function should only be used by PWM drivers and therefore doesn't
need to have a dummy implementation such as this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/f6a3ad4a/attachment.sig>
