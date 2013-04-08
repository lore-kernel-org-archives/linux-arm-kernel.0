From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 08 Apr 2013 10:36:28 -0700
Subject: [v5] clk: add si5351 i2c common clock driver
In-Reply-To: <CABJ1b_T30trVjXps-rSbYTNo1DcPeT8WsZ+M18B9wTJPBnL-gA@mail.gmail.com>
References: <1365139415-17815-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130407225046.GA16326@roeck-us.net> <51620604.4070204@gmail.com>
 <20130408001725.GA16648@roeck-us.net> <51625F9A.1050308@gmail.com>
 <20130408145407.GA12243@roeck-us.net>
 <CABJ1b_T30trVjXps-rSbYTNo1DcPeT8WsZ+M18B9wTJPBnL-gA@mail.gmail.com>
Message-ID: <20130408173628.14359.70620@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2013-04-08 08:38:44)
> On Mon, Apr 8, 2013 at 4:54 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Apr 08, 2013 at 08:11:38AM +0200, Sebastian Hesselbarth wrote:
> >> On 04/08/2013 02:17 AM, Guenter Roeck wrote:
> >> >On Mon, Apr 08, 2013 at 01:49:24AM +0200, Sebastian Hesselbarth wrote:
> >> >>On 04/08/2013 12:50 AM, Guenter Roeck wrote:
> >> >>>On Fri, Apr 05, 2013 at 05:23:35AM -0000, Sebastian Hesselbarth wrote:
> >> >>>>This patch adds a common clock driver for Silicon Labs Si5351a/b/c
> >> >>>>i2c programmable clock generators. Currently, the driver supports
> >> >>>>DT kernels only and VXCO feature of si5351b is not implemented. DT
> >> >>>>bindings selectively allow to overwrite stored Si5351 configuration
> >> >>>>which is very helpful for clock generators with empty eeprom
> >> >>>>configuration. Corresponding device tree binding documentation is
> >> >>>>also added.
> >> >>>>
> >> >>>>Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> >> >>>>Tested-by: Daniel Mack<zonque@gmail.com>
> >> >>>>
> >> >>>[ ... ]
> >> >>>
> >> >>>>+static inline void _si5351_msynth_set_pll_master(
> >> >>>>+ struct si5351_driver_data *drvdata, unsigned char num, int is_master)
> >> >>>>+{
> >> >>>>+ unsigned long flags;
> >> >>>>+
> >> >>>>+ if (num>   8 ||
> >> >>>>+     (drvdata->variant == SI5351_VARIANT_A3&&   num>   3))
> >> >>>>+         return;
> >> >>>>+
> >> >>>>+ flags = __clk_get_flags(drvdata->msynth[num].hw.clk);
> >> >>>>+ if (is_master)
> >> >>>>+         flags |= CLK_SET_RATE_PARENT;
> >> >>>>+ else
> >> >>>>+         flags&= ~CLK_SET_RATE_PARENT;
> >> >>>>+ __clk_set_flags(drvdata->msynth[num].hw.clk, flags);
> >> >>>>+}
> >> >>>>+
> >> >>>Unless I am missing something, neither __clk_get_flags() nor the new
> >> >>>__clk_set_flags is exported.
> >> >>>
> >> >>>Did you try to build and load the driver as module ?
> >> >>
> >> >>Well, good catch. I didn't try to build v5 as a module, but I guess it
> >> >>will fail. But I consider this as something that has to be addressed in
> >> >>clk framework itself, not in this patch. There will be other
> >> >>clk-providers built as module in the future for sure.
> >> >>
> >> >Sure, but you provided the patch to make __clk_set_flags global. To avoid
> >> >build failures, I would suggest to either submit a patch to export the
> >> >missing functions, or to remove the ability to build the driver as module.
> >>
> >> Actually, I knew that __clk_set_flags patch will not be accepted
> >> before posting it ;)
> >>
> > Ah, but part of that is to get you to think about it again, and to defend it if
> > it is really needed. After all, "it can be abused" applies to pretty much every
> > API.
> 
> Guenter,
> 
> I already thought about it a lot and I consider clk api broken in a way here.
> 
> > Key question is if you _really_ need run-time flag modifications, or if you can
> > live with initialization-time settings. If you really need it, you'll have to
> > explain the reasons.
> 
> The question is not if _I_ really need run-time flags but why the api allows to
> perform run-time modifications of the clock hierarchy without allowing different
> flags? There is clk_set_parent() so I guess clk api knows about run-time changes
> already, but you cannot have different flags per parent. And with
> __clk_set_flags()
> rejected, you are not allowed to change the flags.
> 
> I understand that some flags are permanent and required at registration, but
> CLK_SET_PARENT_RATE is not. It is not limited by hardware but limited by api.
> One way would be a more generic clk-mux with per parent flags, but for
> the current
> implementation, I cannot see how clk-mux can be exploited here.
> 

There are a couple of ways to get past this issue.  One is removal of
some of the flags.  I have never liked CLK_SET_RATE_PARENT, since I
think the ability to propagate a rate-change request up to the parent
should be enabled for all clocks.  This is in the interest of the driver
author who does not care to know intimate details of the clock
hierarchy.

When I developed the rate-change propagation code I was likely too hasty
in defining a per-clock flag for that behavior.  It might have been
enough to simply compare the &best_parent_rate value from .round_rate
and compare it against clk->parent->rate.  This means that no flag is
necessary.

This assumes that the .round_rate implementation has enough knowledge to
know whether or not to propagate the rate-change request up to the
parent.  This may not not true for the common divider type.

I'll make some tests on removing this flag (and potentially other flags)
to see how painful it is.

Regards,
Mike

> I can live with it, because then dynamic muxing of clock hierarchy
> within clk-si5351
> is just not supported or will break function. Currently, there is no
> support for dynamic
> muxing, so everything is fine.
> 
> >> >On a side note, do you happen to know anyone working on drivers for Si5319 or
> >> >Si5368 ?
> >>
> >> No.
> >
> > Too bad ... I may have to write that code myself then.
> 
> Well, if clk-si5351 will ever get in mainline kernel, feel free to use
> it as a template ;)
> 
> Sebastian
