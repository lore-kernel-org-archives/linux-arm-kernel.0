From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 8 Mar 2015 09:46:35 +0100
Subject: [PATCH 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <1425657076-6709-2-git-send-email-carlo@caione.org>
References: <1425657076-6709-1-git-send-email-carlo@caione.org>
 <1425657076-6709-2-git-send-email-carlo@caione.org>
Message-ID: <20150308084635.GA21781@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 04:51:15PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch adds pinctrl support for the AmLogic Meson8b SoC.

Hi Carlo,

> [...]
> +static const unsigned int xtal_24m_pins[]	= { PIN_GPIOY_3 };
> +static const unsigned int iso7816_2_clk_pins[]	= { PIN_GPIOY_13 };
> +static const unsigned int iso7816_2_data_pins[] = { PIN_GPIOY_14 };
> +
> +

Just a nitpick, there is a double empty line here.

> [...]
> +static const unsigned int remote_input_pins[]	= { PIN_GPIOAO_7 };
> +static const unsigned int hdmi_cec_1_pins[]	= { PIN_GPIOAO_12 };
> +static const unsigned int ir_blaster_pins[]	= { PIN_GPIOAO_13 };
> +
> +

The same here.

> [...]
> +/* First GPIO chip */
> +#define GPIOX_0		0
> +#define GPIOX_1		1
> +#define GPIOX_2		2
> +#define GPIOX_3		3
> +#define GPIOX_4		4
> +#define GPIOX_5		5
> +#define GPIOX_6		6
> +#define GPIOX_7		7
> +#define GPIOX_8		8
> +#define GPIOX_9		9
> +#define GPIOX_10	10
> +#define GPIOX_11	11
> +#define GPIOX_16	12

This kind of pin numbering breaks the selection of the bit for a given
pin in meson_calc_reg_and_bit(). Looking at the documentation it seems
that pins GPIOX_12 through 15 are not available but their bit exist in
the register and we must take that into account.

For example GPIOX_10 and GPIOX_11 are associated to bits 10 and 11 of
register 1 for changing the direction and GPIOX_16 to bit 16; but with
the above assignment the function would select bit 12 for GPIOX_16.

The strange thing is that the pins that are missing in the
documentation (as GPIOX12-15, GPIOY_2 and others) not only are defined
but also have some associated mux configuration in Amlogic kernel
sources.

I'm not very familiar with the inner mechanisms of the pinctrl
subsystem, but I guess that holes in the numbering of pins wouldn't be
a problem and thus we can skip the numbers associated to non-existent
pins (i.e. GPIOX_11 -> 11, GPIOX_16 -> 16). Pinctrl experts please
correct me if I'm wrong :)

Or we could just pretend that the missing pins exist even if the
documentation says otherwise.

Beniamino
