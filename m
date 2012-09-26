From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Thu, 27 Sep 2012 00:17:56 +0530
Subject: [PATCH 10/10] ARM: msm: Migrate to common clock framework
In-Reply-To: <1348194419-11486-11-git-send-email-sboyd@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-11-git-send-email-sboyd@codeaurora.org>
Message-ID: <CADTbHxpOJ+5xMQ8NkntQtFezwsryzvMDBx8eroNjzfp_5b0DfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> -static int pc_clk_set_rate(unsigned id, unsigned rate)
> +static int pc_clk_set_rate(struct clk_hw *hw, unsigned long new_rate,
> +                          unsigned long p_rate)
>  {
> -       /* The rate _might_ be rounded off to the nearest KHz value by the
> +       struct clk_pcom *p = to_clk_pcom(hw);
> +       unsigned id = p->id, rate = new_rate;
> +       int rc;
> +
> +       /*
> +        * The rate _might_ be rounded off to the nearest KHz value by the
>          * remote function. So a return value of 0 doesn't necessarily mean
>          * that the exact rate was set successfully.
>          */
> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
> -       if (rc < 0)
> -               return rc;
> -       else
> -               return (int)id < 0 ? -EINVAL : 0;
> -}
> -
> -static int pc_clk_set_min_rate(unsigned id, unsigned rate)
> -{
> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
> -       if (rc < 0)
> -               return rc;
> +       if (p->flags & CLKFLAG_MIN)
> +               rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);

You are missing if condition here checking the rc ?

>         else
> -               return (int)id < 0 ? -EINVAL : 0;
> -}
> -
> -static int pc_clk_set_max_rate(unsigned id, unsigned rate)
> -{
> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MAX_RATE, &id, &rate);

and else here i think for the MIN_FLAG if check.

> +               rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
>         if (rc < 0)
>                 return rc;
>         else
>                 return (int)id < 0 ? -EINVAL : 0;
>  }
>
--
Pankaj Jangra
