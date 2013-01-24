From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 24 Jan 2013 10:12:49 -0800
Subject: [PATCH 1/4] clk: Introduce optional is_prepared callback
In-Reply-To: <1359045956-30741-2-git-send-email-ulf.hansson@stericsson.com>
References: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
 <1359045956-30741-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130124181249.10623.14484@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2013-01-24 08:45:53)
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> To reflect whether a clk_hw is prepared the clk_hw may implement
> the optional is_prepared callback. If not implemented we fall back
> to use the software prepare counter.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/clk/clk.c            |   21 +++++++++++++++++++++
>  include/linux/clk-provider.h |    6 ++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 593a2e4..deb259a 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -458,6 +458,27 @@ unsigned long __clk_get_flags(struct clk *clk)
>         return !clk ? 0 : clk->flags;
>  }
>  
> +bool __clk_is_prepared(struct clk *clk)
> +{
> +       int ret;
> +
> +       if (!clk)
> +               return false;
> +
> +       /*
> +        * .is_prepared is optional for clocks that can prepare
> +        * fall back to software usage counter if it is missing
> +        */

Why not make it mandatory?  This could be as simple as saying "it is
mandatory", or we could even enforce a check in clk_init, though the
latter suggestion would be noisy until existing clock providers were
updated.

Note that .is_enabled is technically mandatory for any clock that
implements .enable/.disable but there is no check for compliance.  It is
only in Documentation/clk.txt and the kerneldoc.

Regards,
Mike
