From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Jun 2013 14:17:35 -0700
Subject: [PATCH 21/33 v2] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <201306121646.30279.arnd@arndb.de>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <20130611110923.GB3330@laptop> <201306121646.30279.arnd@arndb.de>
Message-ID: <20130618211735.9136.25870@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2013-06-12 07:46:30)
> On Tuesday 11 June 2013, Lee Jones wrote:
> > This patch enables clocks to be specified from Device Tree via phandles
> > to the "prcc-kernel-clock" node.
> > 
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> 
> I don't understand the design of the common clock subsystem here, but is it really
> necessary to hardcode all the clocks using clk_reg_prcc_kclk() here *and* register
> a clkdev *and* store the pointer in an array, when you can get all that information
> from the device tree?
> 
> Mike?

I'm a bit confused by what is going on here too.  There are several
different ways to handle this.

1) Since you have your own clock driver (e.g. not the basic clock types)
then you could expand the argument list of clk_reg_prcc_kclk to include
the clkdev dev_id string and toss the call to clk_register_clkdev inside
of clk_reg_prcc_kclk.

2) Move your clock data into DT and teach the driver to use of_clk_get
to fetch the clk phandle directly instead of using the string-matching
clkdev mechanisms. Of course both your clock and device bits need to be
converted to DT first.

Can you explain what prcc_kclk[] and friends are doing? Is that a legacy
clock framework thing that is still hanging around? I'm curious to know
why your clock driver needs a list of the clocks it registers.

Regards,
Mike

> 
>         Arnd
