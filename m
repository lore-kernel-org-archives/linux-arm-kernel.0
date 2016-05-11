From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 11 May 2016 18:53:10 +0800
Subject: [PATCH 1/2] regulator: Add support for parsing operation mode
In-Reply-To: <1462957929-20105-2-git-send-email-henryc.chen@mediatek.com>
References: <1462957929-20105-1-git-send-email-henryc.chen@mediatek.com>
 <1462957929-20105-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <CAGS+omBy4neiPwQ60x6m4SRHFUkp_v80t+swQUL8JF45Uph+yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henry,

On Wed, May 11, 2016 at 5:12 PM, Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Some regulators support their operating mode to be changed by
> consumers for module specific purpose.
>
> This patch adds support to parse those properties and fill the
> regulator constraints so the regulator core can call the
> regualtor_set_mode to change the modes.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 10 ++++++++++
>  drivers/regulator/of_regulator.c                          | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index ecfc593..88f98f0 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -49,6 +49,16 @@ Optional properties:
>         0: Disable active discharge.
>         1: Enable active discharge.
>         Absence of this property will leave configuration to default.
> +- regulator-allow-change-mode: allow the regulator mode to be configured

As mentioned by broonie earlier, the explicit 'allow' property is
redundant, if regulator-supported-modes is present, then set
REGULATOR_CHANGE_MODE invalid_ops_mask , else leave it clear.

> +- regulator-supported-modes: Regulators can run in a variety of different operating
> +  modes depending on output load. This allows further system power savings by
> +  selecting the best (and most efficient) regulator mode for a desired load.
> +  The definition for each of these operation is defined at
> +  include/linux/regulator/consumer.h
> +       0: FAST.
> +       1: NORMAL.
> +       2: IDLE.
> +       3: STANDBY.
>
>  Deprecated properties:
>  - regulator-compatible: If a regulator chip contains multiple
> diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
> index 6b0aa80..12fe8c8 100644
> --- a/drivers/regulator/of_regulator.c
> +++ b/drivers/regulator/of_regulator.c

Also, I thought binding document changes are generally in a separate
patch from their implementation.

-Dan

> @@ -167,6 +167,20 @@ static void of_get_regulation_constraints(struct device_node *np,
>                 suspend_state = NULL;
>                 suspend_np = NULL;
>         }
> +
> +       if (of_property_read_bool(np, "regulator-allow-change-mode"))
> +               constraints->valid_ops_mask |= REGULATOR_CHANGE_MODE;
> +
> +       ret = of_property_count_elems_of_size(np,
> +                                             "regulator-supported-modes",
> +                                             sizeof(u32));
> +       for (i = 0; i < ret; i++) {
> +               u32 mode;
> +
> +               of_property_read_u32_index(np, "regulator-supported-modes",
> +                                          i, &mode);
> +               constraints->valid_modes_mask |= (1 << mode);
> +       }
>  }
>
>  /**
> --
> 1.8.1.1.dirty
>
