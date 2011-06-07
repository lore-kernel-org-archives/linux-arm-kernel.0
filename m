From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 7 Jun 2011 17:42:47 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix incorrect mapping of gpio pull-up macro
	to register setting
In-Reply-To: <1307435689-15954-1-git-send-email-thomas.ab@samsung.com>
References: <1307435689-15954-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <BANLkTi=YeOyK1WX61NtyprYdUyNmSo1sTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 5:34 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> The S3C_GPIO_PULL_UP macro value incorrectly maps to a reserved setting of GPIO
> pull up/down registers on Exynos4 platform. Fix this incorrect mapping by adding
> wrappers to the s3c_gpio_setpull_updown and s3c_gpio_getpull_updown functions.

Personally I like to use the variable instead of function hooking.
set the correct variable at cpu dection and use it
then these thing make a single generic function and each gpio_cfg use
the same thing.

Anyway it's next step. current fix the bug first.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
> ?drivers/gpio/gpio-exynos4.c | ? 29 +++++++++++++++++++++++++----
> ?1 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-exynos4.c b/drivers/gpio/gpio-exynos4.c
> index d54ca6a..9029835 100644
> --- a/drivers/gpio/gpio-exynos4.c
> +++ b/drivers/gpio/gpio-exynos4.c
> @@ -21,16 +21,37 @@
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/gpio-cfg-helpers.h>
>
> +int s3c_gpio_setpull_exynos4(struct s3c_gpio_chip *chip,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int off, s3c_gpio_pull_t pull)
> +{
> + ? ? ? if (pull == S3C_GPIO_PULL_UP)
> + ? ? ? ? ? ? ? pull = 3;
> +
> + ? ? ? return s3c_gpio_setpull_updown(chip, off, pull);
> +}
static?
> +
> +s3c_gpio_pull_t s3c_gpio_getpull_exynos4(struct s3c_gpio_chip *chip,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int off)
> +{
> + ? ? ? s3c_gpio_pull_t pull;
> +
> + ? ? ? pull = s3c_gpio_getpull_updown(chip, off);
> + ? ? ? if (pull == 3)
> + ? ? ? ? ? ? ? pull = S3C_GPIO_PULL_UP;
> +
> + ? ? ? return pull;
> +}
ditto.
> +
> ?static struct s3c_gpio_cfg gpio_cfg = {
> ? ? ? ?.set_config ? ? = s3c_gpio_setcfg_s3c64xx_4bit,
> - ? ? ? .set_pull ? ? ? = s3c_gpio_setpull_updown,
> - ? ? ? .get_pull ? ? ? = s3c_gpio_getpull_updown,
> + ? ? ? .set_pull ? ? ? = s3c_gpio_setpull_exynos4,
> + ? ? ? .get_pull ? ? ? = s3c_gpio_getpull_exynos4,
> ?};
>
> ?static struct s3c_gpio_cfg gpio_cfg_noint = {
> ? ? ? ?.set_config ? ? = s3c_gpio_setcfg_s3c64xx_4bit,
> - ? ? ? .set_pull ? ? ? = s3c_gpio_setpull_updown,
> - ? ? ? .get_pull ? ? ? = s3c_gpio_getpull_updown,
> + ? ? ? .set_pull ? ? ? = s3c_gpio_setpull_exynos4,
> + ? ? ? .get_pull ? ? ? = s3c_gpio_getpull_exynos4,
> ?};
>
> ?/*
> --
> 1.6.6.rc2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
