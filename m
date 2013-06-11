From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 11 Jun 2013 15:37:27 +0300
Subject: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers
 to even numbers
In-Reply-To: <201306111406.14850.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
 <201306111329.32749.heiko@sntech.de>
 <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
 <201306111406.14850.heiko@sntech.de>
Message-ID: <CAHp75VeQOSns1nL7p+rU1TS2stPuWibFtN_K9mFvzuGW+3WqOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 3:06 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 11. Juni 2013, 13:51:56 schrieb Andy Shevchenko:
>> On Tue, Jun 11, 2013 at 2:29 PM, Heiko St?bner <heiko@sntech.de> wrote:

[]

>> > @@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider
>> > *divider, unsigned int div)
>> >
>> >                 return is_power_of_2(div);
>> >
>> >         if (divider->table)
>> >
>> >                 return _is_valid_table_div(divider->table, div);
>> >
>> > +       if (divider->flags & CLK_DIVIDER_EVEN && div != 1 && (div % 2) !=
>> > 0) +               return false;
>> >
>> >         return true;
>> >
>> >  }
>>
>> What if rewrite like
>>
>>  if (divider->flags & CLK_DIVIDER_EVEN == 0)
>>  return true;
>>
>> return div < 2 || div % 2 == 0;
>
> hmm, the current structure is of the form of testing for each feature and
> doing a applicable action if the flag is set. So it also is extensible for
> future flags and checking for the absence of an attribute while the rest of
> the conditionals check for the presence also might make the code harder to
> read.
>
> So for me the current variant somehow looks more intuitive.

This variant I think fits:

if (!(divider->flags & CLK_DIVIDER_EVEN))
  return div < 2 || div % 2 == 0;

You check for feature and do accordingly.

--
With Best Regards,
Andy Shevchenko
