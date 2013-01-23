From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jan 2013 16:39:11 +0100
Subject: [PATCH] ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
In-Reply-To: <1358933646-12681-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1358933646-12681-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358933646-12681-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkda97_m2XxhCCFeH410=HQA+0G=UmY8BDk1d+o1Mo+ZfLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 10:34 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The IP responsible for the muxing on the Allwinner SoCs are also
> handling the GPIOs on the system. This patch adds the needed driver that
> relies on the pinctrl driver for most of its operations.
>
> The number of pins available for GPIOs operations are already declared
> in the pinctrl driver, we only need to probe a generic driver to handle
> the banks available for each SoC.
>
> This driver has been tested on a A13-Olinuxino.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Overall this is VERY NICE!

> +       char *func, *pin_name;
(...)
> +       pin_name = kzalloc(5, GFP_KERNEL);
> +       if (!pin_name)
> +               return -ENOMEM;
> +
> +       ret = sprintf(pin_name, "P%c%d", 'A' + bank, pin);
> +       if (!ret)
> +               goto error;
(...)
> +error:
> +       kfree(pin_name);

Isn't this a bit awkward?

Can't you either use something like a local
static char foo[MAX_SIZE]; or atleast try to use
one of the static string print functions from <linux/kernel.h>:

/* lib/printf utilities */

extern __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
extern __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
extern __printf(3, 4)
int snprintf(char *buf, size_t size, const char *fmt, ...);
extern __printf(3, 0)
int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
extern __printf(3, 4)
int scnprintf(char *buf, size_t size, const char *fmt, ...);
extern __printf(3, 0)
int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
extern __printf(2, 3)
char *kasprintf(gfp_t gfp, const char *fmt, ...);
extern char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);

Yours,
Linus Walleij
