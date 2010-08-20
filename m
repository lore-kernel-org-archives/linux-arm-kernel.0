From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 20 Aug 2010 11:50:49 +0200
Subject: [PATCH] ARM: COLIBRI PXA320: fix UCB1400 irq autoprobing
In-Reply-To: <AANLkTiktCBNjwN6gfLMv6=BQnGvujbdGPZKk+o+yXqah@mail.gmail.com>
References: <AANLkTinxeEbZqwdB=bzC=ZZFqk1iR28yv=ECYRFNeUE=@mail.gmail.com>
	<20100811143345.GU17833@buzzloop.caiaq.de>
	<201008112326.20098.marek.vasut@gmail.com>
	<20100818115008.GI17833@buzzloop.caiaq.de>
	<AANLkTiktCBNjwN6gfLMv6=BQnGvujbdGPZKk+o+yXqah@mail.gmail.com>
Message-ID: <20100820095049.GO17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 12:34:35PM +0400, Yuri Ludkevich wrote:
> 2010/8/18 Daniel Mack <daniel@caiaq.de>
> >  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.gitwork
> >
> > (not that "work" ist the branch you'll need to work on).
> >
> > You'll see that colibri-pxa320.c looks a lot different now, so your
> > patch should be a one-liner now.
> >
> > Also, more testing of this code is certainly appreciated :)
> >
> 
> I have looked at code and I have couple of questions about colibri-pxa320.c
> and colibri-evalboard.c:
> Why colibri_pxa320_evalboard_pin_config[] placed in colibri-pxa320.c, not in
> evalboard?

This is because the evalboard code is supposed to be common for
different modules which are based on different SoCs. As the pin
definitions for PXA270 and PXA3xx aren't common in the mfp-* header
files, these arrays need to be placed in the SoC-specific part.

> Why there is no defconfig for colibri pxa320?

There is a defconfig for *all* PXA3xx based machines, creating a hybrid
kernel to boot on all of them.

> BTW: we have our own board which very similar to colibri evalboard - same
> RTC, UCB1400 as sound and touch controller. But we have USB hub onboard, do
> not use FFUART and use 800x600 screen - so we make our own file with board
> init stuff. 

The idea of splitting the code is to have everything you can't change
with your own base board design (ie, the module itself) in one file and
all the rest in another.

The base board you're using is then passed to the kernel as runtime
parameter, so you can boot the same kernel in different envoronments.
The code for this parameter isn't there yet as there is only one user
so far, but it's trivial to add.

Have a look at the code in colibri-pxa270.c and colibri-pxa270-income.c.
The "income" is a custom base board for the pxa270 module, and what you
need is actually exactly the same approach, but for the pxa3xx.
Just add a core_param called colibri_pxa320_baseboard and then call the
appropriate pxa3xx_mfp_config() for the selected board.

> May be colibri_pxa320_evalboard_pin_config[] and
> pxafb_mode_info/pxa_fb_mach info structures also can be moved to evalboard
> file?

No, due to the MFPs, it can't.


Daniel
