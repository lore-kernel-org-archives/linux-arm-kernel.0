From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 11:13:16 +0200
Subject: [PATCH 13/32] dmaengine: ste_dma40: Calculate number of logical
 channels from physical ones
In-Reply-To: <1366279934-30761-14-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYq9QLRaaysc=izGgi53ogf1oRHuCwWKW+rQBbE_UtfnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This change will cost ~25KB of memory, but it's worth the trade-off,
> as it removes a great deal of overhead. It means that instead of only
> allocating memory for the logical channels in use, it does so for all
> available ones, which is 32 per physical channel. However, this now
> means we can remove some platform data and we don't have to worry
> about adding vendor specific variables to Device Tree.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

(...)
>  static struct stedma40_platform_data dma40_plat_data = {
> -       .dev_len = DB8500_DMA_NR_DEV,

So that was set to 64 in the platform...

> -       /* Count the number of logical channels in use */
> -       for (i = 0; i < plat_data->dev_len; i++)
> -               if (plat_data->dev_rx[i] != 0)
> -                       num_log_chans++;
> -
> -       for (i = 0; i < plat_data->dev_len; i++)
> -               if (plat_data->dev_tx[i] != 0)
> -                       num_log_chans++;

And I guess this code snippet made it go down to <= 32 all the time,
correct?

Just want to understand it before I ACK. (The idea is sound.)

I notice there is no check whatsoever of the bounds of
plat_data->dev_[rx|tx]  but that is a different problem I guess...

Yours,
Linus Walleij
