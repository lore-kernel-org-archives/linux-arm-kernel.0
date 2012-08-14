From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:51:02 +0200
Subject: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup into the MSP
 driver
In-Reply-To: <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In the initial submission of the MSP driver msp1 and msp3's associated
> pinctrl mechanism was passed back to platform code using a plat_init()
> call-back routine, but it has no place in platform code. The MSP driver
> should set this up for the appropriate ports. Instead we use a use_pinctrl
> identifier which is passed from platform_data/Device Tree which indicates
> which ports should use pinctrl.
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is very good because it rids platform code and makes the driver
self-contained without strange platform data hooks.

Now details...

> +/* MSP1/3 Tx/Rx usage protection */
> +static DEFINE_SPINLOCK(msp_rxtx_lock);
> +
> +/* Pin modes */
> +struct pinctrl *pinctrl_p;
> +struct pinctrl_state *pinctrl_def;
> +struct pinctrl_state *pinctrl_sleep;
> +
> +/* Reference Count */
> +int pinctrl_rxtx_ref;


But wait. These are just local statics. Surelty you can put these into
struct ux500_msp instead? Here it looks like these will be used for
all ports, so MSP2 will enable the pins requested by MSP1 etc
completely broken. So put it into the struct ux500_msp state
container from ux500_msp_i2s.h where it belongs.

Refer to drivers/tty/serial/amba-pl011.c when in trouble. This
one is a good pinctrl example.

Yours,
Linus Walleij
