From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 14 Mar 2012 15:42:37 -0500
Subject: [PATCH v4 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <1331740593-10807-3-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695DB57DC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 14, 2012 8:56 AM, Thierry Reding wrote:
> 
> Many PWM controllers provide access to more than a single PWM output and
> may even share some resource among them. Allowing a PWM chip to provide
> multiple PWM devices enables better sharing of those resources. As a
> side-effect this change allows easy integration with the device tree
> where a given PWM can be looked up based on the PWM chip's phandle and a
> corresponding index.
>
> This commit modifies the PWM core to support multiple PWMs per struct
> pwm_chip. It achieves this in a similar way to how gpiolib works, by
> allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
> starting at a given offset (pwm_chip.base >= 0). A chip specifies how
> many PWMs it controls using the npwm member. Each of the functions in
> the pwm_ops structure gets an additional argument that specified the PWM
> number (it can be converted to a per-chip index by subtracting the
> chip's base).
>
> The total maximum number of PWM devices is currently fixed to 1024 while
> the data is actually stored in a radix tree, thus saving resources if
> not all of them are used.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---

<snip>

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index df9681b..7261911 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h

<snip>

>  /**
> - * struct pwm_ops - PWM operations
> + * struct pwm_ops - PWM controller operations
>   * @request: optional hook for requesting a PWM
>   * @free: optional hook for freeing a PWM
>   * @config: configure duty cycles and period length for this PWM
>   * @enable: enable PWM output toggling
>   * @disable: disable PWM output toggling
> + * @dbg_show: optional routine to show contents in debugfs
> + * @owner: helps prevent removal of modules exporting active PWMs
>   */
>  struct pwm_ops {
> -	int			(*request)(struct pwm_chip *chip);
> -	void			(*free)(struct pwm_chip *chip);
> -	int			(*config)(struct pwm_chip *chip, int duty_ns,
> -						int period_ns);
> -	int			(*enable)(struct pwm_chip *chip);
> -	void			(*disable)(struct pwm_chip *chip);
> +	int			(*request)(struct pwm_chip *chip,
> +					   struct pwm_device *pwm);
> +	void			(*free)(struct pwm_chip *chip,
> +					struct pwm_device *pwm);
> +	int			(*config)(struct pwm_chip *chip,
> +					  struct pwm_device *pwm,
> +					  int duty_ns, int period_ns);
> +	int			(*enable)(struct pwm_chip *chip,
> +					  struct pwm_device *pwm);
> +	void			(*disable)(struct pwm_chip *chip,
> +					   struct pwm_device *pwm);
> +#ifdef CONFIG_DEBUG_FS
> +	void			(*dbg_show)(struct pwm_chip *chip,
> +					    struct seq_file *s);
> +#endif

This doesn't compile...

include/linux/pwm.h:87: warning: 'struct seq_file' declared inside parameter list
include/linux/pwm.h:87: warning: its scope is only this definition or declaration, which is probably not what you want

Regards,
Hartley
