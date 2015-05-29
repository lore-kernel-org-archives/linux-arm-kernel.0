From: robh@kernel.org (Rob Herring)
Date: Fri, 29 May 2015 08:59:02 -0500
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAL_Jsq+-u7pf7JOXD7frB-ye9bk0NLAKhAJFvLYz1a1jzOCb9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 8:03 AM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
> From: Rob Herring <robh@kernel.org>

This probably should still be Leilei, but...

> Since there is some problematic i2c slave devices on some
> platforms such as dkb (sometimes), it will drop down sda
> and make i2c bus hang, at that time, it need to config
> scl/sda into gpio to simulate "stop" sequence to recover
> i2c bus, so add this interface.
>
> Signed-off-by: Leilei Shang <shangll@marvell.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [vaibhav.hiremath at linaro.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 8ca5552..eb09071 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -37,6 +37,8 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/i2c/pxa-i2c.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include <asm/irq.h>
>
> @@ -177,6 +179,9 @@ struct pxa_i2c {
>         bool                    highmode_enter;
>         unsigned int            ilcr;
>         unsigned int            iwcr;
> +       struct pinctrl          *pinctrl;
> +       struct pinctrl_state    *pin_i2c;
> +       struct pinctrl_state    *pin_gpio;
>  };
>
>  #define _IBMR(i2c)     ((i2c)->reg_ibmr)
> @@ -269,6 +274,62 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
>
>  #define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
>
> +static void i2c_bus_reset(struct pxa_i2c *i2c)

There's a generic mechanism in i2c_generic_gpio_recovery we should use
here. It appears to be similar, but not exactly the same. The pinctrl
part should probably be done by gpio driver.

Rob
