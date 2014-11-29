From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 29 Nov 2014 16:14:52 +0900
Subject: [PATCH v3 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <2635255.iDIbPckc8L@wuerfel>
References: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
 <3094004.3WUKgY6xNz@wuerfel>
 <CACRpkdbahD314DL-ONQNkOzu9yHc_av4mxkqrYi8dS0PP43n8Q@mail.gmail.com>
 <2635255.iDIbPckc8L@wuerfel>
Message-ID: <CAAVeFu+Ejfdjbi1FOF-GVQKL8jr78VawJsfHB_8Wg1KLqt8TXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 29, 2014 at 6:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 28 November 2014 16:54:44 Linus Walleij wrote:
>> On Fri, Nov 28, 2014 at 10:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 28 November 2014 14:29:47 Zhou Wang wrote:
>>
>> >> Set ARCH_NR_GPIO for Hisilicon Soc Hip04, which has 4 GPIO
>> >> controllers with 32 GPIOs each.
>> >>
>> >> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
>> >> ---
>> >>  arch/arm/Kconfig                |    1 +
>> >>  arch/arm/configs/hisi_defconfig |    3 +++
>> >>  2 files changed, 4 insertions(+)
>> >>
>> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >> index 89c4b5c..26aae1e 100644
>> >> --- a/arch/arm/Kconfig
>> >> +++ b/arch/arm/Kconfig
>> >> @@ -1509,6 +1509,7 @@ config ARCH_NR_GPIO
>> >>         default 352 if ARCH_VT8500
>> >>         default 288 if ARCH_ROCKCHIP
>> >>         default 264 if MACH_H4700
>> >> +       default 128 if ARCH_HIP04
>> >>         default 0
>> >>         help
>> >>           Maximum number of GPIOs in the system.
>> >>
>> >
>> > If I remember correctly, you don't actually need to set this if all gpio
>> > clients are using the new gpio descriptor interfaces instead of gpio
>> > numbers.
>>
>> Unfortunately you still have to. We are working on removing the
>> dependency on ARCH_NR_GPIO, old habits die hard.
>
> Ok, I see.
>
>> But I just
>> merged this patch:
>> http://marc.info/?l=linux-gpio&m=141638350328535&w=2
>>
>> Which makes the situation better.
>
> Ah, cool!
>
>> There is however some other use of this define, so there is
>> some work required still to get rid of it.
>
> These are the only ones I could find:
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 9f0682534e2f..fe05d8b375ca 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -224,9 +224,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       if (WARN_ON(ARCH_NR_GPIOS < ngpio))
> -               ngpio = ARCH_NR_GPIOS;
> -
>         chips = devm_kzalloc(dev,
>                              ngpio * sizeof(struct davinci_gpio_controller),
>                              GFP_KERNEL);
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> index 746db6acf648..4f70024c2f9a 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> +++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> @@ -281,12 +281,12 @@ struct nmk_pinctrl {
>         void __iomem *prcm_base;
>  };
>
> -static struct nmk_gpio_chip *
> -nmk_gpio_chips[DIV_ROUND_UP(ARCH_NR_GPIOS, NMK_GPIO_PER_CHIP)];
> +#define NUM_BANKS 9 /* increase if necessary */
> +
> +static struct nmk_gpio_chip *nmk_gpio_chips[NUM_BANKS];
>
>  static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
>
> -#define NUM_BANKS ARRAY_SIZE(nmk_gpio_chips)
>
>  static void __nmk_gpio_set_mode(struct nmk_gpio_chip *nmk_chip,
>                                 unsigned offset, int gpio_mode)
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 383ade1a211b..b53bcf5c58e7 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -13,23 +13,6 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>
> -/* Platforms may implement their GPIO interface with library code,
> - * at a small performance cost for non-inlined operations and some
> - * extra memory (for code and for per-GPIO table entries).
> - *
> - * While the GPIO programming interface defines valid GPIO numbers
> - * to be in the range 0..MAX_INT, this library restricts them to the
> - * smaller range 0..ARCH_NR_GPIOS-1.
> - *
> - * ARCH_NR_GPIOS is somewhat arbitrary; it usually reflects the sum of
> - * builtin/SoC GPIOs plus a number of GPIOs on expanders; the latter is
> - * actually an estimate of a board-specific value.
> - */
> -
> -#ifndef ARCH_NR_GPIOS
> -#define ARCH_NR_GPIOS          512
> -#endif
> -
>  /*
>   * "valid" GPIO numbers are nonnegative and may be passed to
>   * setup routines like gpio_request().  only some valid numbers
> @@ -41,7 +24,11 @@
>
>  static inline bool gpio_is_valid(int number)
>  {
> -       return number >= 0 && number < ARCH_NR_GPIOS;
> +#ifdef ARCH_NR_GPIOS
> +       if (number > ARCH_NR_GPIOS)
> +               return 0;
> +#endif
> +       return number >= 0;
>  }
>
>  struct device;
>
>> > However if one builds a kernel that just enables OMAP4 and HIP04, I suspect
>> > it can't work on OMAP4 for any gpio line above 128, which seems to be
>> > a fundamental multiplatform problem.
>>
>> Yes I guess you are right :(
>>
>> It's probably just so that so many platforms converge on 512.
>>
>> > Do we neet to increase the default to 512 for all ARCH_MULTIPLATFORM
>> > configurations and just leave ARCH_SHMOBILE, ARCH_TEGRA and MACH_H4700
>> > here as special cases?
>>
>> That'd be good while we are working to kill off
>> ARCH_NR_GPIO for good.
>>
>> I guess there could be arch-specific problems with trying
>> to get rid of ARCH_NR_GPIO for good, do you have some
>> input on this? (Arch maintainer hat on...)
>
> I think killing off the hardcoded number as soon as possible is
> best, but it doesn't seem appropriate for stable backports or 3.18,
> so let's do the 512 default on arm32-multiplatform with stable
> backports.

The main problem I see with killing ARCH_NR_GPIO is that it is used to
find a free GPIO range for GPIO chips which base GPIO is not
pre-decided (i.e. base < 0). gpiochip_find_base() returns the highest
free range matching the chip's needs. Removing it, we will have two
issues:

1) how do we decide the GPIO base for chips which base member is < 0?
We could take an arbitrarily high number, but this leads to...
2) ... are we ok with GPIO base number changing for such chips,
especially since this number is potentially exported by the sysfs
interface?

This talks in favor of named GPIO exports, but the problem of
user-space compatibility will remain. This problem apart, I'm all for
removing ARCH_NR_GPIOs and actually already have patches that do so,
provided the static GPIO array removal patch survives a few weeks of
testing in -next.
