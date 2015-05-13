From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 13 May 2015 10:09:18 +0200
Subject: [PATCH v2 3/4] clk: add lpc18xx ccu clk driver
In-Reply-To: <20150512223241.16410.79958@quantum>
References: <1430170693-28303-1-git-send-email-manabian@gmail.com>
 <1430170693-28303-4-git-send-email-manabian@gmail.com>
 <20150512223241.16410.79958@quantum>
Message-ID: <CAGhQ9VzvvBCWu2+8zrAvpFRTWr3o9uhOeuucHB39s91fOPk8Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 00:32, Michael Turquette <mturquette@linaro.org> wrote:
> Quoting Joachim Eastwood (2015-04-27 14:38:12)
>> +static int of_clk_get_parent_arg(struct device_node *np, int index)
>> +{
>> +       struct of_phandle_args clkspec;
>> +       int rc;
>> +
>> +       if (index < 0)
>> +               return -EINVAL;
>> +
>> +       rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
>> +                                       &clkspec);
>> +       if (rc)
>> +               return -EINVAL;
>> +
>> +       return clkspec.args_count ? clkspec.args[0] : -EINVAL;
>> +}
>
> Hi Joachim,
>
> I'm not sure why you need this. I guess it is related to my question in
> patch #2 about using clock-indices?

Yes. I basically need the clock id without grabbing the clock using a
clk_get function. See below.

>Can you explain why this function is required?

Since the CCU doesn't act like a normal clock consumer using clk_get
type functions I use this function to retrieve the CGU clock id. This
drivers is used on two CCUs blocks and I need to match the id with one
in the clk_branches array so that the driver itself can be generic.

> Anyways if returning the clock index is something that is really needed
> then why not rename it to "of_clk_get_index" and put it in
> drivers/clk/clk.c?

Okey, I'll do that in the next version if we agree that the function
is still needed.

regards,
Joachim Eastwood
