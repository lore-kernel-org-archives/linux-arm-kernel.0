From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 25 Aug 2017 16:28:46 -0700
Subject: [PATCH 04/11] watchdog: ftwdt010: Add clock support
In-Reply-To: <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org>
 <20170814160536.GC7025@roeck-us.net>
 <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com>
Message-ID: <20170825232846.GR21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Linus Walleij wrote:
> On Mon, Aug 14, 2017 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Side note: Maybe we _should_ introduce devm_watchdog_clk_prepare_enable()
> > since this problem affects several watchdog drivers.
> 
> Hmmmmmmmmm a special watchdog primitive may be apropriate.
> Dunno what the clk maintainers think?
> 
> Stephen/Mike: do you like that or would you rather see a primitive
> inside the clock subsystem for this?
> 

devm_clk_prepare_enable() was already proposed and then the
thread went quiet. Re-kickstart it?

I'd still prefer we just disable clks on clk_put(), but Russell
said we needed to fix all non-common clk implementations of the
clk API to do that and then I forgot about the topic (so
anti-climatic). I'm pretty much OK with us merging the temporary
solution. We can churn again later and remove it all once we
convert everything into one CCF.

I'd prefer we also change common clk framework to actually do the
disable on put though so we flush out any issues early. If the
two things are packaged together I would be ultra happy. It's not
like people are going to convert to CCF just so they can get clk
disable on clk_put() as a feature, but at least we can have it as
a feature.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
