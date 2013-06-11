From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 11 Jun 2013 14:06:14 +0200
Subject: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers
 to even numbers
In-Reply-To: <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
References: <201306111328.52679.heiko@sntech.de>
 <201306111329.32749.heiko@sntech.de>
 <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
Message-ID: <201306111406.14850.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 11. Juni 2013, 13:51:56 schrieb Andy Shevchenko:
> On Tue, Jun 11, 2013 at 2:29 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
> > that use the regular mechanisms for storage but allow only even
> > dividers and 1 to be used.
> > 
> > Therefore add a flag that lets _is_valid_div limit the valid dividers
> > to these values. _get_maxdiv is also adapted to return even values
> > for the CLK_DIVIDER_ONE_BASED case.
> 
> Just one nitpick below (I'm okay with current implementation, but you
> might find my proposal useful).
> 
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > 
> > @@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider
> > *divider, unsigned int div)
> > 
> >                 return is_power_of_2(div);
> >         
> >         if (divider->table)
> >         
> >                 return _is_valid_table_div(divider->table, div);
> > 
> > +       if (divider->flags & CLK_DIVIDER_EVEN && div != 1 && (div % 2) !=
> > 0) +               return false;
> > 
> >         return true;
> >  
> >  }
> 
> What if rewrite like
> 
>  if (divider->flags & CLK_DIVIDER_EVEN == 0)
>  return true;
> 
> return div < 2 || div % 2 == 0;

hmm, the current structure is of the form of testing for each feature and 
doing a applicable action if the flag is set. So it also is extensible for 
future flags and checking for the absence of an attribute while the rest of 
the conditionals check for the presence also might make the code harder to 
read.

So for me the current variant somehow looks more intuitive.

But I'll just let the majority decide ;-)


Heiko
