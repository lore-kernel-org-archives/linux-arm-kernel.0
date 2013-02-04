From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Feb 2013 13:25:56 +0100
Subject: [PATCH] rtc: pl031: fix the missing operation on enable
In-Reply-To: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkda_0Uat=Qs3ty38Ygbsucx6dL0J+PmxVq7N_gRzQsEhbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian, sorry for taking too long to reply...

On Wed, Jan 30, 2013 at 2:04 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> RTC control register should be enabled in the process of initliazing.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

(...)
> +       data = readl(ldata->base + RTC_CR);
>         /* Enable the clockwatch on ST Variants */
>         if (vendor->clockwatch)
> -               writel(readl(ldata->base + RTC_CR) | RTC_CR_CWEN,
> -                      ldata->base + RTC_CR);
> +               data |= RTC_CR_CWEN;
> +       writel(data | RTC_CR_EN, ldata->base + RTC_CR);

This last line is *not* OK on the ST Variant. In our hardware that bit
is part of the clock divider, which means it will affect our timekeeping.

Do you want me to submit a follow-up patch?

Yours,
Linus Walleij
