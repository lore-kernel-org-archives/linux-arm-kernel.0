From: dianders@chromium.org (Doug Anderson)
Date: Thu, 17 May 2018 14:22:09 -0700
Subject: [PATCH 2/2] regulator: of: add support for allowed modes
 configuration
In-Reply-To: <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
 <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=Wk_vYcxV+XXvHVdSC4erNB3=_ecMimeUrEw61Po04Rmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 11, 2018 at 6:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> @@ -136,6 +136,33 @@ static void of_get_regulation_constraints(struct device_node *np,
>                 }
>         }
>
> +       len = of_property_count_elems_of_size(np, "regulator-allowed-modes",
> +                                               sizeof(u32));
> +       if (len > 0) {
> +               if (desc && desc->of_map_mode) {
> +                       for (i = 0; i < len; i++) {
> +                               ret = of_property_read_u32_index(np,
> +                                       "regulator-allowed-modes", i, &pval);
> +                               if (ret) {
> +                                       pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
> +                                               np->name, i, ret);
> +                                       break;
> +                               }
> +                               mode = desc->of_map_mode(pval);
> +                               if (mode == REGULATOR_MODE_INVALID)
> +                                       pr_err("%s: invalid regulator-allowed-modes element %u\n",
> +                                               np->name, pval);
> +                               else
> +                                       constraints->valid_modes_mask |= mode;
> +                       }
> +                       if (constraints->valid_modes_mask)
> +                               constraints->valid_ops_mask
> +                                       |= REGULATOR_CHANGE_MODE;

Kinda calls into question the value of REGULATOR_CHANGE_MODE in the
valid_ops_mask if it's just set whenever valid_modes_mask is non-zero,
huh?

> +               } else {
> +                       pr_warn("%s: mode mapping not defined\n", np->name);
> +               }
> +       }
> +

This patch seems good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
