From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 09:24:05 -0700
Subject: [PATCH 06/13] clk: versatile-icst: convert to use regmap
In-Reply-To: <CACRpkdYHJzj_1yNFWcwXh+-3zTzJOSEttZdhZBqkUn1HigZeJA@mail.gmail.com>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-7-git-send-email-linus.walleij@linaro.org>
 <20151015190809.GL4558@codeaurora.org>
 <CACRpkdYHJzj_1yNFWcwXh+-3zTzJOSEttZdhZBqkUn1HigZeJA@mail.gmail.com>
Message-ID: <20151023162405.GA19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23, Linus Walleij wrote:
> On Thu, Oct 15, 2015 at 9:08 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 10/15, Linus Walleij wrote:
> >> @@ -151,10 +174,19 @@ struct clk *icst_clk_register(struct device *dev,
> >>       init.flags = CLK_IS_ROOT;
> >>       init.parent_names = (parent_name ? &parent_name : NULL);
> >>       init.num_parents = (parent_name ? 1 : 0);
> >> +     icst->map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
> >> +     if (IS_ERR(icst->map)) {
> >> +             int ret;
> >> +
> >> +             pr_err("could not initialize ICST regmap\n");
> >> +             kfree(icst);
> >> +             ret = PTR_ERR(icst->map);
> >
> > drivers/clk/versatile/clk-icst.c:183
> > icst_clk_register() error: dereferencing freed memory 'icst'
> > drivers/clk/versatile/clk-icst.c:184
> > icst_clk_register() warn: possible memory leak of 'pclone'
> 
> The pclone warning is correct, nice catch. (Fixing it.)
> 
> But for the second warning, whatever static checker you're
> using for this is unable to handle error pointers:
> 
>     clk = clk_register(dev, &icst->hw);
>     if (IS_ERR(clk))
>         kfree(icst);
> 
>     return clk;
> 
> It is quite obvious that returning clk (which may be an error code)
> is OK here.
> 
> If you want, I may need to add some specific annotation to shut
> up the static checker, any hints?
> 

Huh? I'm totally lost. I use sparse and smatch.

> >> +             kfree(icst);
> >> +             ret = PTR_ERR(icst->map);

We just freed icst, and then we dereferenced it in the next line.
What does that have to do with error pointers?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
