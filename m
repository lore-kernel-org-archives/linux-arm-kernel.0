From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Oct 2014 09:11:20 -0700
Subject: [PATCH v9 1/5] thermal: rockchip: add driver for thermal
In-Reply-To: <1413012563-7690-2-git-send-email-caesar.wang@rock-chips.com>
References: <1413012563-7690-1-git-send-email-caesar.wang@rock-chips.com>
 <1413012563-7690-2-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=XHe65wwf8Q9RA0ZDgb5oQLdyjuZDFy4mD01_t6G6WnHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Sat, Oct 11, 2014 at 12:29 AM, Caesar Wang
<caesar.wang@rock-chips.com> wrote:

> +static void rk_tsadcv2_initialize(int reset_mode, int chn, void __iomem *regs,
> +                                 unsigned long hw_shut_temp)
> +{
> +       u32 shutdown_value;
> +
> +       shutdown_value = rk_tsadcv2_temp_to_code(hw_shut_temp);
> +
> +       /* Enable measurements at ~ 10 Hz */
> +       writel_relaxed(0 | TSADCV2_AUTO_TSHUT_POLARITY_HIGH, regs +
> +                      TSADCV2_AUTO_CON);
> +       writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
> +       writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME, regs +
> +                      TSADCV2_AUTO_PERIOD_HT);
> +       writel_relaxed(shutdown_value, regs + TSADCV2_COMP_SHUT(chn));
> +       writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_TIME, regs +
> +                      TSADCV2_HIGHT_INT_DEBOUNCE);
> +       writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME, regs +
> +                      TSADCV2_HIGHT_TSHUT_DEBOUNCE);
> +
> +       if (reset_mode == GPIO)
> +               writel_relaxed(TSADCV2_SHUT_2GPIO_SRC_EN(chn) |
> +                              TSADCV2_INT_SRC_EN(chn), regs +
> +                              TSADCV2_INT_EN);
> +       else
> +               writel_relaxed(TSADCV2_SHUT_2CRU_SRC_EN(chn) |
> +                              TSADCV2_INT_SRC_EN(chn) , regs +
> +                              TSADCV2_INT_EN);
> +
> +       writel_relaxed(TSADCV2_AUTO_SRC_EN(chn) | TSADCV2_AUTO_EN, regs +
> +                      TSADCV2_AUTO_CON);

Aren't you clobbering the polarity here?

NOTE: I didn't do a full review of this driver, just noticed that
while looking at another patch and figure'd I'd respond here, too.
