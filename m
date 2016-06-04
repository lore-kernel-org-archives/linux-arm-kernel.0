From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 4 Jun 2016 10:18:40 -0300
Subject: [PATCH] l2c: warn about misconfigured PL310 shared-override
In-Reply-To: <1464705802-11787-1-git-send-email-l.stach@pengutronix.de>
References: <1464705802-11787-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAOMZO5CF6-25dNvYPYSwkV5Ykrr8EQmXyAt37NYdhAhb1KPh=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Tue, May 31, 2016 at 11:43 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index c61996c256cc..d2690f0d3cd0 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -815,6 +815,11 @@ static int __init __l2c_init(const struct l2c_init_data *data,
>                 pr_warn("L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x\n",
>                         old_aux, aux);
>
> +       if (((cache_id & L2X0_CACHE_ID_PART_MASK) == L2X0_CACHE_ID_PART_L310) &&
> +           !(aux & L2C_AUX_CTRL_SHARED_OVERRIDE))
> +               pr_warn("L2C-310 shared attribute override enable not set, "
> +                       "system is non-compliant to ARM specified memory aliasing rules\n");
> +

Should something like "Make sure to set this bit in the bootloader" be
displayed? At least this would give some hint as to where the problem
needs to be fixed.
