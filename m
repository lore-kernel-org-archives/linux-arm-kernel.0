From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 19:22:36 +0900
Subject: [PATCH v4] S5PV210 Correct clock register properties
In-Reply-To: <4C22EF73.8030108@samsung.com>
References: <1277356687-9500-1-git-send-email-myungjoo.ham@samsung.com>
	<4C22EF73.8030108@samsung.com>
Message-ID: <010e01cb1387$2ef32330$8cd96990$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> Hi,

Hi :-)

> 
> On 6/24/2010 2:18 PM, MyungJoo Ham wrote:
> > 1. Corrected shift values of I2S and UART clocks (CLK_GATE_IP3), which were
> > defined incorrectly.
> >
> > 2. Corrected shift values of sclk_audio, uclk1, sclk_fimd, sclk_mmc,
> > sclk_spi, sclk_pwm, which had duplicated .enable/.ctrlbit with their
> > twins defined in struct clk init_clocks_disable[] and struct clk
> > init_clocks[]. We've changed their .enable/.ctrlbit to use CLK_SRC_MASK
> > register to avoid the duplicated clock problem described below.
> >
> > --- Duplicated Clock Problem ---
> > Please note that each clock definition should access different control
> > register; otherwise, the system may suffer lockups. For example, if we
> > have two clock definitions "a" and "b" which access the same register
> > (and the shift value). Then, when we do:
> >
> > 	module A
> > 	clk = clk_get("a");
> > 	clk->clk_enable(clk);
> >
> > 	module B (context switch)
> > 	clk = clk_get("b");
> > 	clk->clk_enable(clk);
> > 	do something with clk.
> > 	clk->clk_disable(clk);
> >
> > 	module A (context switch)
> > 	do something with clk
> > 	* At this point, the system may hang.
> >
> > Therefore, there should be no clock definitions with the same contol
> > register/shift. If we need to create "aliases", then, creating child
> > clocks sharing the clock should be fine.
> >
> > 3. Corrected other sclk_* shift values and access registers.
> >
> >
> > Note that becuase UART clocks are properly disabled at boot time with
> > this patch, UART drivers or somebody else should turn on the clock
> > to read the console; otherwise, JIG willl not show any message.
> >
> >
> > Note that this patch revises and merges the two previous patches:
> > [PATCH] S5PV210 Correct clock register properties
> > [PATCH] S5PV210 Correct clock source control register properties
> > And follows the previous patch
> > [PATCH v2] S5PV210 Correct clock register properties
> > [PATCH v3] S5PV210 Correct clock register properties
> >
> 
> The history about patch is better to go to below --- line. The contents
> of below --- line aren't included to commit message at the git.
> 
Yes, right.

One more, already there is '---' in above comments :-(

> >
> > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> 
> Here.
> 
> >  arch/arm/mach-s5pv210/clock.c |  115 ++++++++++++++++++++++---------------
> ----
> >  1 files changed, 62 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> > index 154bca4..b3d156c 100644
> > --- a/arch/arm/mach-s5pv210/clock.c
> > +++ b/arch/arm/mach-s5pv210/clock.c

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
