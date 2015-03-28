From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 28 Mar 2015 11:06:43 +0100
Subject: [PATCH v3 3/3] pinctrl: Add support for Meson8b
In-Reply-To: <1426800852-1235-4-git-send-email-carlo@caione.org>
References: <1426800852-1235-1-git-send-email-carlo@caione.org>
 <1426800852-1235-4-git-send-email-carlo@caione.org>
Message-ID: <20150328100643.GA21693@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 10:34:12PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch adds support for the AmLogic Meson8b SoC.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/pinctrl/meson/Makefile          |   2 +-
>  drivers/pinctrl/meson/pinctrl-meson.c   |   4 +
>  drivers/pinctrl/meson/pinctrl-meson.h   |   1 +
>  drivers/pinctrl/meson/pinctrl-meson8b.c | 900 ++++++++++++++++++++++++++++++++
>  include/dt-bindings/gpio/meson8b-gpio.h |  32 ++
>  5 files changed, 938 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson8b.c
>  create mode 100644 include/dt-bindings/gpio/meson8b-gpio.h
>
> [...]
>
> +static struct meson_bank meson8b_banks[] = {
> +	/*   name    first                      last                   pullen  pull    dir     out     in  */
> +	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
> +	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
> +	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
> +	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
> +	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
> +	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
> +	BANK("DIF",  PIN(DIF_0_P, DIF_OFF),	PIN(DIF_4_N, DIF_OFF), 5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
> +};

So DIF pins belong to the standard domain and this is ok since they
use the same range of registers of other non-AO pins, but see below...

> +
> +static struct meson_bank meson8b_ao_banks[] = {
> +	/*   name    first                  last                      pullen  pull    dir     out     in  */
> +	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
> +};
> +
> 
> [...]
>
> --- /dev/null
> +++ b/include/dt-bindings/gpio/meson8b-gpio.h
> @@ -0,0 +1,32 @@
> +
> +#ifndef _DT_BINDINGS_MESON8B_GPIO_H
> +#define _DT_BINDINGS_MESON8B_GPIO_H
> +
> +#include <dt-bindings/gpio/meson8-gpio.h>
> +
> +/* GPIO Bank DIF */
> +#define DIF_0_P		0
> +#define DIF_0_N		1
> +#define DIF_1_P		2
> +#define DIF_1_N		3
> +#define DIF_2_P		4
> +#define DIF_2_N		5
> +#define DIF_3_P		6
> +#define DIF_3_N		7
> +#define DIF_4_P		8
> +#define DIF_4_N		9
> +
> +#endif /* _DT_BINDINGS_MESON8B_GPIO_H */

... however these definitions start from 0 and thus overlap with the
definitions in meson8-gpio.h.

This means that the following GPIO specifier in a DTS:

   gpios = <&gpio DIF_0_P GPIO_ACTIVE_HIGH>

has the same effect as

   gpios = <&gpio GPIOX_0 GPIO_ACTIVE_HIGH>

I think that DIF_* pins should have a different numbering, for example
starting just after the end of the last non-AO pin. AO pin should also
be shifted accordingly.

Beniamino
