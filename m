From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Sep 2014 12:09:10 -0300
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <20140915144803.GL18566@dragon>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
 <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
 <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
 <CAOMZO5DJZHKAV4Y9aUwMNWZqhoLrKrsZdYnKqPem2ZSy=-oAYw@mail.gmail.com>
 <20140915115855.GC23877@audiosh1> <20140915144803.GL18566@dragon>
Message-ID: <CAOMZO5DOPgLz3UMvVbJh33AuQfbs0G7XTCvTnVePHrpSyXiHiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 11:48 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Shengjiu,
>
> Your analysis is right.  I hope the following change will get the shared
> gate clock code eventually does the right thing.
>
> Shawn
>
> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
> index 84acdfd1d715..89abdf738dc9 100644
> --- a/arch/arm/mach-imx/clk-gate2.c
> +++ b/arch/arm/mach-imx/clk-gate2.c
> @@ -97,7 +97,7 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
>         struct clk_gate2 *gate = to_clk_gate2(hw);
>
>         if (gate->share_count)
> -               return !!(*gate->share_count);
> +               return !!__clk_get_enable_count(hw->clk);
>         else
>                 return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);

This fixes the audio playback, thanks. Tested on a mx6qsabresd and
also on mx6sx sdb:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
