From: sboyd@kernel.org (Stephen Boyd)
Date: Sat, 03 Nov 2018 20:02:43 -0700
Subject: [PATCH v6 1/3] clk: meson: add emmc sub clock phase delay driver
In-Reply-To: <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
 <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <154130056376.88331.17004780065573288593@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jianxin Pan (2018-11-01 09:30:53)
> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
> new file mode 100644
> index 0000000..83e74ed
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct meson_clk_phase_delay_data *ph =
> +               meson_clk_get_phase_delay_data(clk);

Nitpick: Do this after declaring variables because it splits a line.

> +       unsigned long period_ps, p, d;
> +       int degrees;
> +
> +       p = meson_parm_read(clk->map, &ph->phase);
> +       degrees = p * 360 / (1 << (ph->phase.width));

Nitpick: Remove useless parenthesis.

> +
> +       period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,

Is the cast necessary?

> +                                clk_hw_get_rate(hw));
> +
> +       d = meson_parm_read(clk->map, &ph->delay);
> +       degrees += d * ph->delay_step_ps * 360 / period_ps;
> +       degrees %= 360;
> +
> +       return degrees;
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct meson_clk_phase_delay_data *ph =
> +               meson_clk_get_phase_delay_data(clk);
> +       unsigned long period_ps, d = 0, r;
> +       u64 p;
> +
> +       p = degrees % 360;

We don't allow phase to be larger than 360 so this isn't needed.

> +       period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,

Drop the cast?

> +                                clk_hw_get_rate(hw));
> +
> +       /* First compute the phase index (p), the remainder (r) is the

Nitpick: Please leave /* on it's own line.

> +        * part we'll try to acheive using the delays (d).
> +        */
> +       r = do_div(p, 360 / (1 << (ph->phase.width)));

Drop useless parenthesis please.

> +       d = DIV_ROUND_CLOSEST(r * period_ps,
> +                             360 * ph->delay_step_ps);
> +       d = min(d, PMASK(ph->delay.width));
> +
> +       meson_parm_write(clk->map, &ph->phase, p);
> +       meson_parm_write(clk->map, &ph->delay, d);
> +       return 0;
> +}
