From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Nov 2014 11:30:59 +0100
Subject: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
In-Reply-To: <5456B7B3.60401@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <5456B7B3.60401@gmail.com>
Message-ID: <CACRpkdZ9oYZ10btdvQSAnZhPaxYn_n6JbAUO4h8qadeAiuJq-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 12:01 AM, Kristina Mart?enko
<kristina.martsenko@gmail.com> wrote:

> I ran into this issue as well. Seems that a card-detect flag
> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an
> uninitialized variable, which can lead to the card being reported as
> not present. This patch fixes it for me:
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 03c53b72a2d6..f0e187682d3b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>         struct device_node *np;
>         u32 bus_width;
>         int len, ret;
> -       bool cap_invert, gpio_invert;
> +       bool cap_invert, gpio_invert = false;
>
>         if (!host->parent || !host->parent->of_node)
>                 return 0;
> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>         else
>                 cap_invert = false;
>
> +       gpio_invert = false;
>         ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);
>         if (ret) {
>                 if (ret == -EPROBE_DEFER)
>
> Let me know if this also fixes it for you, and I'll send in a proper
> patch.

Argh how could I make this stupid mistake :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
