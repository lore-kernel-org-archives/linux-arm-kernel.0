From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Feb 2015 09:24:43 -0600
Subject: [PATCH v2 3/4] clk: Provide an always-on clock domain framework
In-Reply-To: <20150223172344.421.62815@quantum>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
 <1424276101-30137-4-git-send-email-lee.jones@linaro.org>
 <20150223172344.421.62815@quantum>
Message-ID: <CAL_Jsq+N4D8fUCwrYwxLaRpbhsgi5eZy5cLpsSmp8VoTQZUqow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 11:23 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Lee Jones (2015-02-18 08:15:00)
>> Much h/w contain clocks which if turned off would prove fatal.  The
>> only way to recover is to restart the board(s).  This driver takes
>> references to clocks which are required to be always-on in order to
>> prevent the common clk framework from trying to turn them off during
>> the clk_disabled_unused() procedure.

[...]

>> +static int ao_clock_domain_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       int nclks, i;
>> +
>> +       nclks = of_count_phandle_with_args(np, "clocks", "#clock-cells");
>
> Minor nitpick: please use of_clk_get_parent_count. I spent a solid 5
> minutes writing that function and I need people to use it so I can get a
> return on my investment.
>
> Otherwise the patch looks good. I believe that this method is targeting
> always-on clock in a production environment, which is different from the
> CLK_IGNORE_UNUSED stuff which typically is helpful while bringing up new
> hardware or dealing with a platform that has incomplete driver support.

There is also the usecase of keep clocks on until I load a module that
properly handles my hardware (e.g simplefb). We have a simplefb node
with clocks and the simplefb driver jumps thru some hoops to hand-off
clocks to the real driver. I don't really like it and don't want to
see more examples. And there is the case of I thought I would never
manage this clock, but kernel subsystems evolve and now I want to
manage a clock. This should not require a DT update to do so.

Neither of these may be Lee's usecase, but I want to see them covered
by the binding.

> I wonder if there is a clever way for existing clock providers
> (expressed in DT) to use this without having to create a separate node
> of clocks with the "always-on-clk-domain" flag. Possibly the common
> clock binding could declare some always-on flag that is standardized?
> Then the framework core could use this code easily. Not sure if that is
> a good idea though...

I would prefer to see the always on clocks just listed within the
clock controller's node rather than creating made up nodes with clock
properties. This should be always-on until claimed IMO, but that
aspect is the OS's problem, not a DT problem.

Rob
