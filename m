From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 11 Apr 2017 10:59:56 +0800
Subject: [PATCH 2/2] ARM: dts: imx7: add USDHC NAND clock to SDHC instances
In-Reply-To: <c95a7f535296623bdd4e4a640b3c27f5@agner.ch>
References: <20170330005029.6472-1-stefan@agner.ch>
 <20170330005029.6472-2-stefan@agner.ch>
 <20170401030312.GB24882@b29396-OptiPlex-7040>
 <5c8339900fa1bd6215fb94d4386f7e06@agner.ch>
 <CAOMZO5CprxqnqRXMFJLBAgYAZGGnXNs3ZciyVz_mSLRnnSQQRQ@mail.gmail.com>
 <CAOMZO5A7QQEe5rgBbJBzo8GY41aYV9WA8e9teCUROyihg0kq_g@mail.gmail.com>
 <c95a7f535296623bdd4e4a640b3c27f5@agner.ch>
Message-ID: <20170411025956.GA9067@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 07:36:01PM -0700, Stefan Agner wrote:
> On 2017-04-04 19:15, Fabio Estevam wrote:
> > On Sun, Apr 2, 2017 at 2:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
> >> On Sat, Apr 1, 2017 at 1:15 AM, Stefan Agner <stefan@agner.ch> wrote:
> >>
> >>> IMX7D_IPG_ROOT_CLK is currently not a valid clock in upstream... So we
> >>> would have to add it to the clock driver first.
> >>>
> >>> I guess we could/should add it anyway at one point? But probably also as
> >>> init on, just to make sure Linux does not disable it since it is
> >>> currently used by several IPs implicitly.
> >>
> >> Yes, I made a previous attempt do add  IMX7D_IPG_ROOT_CLK and it did
> >> not work as I did not put it in the init_on clock list.
> >>
> >> Will submit a new patch adding it to init_on, thanks.
> > 
> > I thought that adding IMX7D_IPG_ROOT_CLK would do the trick, but the
> > patch below also causes the kernel to not boot:
> > 
> > --- a/drivers/clk/imx/clk-imx7d.c
> > +++ b/drivers/clk/imx/clk-imx7d.c
> > @@ -386,7 +386,7 @@ static int const clks_init_on[] __initconst = {
> >         IMX7D_PLL_SYS_MAIN_480M_CLK, IMX7D_NAND_USDHC_BUS_ROOT_CLK,
> >         IMX7D_DRAM_PHYM_ROOT_CLK, IMX7D_DRAM_ROOT_CLK,
> >         IMX7D_DRAM_PHYM_ALT_ROOT_CLK, IMX7D_DRAM_ALT_ROOT_CLK,
> > -       IMX7D_AHB_CHANNEL_ROOT_CLK,
> > +       IMX7D_AHB_CHANNEL_ROOT_CLK, IMX7D_IPG_ROOT_CLK,
> >  };
> > 
> >  static struct clk_onecell_data clk_data;
> > @@ -788,7 +788,7 @@ static void __init imx7d_clocks_init(struct
> > device_node *ccm_node)
> >         clks[IMX7D_WRCLK_ROOT_DIV] =
> > imx_clk_divider2("wrclk_post_div", "wrclk_pre_div", base + 0xbd00, 0,
> > 6);
> >         clks[IMX7D_CLKO1_ROOT_DIV] =
> > imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0,
> > 6);
> >         clks[IMX7D_CLKO2_ROOT_DIV] =
> > imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0,
> > 6);
> > -
> > +       clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk",
> > "ahb_root_clk", base + 0x9080, 0, 2);
> >         clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk",
> > "arm_a7_div", base + 0x4000, 0);
> >         clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk",
> > "arm_m4_div", base + 0x4010, 0);
> >         clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk",
> > "arm_m0_div", base + 0x4020, 0);
> 
> Hm, imx_clk_divider2 sets CLK_SET_RATE_PARENT, maybe that influences the
> parent?
> 
> I guess we actually don't want the clock framework to change that clock
> rate, not sure whether we can freeze it or similar.
> 

This is caused by ahb_root_clk gets disabled accidently and system hangs.

Because this patch defines ipg_root_clk earlier before its parent
(ahb_root_clk) got registered, then it will be marked as a orphan clk
temporarily. Until the parent ahb_root_clk got registered, the clk core
will reparent it to the newly found parent. (see __clk_core_init() function).

Due to CLK_SET_RATE_PARENT flag, the ahb clk will be enabled during
set_parent operation and then disabled after that.
Then system hang cause we still get no chance to run init_on clks.

I just send out a proper fix patch with correct register sequence.

Probably we can switch all imx clk driver to CLK_IS_CRITICAL for critical
clocks in the future, but that's another thing to do later.

Stefan,
I think you can just resend your series based on my patches.

Regards
Dong Aisheng

> --
> Stefan
