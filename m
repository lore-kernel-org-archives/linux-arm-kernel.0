From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 21 Jun 2013 11:20:49 -0700
Subject: [PATCH 21/33 v2] clk: ux500: Add Device Tree support for the PRCC
 Kernel clock
In-Reply-To: <20130619074203.GD31320@laptop>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-22-git-send-email-lee.jones@linaro.org>
 <20130611110923.GB3330@laptop> <201306121646.30279.arnd@arndb.de>
 <20130618211735.9136.25870@quantum> <20130619074203.GD31320@laptop>
Message-ID: <20130621182049.20448.88353@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2013-06-19 00:42:03)
> > Quoting Arnd Bergmann (2013-06-12 07:46:30)
> > > On Tuesday 11 June 2013, Lee Jones wrote:
> > > > This patch enables clocks to be specified from Device Tree via phandles
> > > > to the "prcc-kernel-clock" node.
> > > > 
> > > > Cc: Mike Turquette <mturquette@linaro.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > 
> > > 
> > > I don't understand the design of the common clock subsystem here, but is it really
> > > necessary to hardcode all the clocks using clk_reg_prcc_kclk() here *and* register
> > > a clkdev *and* store the pointer in an array, when you can get all that information
> > > from the device tree?
> > > 
> > > Mike?
> > 
> > I'm a bit confused by what is going on here too.  There are several
> > different ways to handle this.
> > 
> > 1) Since you have your own clock driver (e.g. not the basic clock types)
> > then you could expand the argument list of clk_reg_prcc_kclk to include
> > the clkdev dev_id string and toss the call to clk_register_clkdev inside
> > of clk_reg_prcc_kclk.
> 
> Yes, that's actually a pretty good idea. It has nothing to do with
> this patchset, but I will add it to my TODO.
> 
> NB: I am away from tomorrow until after Connect, so I will continue
> with this after that.
> 
> > 2) Move your clock data into DT and teach the driver to use of_clk_get
> > to fetch the clk phandle directly instead of using the string-matching
> > clkdev mechanisms. Of course both your clock and device bits need to be
> > converted to DT first.
> 
> I'm sure this is the end-goal, but we still have to support the !DT
> case. At least until all of the ATAGs stuff has been completely
> removed from platform.
> 
> > Can you explain what prcc_kclk[] and friends are doing? Is that a legacy
> > clock framework thing that is still hanging around? I'm curious to know
> > why your clock driver needs a list of the clocks it registers.
> 
> Sure.
> 
> 1. So when we register a clock, we store a pointer to it in a 'struct
> clk *array[]' using known cell identifying read-ins. For peripheral
> (pclk) and kernel (kclk) clocks these are peripheral number (the
> kernel clocks have these too) and their associated 8bit register
> enable BIT(). The PRCMU clocks are read-in to the array only by their
> 32bit register enable BIT().
> 
> 2. We then register with of_clk_add_provider() passing the array using
> the 'void *data' argument. So:
> 
>   clk = clk_reg_prcc_[p|k]clk(blah, blah, blah);
>   array[(periph * PRCC_PERIPHS_PER_CLUSTER) + bit] = clk
>   of_clk_add_provider(child, ux500_twocell_get, array);
> 
> 3. In the DTS(I) files we request clocks using their known identifiers
> by way of tuplets for the kclks and pclks and by a 1 #cell variant for
> the PRCMU clocks. So:
> 
> pclk & kclk:
>   /*        pclk/kclk       periph  BIT() */
>   clocks = <&prcc_[p|k]clk  1       9>;
> 
> PRCMU:
>   /*        prcmu       BIT()             */
>   clocks = <&prcmu_clk  PRCMU_DMACLK>;
> 
> The PRCMU can then use the clk framework supplied
> of_clk_src_onecell_get() call-back and the pclk and kclks use the 2
> #cell variant we provide. They both read into the aforementioned
> array[]s we populated earlier in the process to fetch the correct
> 'struct clk*'.

Ok, so I had to re-read that several times. It's probably not a win for
readability but if that is the binding you want then go for it.

For patches #17-23:

Acked-by: Mike Turquette <mturquette@linaro.org>

> 
> -- 
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
