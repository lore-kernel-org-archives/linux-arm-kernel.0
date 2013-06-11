From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 11 Jun 2013 14:51:56 +0300
Subject: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers
 to even numbers
In-Reply-To: <201306111329.32749.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
 <201306111329.32749.heiko@sntech.de>
Message-ID: <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 2:29 PM, Heiko St?bner <heiko@sntech.de> wrote:
> SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
> that use the regular mechanisms for storage but allow only even
> dividers and 1 to be used.
>
> Therefore add a flag that lets _is_valid_div limit the valid dividers
> to these values. _get_maxdiv is also adapted to return even values
> for the CLK_DIVIDER_ONE_BASED case.

Just one nitpick below (I'm okay with current implementation, but you
might find my proposal useful).

> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c

> @@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
>                 return is_power_of_2(div);
>         if (divider->table)
>                 return _is_valid_table_div(divider->table, div);
> +       if (divider->flags & CLK_DIVIDER_EVEN && div != 1 && (div % 2) != 0)
> +               return false;
>         return true;
>  }

What if rewrite like

 if (divider->flags & CLK_DIVIDER_EVEN == 0)
 return true;

return div < 2 || div % 2 == 0;


--
With Best Regards,
Andy Shevchenko
