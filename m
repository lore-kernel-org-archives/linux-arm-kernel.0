From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 16:35:46 +0900
Subject: [PATCH 13/14] ARM: S5PV310: Add video clocks
In-Reply-To: <AANLkTikreMifRgd8kkvcmjZoRZ0fEAcHqWExaOikzE6v@mail.gmail.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
	<1282140084-10265-14-git-send-email-kgene.kim@samsung.com>
	<AANLkTincrZWhrb8fcrdL2QNtZTbgBB-pAYzTf8cq6Zn7@mail.gmail.com>
	<AANLkTikreMifRgd8kkvcmjZoRZ0fEAcHqWExaOikzE6v@mail.gmail.com>
Message-ID: <00b901cb403a$52c69d20$f853d760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> On Thu, Aug 19, 2010 at 7:04 PM, MyungJoo Ham
> <myungjoo.ham@samsung.com> wrote:
> > On Wed, Aug 18, 2010 at 11:01 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> >> From: Jongpill Lee <boyko.lee@samsung.com>
> >>
> >> This patch adds video clocks for S5PV310/S5PC210.
> >>
> >> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> ---
> >>  arch/arm/mach-s5pv310/clock.c |   74
> +++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 74 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
> >> index 14c9707..04bde94 100644
> >> --- a/arch/arm/mach-s5pv310/clock.c
> >> +++ b/arch/arm/mach-s5pv310/clock.c
> >> @@ -506,6 +506,78 @@ static struct clksrc_sources clkset_group = {
> >>        .nr_sources     = ARRAY_SIZE(clkset_group_list),
> >>  };
> >>
> >> +static struct clksrc_clk clk_sclk_mipidphy4l = {
> >> +       .clk    = {
> >> +               .name           = "sclk_mipidphy4l",
> >> +               .id             = -1,
> >> +               .enable         = s5pv310_clk_ip_lcd0_ctrl,
> >> +               .ctrlbit        = (1 << 4),
> >> +       },
> >> +       .sources        = &clkset_group,
> >> +       .reg_src        = { .reg = S5P_CLKSRC_LCD0, .shift = 12, .size = 4 },
> >> +       .reg_div        = { .reg = S5P_CLKDIV_LCD0, .shift = 16, .size = 4 },
> >> +};
> >
> > It appears that clk_ip_lcd0[4](CLK_SMMUFIMD0) is not for this clock
> > source. This SCLK_MIPIDPHY4L seems to be masked by
> > CLK_SRC_MASK_LCD0[12] (MIPI0_MASK)
> 
Ok...you're right.

> Um... As CLK_SRC_MASK_LCD0[12] (MIPI0_MASK) controls MUX_MIPI0, it
> masks both SCLK_MIPIDPHY4L and SCLK_MIPI0. Then, it seems that we
> cannot mask SCLK_MIPIDPHY4L and SCLK_MIPI0 independently.
> 
> Then, what about not adding .enable entry for both "sclk_mipidphy4l"
> and "sclk_mipi" (which is added in the PATCH 14/14)? Affecting another
> clock source with one does not look good.
> 
Hmm...yeah, I agree with you. I will think about that again.

Thank you for your pointing out.

> >
> >> +
> >> +static struct clksrc_clk clk_sclk_mipidphy2l = {
> >> +       .clk    = {
> >> +               .name           = "sclk_mipidphy2l",
> >> +               .id             = -1,
> >> +               .enable         = s5pv310_clk_ip_lcd1_ctrl,
> >> +               .ctrlbit        = (1 << 4),
> >> +       },
> >> +       .sources        = &clkset_group,
> >> +       .reg_src        = { .reg = S5P_CLKSRC_LCD1, .shift = 12, .size = 4 },
> >> +       .reg_div        = { .reg = S5P_CLKDIV_LCD1, .shift = 16, .size = 4 },
> >> +};
> >
> > Appears to have the similar issue with the previous clock source
> 
> Same with above.
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
