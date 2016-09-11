From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 11 Sep 2016 15:13:17 +0200
Subject: [PATCH 1/6] gpio: constify gpio_chip structures
In-Reply-To: <1473596082-32690-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
 <1473596082-32690-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAGhQ9VwrKZ0wzu=PAUkkpfsnZpYwvvya4kCAFwvV+J3WtSWBaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On 11 September 2016 at 14:14, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> These structures are only used to copy into other structures, so declare
> them as const.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct gpio_chip i at p = { ... };
>
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e = i at p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct gpio_chip e;
> @@
> e at i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct gpio_chip i = { ... };
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/gpio/gpio-arizona.c  |    2 +-
>  drivers/gpio/gpio-bcm-kona.c |    2 +-
>  drivers/gpio/gpio-da9052.c   |    2 +-
>  drivers/gpio/gpio-da9055.c   |    2 +-
>  drivers/gpio/gpio-it87.c     |    2 +-
>  drivers/gpio/gpio-lp873x.c   |    2 +-
>  drivers/gpio/gpio-lpc18xx.c  |    2 +-
>  drivers/gpio/gpio-pisosr.c   |    2 +-
>  drivers/gpio/gpio-sch.c      |    2 +-
>  drivers/gpio/gpio-stmpe.c    |    2 +-
>  drivers/gpio/gpio-tc3589x.c  |    2 +-
>  drivers/gpio/gpio-tpic2810.c |    2 +-
>  drivers/gpio/gpio-tps65086.c |    2 +-
>  drivers/gpio/gpio-tps65218.c |    2 +-
>  drivers/gpio/gpio-tps65912.c |    2 +-
>  drivers/gpio/gpio-ts4900.c   |    2 +-
>  drivers/gpio/gpio-twl4030.c  |    2 +-
>  drivers/gpio/gpio-wm831x.c   |    2 +-
>  drivers/gpio/gpio-wm8350.c   |    2 +-
>  drivers/gpio/gpio-wm8994.c   |    2 +-
>  20 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
> index 98832c9..f12e02e 100644
> --- a/drivers/gpio/gpio-lpc18xx.c
> +++ b/drivers/gpio/gpio-lpc18xx.c
> @@ -78,7 +78,7 @@ static int lpc18xx_gpio_direction_output(struct gpio_chip *chip,
>         return lpc18xx_gpio_direction(chip, offset, true);
>  }
>
> -static struct gpio_chip lpc18xx_chip = {
> +static const struct gpio_chip lpc18xx_chip = {
>         .label                  = "lpc18xx/43xx-gpio",
>         .request                = gpiochip_generic_request,
>         .free                   = gpiochip_generic_free,

For lpc18xx:
Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
