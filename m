From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Jun 2010 18:58:35 +0900
Subject: [PATCH] S5PV210 Correct clock source control register properties
In-Reply-To: <AANLkTik78ycpNKYIhdu7SKeQ_9htcjCJlXch5bobUxHq@mail.gmail.com>
References: <1276766116-6839-1-git-send-email-myungjoo.ham@samsung.com>
	<003301cb0ea8$474d1640$d5e742c0$%kim@samsung.com>
	<AANLkTik78ycpNKYIhdu7SKeQ_9htcjCJlXch5bobUxHq@mail.gmail.com>
Message-ID: <005501cb0ecc$d1de38b0$759aaa10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> On Fri, Jun 18, 2010 at 2:36 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > MyungJoo Ham wrote:
> >>
> >> The clock source controls (struct clksrc_clk) have been often accessing
> >> CLK_GATE_IPx, which are for clock gating and are accessed by each clock
> >> as well as the clock source. This duplicated clock issue may incur
> >> lockup problems when there are two modules accessing the same clock with
> >> different names.
> >>
> > Actually, S5V210/S5PC110 CLK_GATE_IPx can disable the clock operation of
> each
> > IP if it is not required. And this reduces dynamic power. CLK_SRC_MASKx is
> > used to control clock mux of each IP's SCLK.
> >
> > Basically CLK_SRC_MASKx is for mux control (output masking) of each IP
> > source, and actually that can _not_ control relevant every source clock of
> > each IP. So CLK_GATE_IPx exists, can do it.
> >
> > I know, in the several case, i.e, camera and fimc, each sclk_xxx need to
> > control. And can be controlled each sclk_xxx by using your patch, but in this
> > case, need to additional control relevant clock gating for dynamic clock
> > gating of each IP in its device driver.
> 
> We've changed clksrc_clk's not to access CLK_GATE_IPx because of the
> duplicated clock (or doppelganger) problem. We need to either get rid
> of ".enable / .ctrlbit" from
> struct clk of struct clksrc_clk, change them to use "CLK_SRC_MASKx",
> or get rid of their twins
> (e.g., "hsmmc" for "mmc_bus") as long as there are clock definitions
> with different names
> accessing the same CLK_GATE_IPx. Letting clksrc_clk access
> CLK_GATE_IPx creates potential
> kernel lockups.
> 
Hmm..duplicated clock problem?

The clk_enable and clk_disable functions maintain a reference count and base the decision about enabling/disabling the clock on the reference count. Could you please explain how kernel lockups will occur in this case (considering the use of reference count in clk_enable and clk_disable)

> Drivers should get clocks defined in "static struct clk init_clocks[],
> init_clocks_disable[]" in order
> to access CLK_GATE_IPx though we still have some missing clocks there;
> e.g., mfc, g2d, and g3d.
> Again, there should be NO duplicated clock definitions if we are going
> to use .enable function that
> accesses the same address & bit.
> 
> ----------- from the previous patch -----------
> Please note that each clock definition should access different control
> register; otherwise, the system may suffer lockups. For example, if we
> have two clock definitions "a" and "b" which access the same register
> (and the shift value). Then, when we do:
> 
>        module B
>        1 clk = clk_get("b");
>        2 clk->clk_enable(clk);
>        3 do something with clk.
>        4 clk->clk_disable(clk);
> 
>        module A
>        1 clk = clk_get("a");
>        2 clk->clk_enable(clk);
>        3 do something with clk
>        4 clk->clk_disable(clk);
> 
>        And if the execution order is
> 
>        B1->B2->A1->A2->A3->A4->B3 ...
> 
>        Then, the system may hang at the point B3.
> ------------------------------------------------------------------------------------
> 
> >
> >> Besides, the clock source control is supposed to control (setting values
> >> of MASK, SRC, DIV), not to turn on/off individual clock.
> >>
> >> Another point is that there are registers (CLK_SRC_MASK0/1) specialized
> >> for masking clock source control in S5PV210/S5PC110 according to the
> >> user manual (rev 20100201).
> >>
> >> Therefore, accessing CLK_SRC_MASK0/1 (rather than accessing
> >> CLK_GATE_IPx) for the clock source control is safer and fits to the
> >> semantics of S5PV210/S5PC110 registers. And fortuneatly, each clock
> >> source defined in clock.c has corresponding bit at CLK_SRC_MASK0/1
> >> except for MFC, G2D, and G3D.
> >>
> >> In this patch,
> >>
> >> - DAC, HDMI, AUDIO 0/1/2, UCLK(uart) 0/1/2/3, MIXER, FIMC 0/1/2,
> >> FIMC, MMC 0/1/2/3, CSIS, SPI 0/1, PWI, and PWM clock sources are
> >> modified to use CLK_SRC_MASK0/1, which were using CLK_GATE_IPx.
> >>
> >> - CAM 0/1 did not have enable/disable control. They now access
> >>   CLK_SRC_MASK0.
> >>
> >> - MFC, G3D, G2D were using CLK_GATE_IPx. However, as there are no clocks
> >>   defined to control MFC, G3D, and G2D, we kept them to access
> >> CLK_GATE_IPx. These may need to be modified (erase .enable, .ctrlbit
> >> from sclk_mfc, sclk_g2d, sclk_g3d and create clocks: g3d, g2d, mfc)
> >> later.
> >>
> > Hmm..need to check about multimedia usage.
> >
> > And in my opinion, it would be helpful to understand that should be short and
> > clear.
> >
> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> ---
> >>  arch/arm/mach-s5pv210/clock.c |  101
> > ++++++++++++++++++++++-------------------
> >>  1 files changed, 55 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> >> index ec5ad8c..08c1063 100644
> >> --- a/arch/arm/mach-s5pv210/clock.c
> >> +++ b/arch/arm/mach-s5pv210/clock.c

(snip)

> >> --
> >
> > I'm not sure that need to control of all sclk_xxx like above method, mux
> > output masking.
> >

Please let me know your opinion about above question based on scenario.

> > Thanks.
> >
> > Best regards,
> > Kgene.
> > --
> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> > SW Solution Development Team, Samsung Electronics Co., Ltd.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> ps. I forgot to erase .enable and .ctrlbit of "sclk_fimc"s. The user
> manual states that
> the three "sclk_fimc" clocks should be controlled identically at the
> same time; thus,
> there should be no individual clock masking control on them. This will
> be done later.
> (we may let them control (0x7<<2) so that they are controlled@the
> same time, however,
> we create "doppelganger" clocks there by doing so.)
> 
> 


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
