From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 7 Jun 2016 09:27:48 -0700
Subject: [PATCH] gpio: bcm-kona: fix bcm_kona_gpio_reset() warnings
In-Reply-To: <1465316537-8403-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465316537-8403-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <b9bdbc1e-30cd-3a51-f281-6fae297d1f0a@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 6/7/2016 9:22 AM, Ben Dooks wrote:
> The bcm_kona_gpio_reset() calls bcm_kona_gpio_write_lock_regs()
> with what looks like the wrong parameter. The write_lock_regs
> function takes a pointer to the registers, not the bcm_kona_gpio
> structure.
>
> Fix the warning, and probably bug by changing the function to
> pass reg_base instead of kona_gpio, fixing the following warning:
>
> drivers/gpio/gpio-bcm-kona.c:550:47: warning: incorrect type in argument 1 (different address spaces)
> drivers/gpio/gpio-bcm-kona.c:550:47:    expected void [noderef] <asn:2>*reg_base
> drivers/gpio/gpio-bcm-kona.c:550:47:    got struct bcm_kona_gpio *kona_gpio
> drivers/gpio/gpio-bcm-kona.c:554:47: warning: incorrect type in argument 1 (different address spaces)
> drivers/gpio/gpio-bcm-kona.c:554:47:    expected void [noderef] <asn:2>*reg_base
> drivers/gpio/gpio-bcm-kona.c:554:47:    got struct bcm_kona_gpio *kona_gpio
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Markus Mayer <mmayer@broadcom.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/gpio/gpio-bcm-kona.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index 9aabc48..953e4b8 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -547,11 +547,11 @@ static void bcm_kona_gpio_reset(struct bcm_kona_gpio *kona_gpio)
>  	/* disable interrupts and clear status */
>  	for (i = 0; i < kona_gpio->num_bank; i++) {
>  		/* Unlock the entire bank first */
> -		bcm_kona_gpio_write_lock_regs(kona_gpio, i, UNLOCK_CODE);
> +		bcm_kona_gpio_write_lock_regs(reg_base, i, UNLOCK_CODE);
>  		writel(0xffffffff, reg_base + GPIO_INT_MASK(i));
>  		writel(0xffffffff, reg_base + GPIO_INT_STATUS(i));
>  		/* Now re-lock the bank */
> -		bcm_kona_gpio_write_lock_regs(kona_gpio, i, LOCK_CODE);
> +		bcm_kona_gpio_write_lock_regs(reg_base, i, LOCK_CODE);
>  	}
>  }
>
>

This fix looks good. The original code shouldn't even have worked.

Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>
