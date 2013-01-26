From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 26 Jan 2013 06:40:24 +0100
Subject: [PATCH v2 1/3] pwm: Add pwm_cansleep() as exported API to users
In-Reply-To: <1359121471-21457-2-git-send-email-florian.vaussard@epfl.ch>
References: <1359121471-21457-1-git-send-email-florian.vaussard@epfl.ch>
 <1359121471-21457-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130126054024.GB29243@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 02:44:29PM +0100, Florian Vaussard wrote:
> Calls to some external PWM chips can sleep. To help users,
> add pwm_cansleep() API.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  drivers/pwm/core.c  |   12 ++++++++++++
>  include/linux/pwm.h |   10 ++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4a13da4..e737f5f 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -763,6 +763,18 @@ void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
>  }
>  EXPORT_SYMBOL_GPL(devm_pwm_put);
>  
> +/**
> +  * pwm_cansleep() - report whether pwm access will sleep

"... whether PWM access..." please.

> +  * @pwm: PWM device
> +  *
> +  * It returns nonzero if accessing the PWM can sleep.
> +  */
> +int pwm_cansleep(struct pwm_device *pwm)

I actually liked pwm_can_sleep() better. I find it to be more consistent
with the naming of other function names. It would furthermore match the
field name.

> +{
> +	return pwm->chip->can_sleep;
> +}
> +EXPORT_SYMBOL_GPL(pwm_cansleep);

Would it make sense to check for NULL pointers here? I guess that
passing NULL into the function could be considered a programming error
and an oops would be okay, but in that case there's no point in making
the function return an int. Also see my next comment.

> +
>  #ifdef CONFIG_DEBUG_FS
>  static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
>  {
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 70655a2..e2cb5c7 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -146,6 +146,8 @@ struct pwm_ops {
>   * @base: number of first PWM controlled by this chip
>   * @npwm: number of PWMs controlled by this chip
>   * @pwms: array of PWM devices allocated by the framework
> + * @can_sleep: flag must be set iff config()/enable()/disable() methods sleep,
> + *      as they must while accessing PWM chips over I2C or SPI
>   */
>  struct pwm_chip {
>  	struct device		*dev;
> @@ -159,6 +161,7 @@ struct pwm_chip {
>  	struct pwm_device *	(*of_xlate)(struct pwm_chip *pc,
>  					    const struct of_phandle_args *args);
>  	unsigned int		of_pwm_n_cells;
> +	unsigned int		can_sleep:1;

What's the reason for making this a bitfield? Couldn't we just use a
bool instead?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/dc808821/attachment.sig>
