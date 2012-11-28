From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 28 Nov 2012 21:31:09 +0530
Subject: [RFC 1/2] clk: use struct clk only for external API
In-Reply-To: <1354103571-27394-1-git-send-email-rabin.vincent@stericsson.com>
References: <1354103571-27394-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <CAOh2x=kw11+fGK6G_fKm2CA3TNGnG_mFq1eHeNxQ-B97-Wd_NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 5:22 PM, Rabin Vincent
<rabin.vincent@stericsson.com> wrote:
> In order to provide per-user accounting, this separates the struct clk
> used in the common clock framework into two structures 'struct clk_core'
> and 'struct clk'.  struct clk_core will be used for internal
> manipulation and struct clk will be used in the clock API
> implementation.
>
> In this patch, struct clk is simply renamed to struct clk_core and a new
> struct clk is implemented which simply wraps it.  In the next patch, the
> new struct clk will be used to implement per-user clock enable
> accounting.
>
> There is a rather hacky #define of clk_core to clk for the non-common
> clk case in order to avoid a mass rename of all clk non-common clk
> implementations.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

Hi Rabin,

I reviewed it with help of git diff --word-diff and didn't found any silly
mistake in the replacement of clk with clk_core :)

> diff --git a/drivers/clk/clk-core.h b/drivers/clk/clk-core.h
> +#ifdef CONFIG_COMMON_CLK
> +#define clk_to_clk_core(clk)   ((struct clk_core *)(clk))
> +#define clk_core_to_clk(core)  ((struct clk *)(core))
> +#else
> +#define clk_to_clk_core(clk)   ((clk))
> +#define clk_core_to_clk(core)  ((core))
> +#endif

> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> +struct clk {
> +       struct clk_core clk;
> +};
> +

Isn't something wrong here? For common clk case shouldn't
this be:

> +#define clk_to_clk_core(clk)  (&clk->clk)
> +#define clk_core_to_clk(core) (container_of(clk, ...))  //not getting into the exact format here

Sorry, if i am missing basics.

--
viresh
