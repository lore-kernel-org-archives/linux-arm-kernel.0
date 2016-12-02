From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 2 Dec 2016 20:50:21 +0100
Subject: [PATCH 1/2] clk: bcm: Support rate change propagation on
 bcm2835 clocks
In-Reply-To: <87lgvyf956.fsf@eliezer.anholt.net>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480626020-20031-2-git-send-email-boris.brezillon@free-electrons.com>
 <87lgvyf956.fsf@eliezer.anholt.net>
Message-ID: <20161202205021.074fd441@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Dec 2016 11:01:09 -0800
Eric Anholt <eric@anholt.net> wrote:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> > Some peripheral clocks, like the VEC (Video EnCoder) clock need to be set
> > to a precise rate (in our case 108MHz). With the current implementation,
> > where peripheral clocks are not allowed to forward rate change requests
> > to their parents, it is impossible to match this requirement unless the
> > bootloader has configured things correctly, or a specific rate has been
> > assigned through the DT (with the assigned-clk-rates property).
> >
> > Add a new field to struct bcm2835_clock_data to specify which parent
> > clocks accept rate change propagation, and support set rate propagation
> > in bcm2835_clock_determine_rate().
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
> 
> A possible simplification would be to limit VEC to only PLLH_AUX, since
> that was how the HW designers intended it to be used.  Then you could
> just have SET_RATE_PARENT flag, rather than the bitfield.
> 

I can rework the patches to do that if you prefer.

This being said, I already had a similar issue with atmel clocks [1],
where a peripheral requires a specific rate and the periph clk can
take its source from 2 different PLLs: one that is widely used by other
peripherals and which cannot be modified and the other which is not so
widely used and can be customized to generate the rate we need.
Maybe that's something we should address with a generic solution at
some point: clk constraint propagation, clk rate lock or something
else (Mike mentioned another approach here [1]).

In the meantime, the patch here should do the trick for the bcm2835
platform.

> Still, this seems to be correct and fixes the bug.  Both patches are:
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

[1]https://patchwork.kernel.org/patch/6204221/
