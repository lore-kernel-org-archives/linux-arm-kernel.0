From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 28 Oct 2014 09:14:35 -0700
Subject: [PATCH RFC v2 1/8] pinctrl: Add driver for Zynq
In-Reply-To: <CACRpkdaPiXiDegibiaqGdFxApowNEmbG0L4RDJVv-t+xhGBmjA@mail.gmail.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-2-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdaPiXiDegibiaqGdFxApowNEmbG0L4RDJVv-t+xhGBmjA@mail.gmail.com>
Message-ID: <c465a69d1c6e48bca66cc29a1692c13a@BL2FFO11FD015.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-28 at 03:53PM +0100, Linus Walleij wrote:
> On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > changes since RFC:
> >  - use syscon/regmap to access registers in SLCR space
> >  - add pinctrl to zc702 DT
> >  - rebase to 3.18: rename enable -> set_mux
> >  - add kernel-doc
> >  - support pinconf
> >    - supported attributes
> >      - pin-bias: pull up, tristate, disable
> >      - slew-rate: 0 == slow, 1 == fast; generic pinconf does not display
> >        argument
> 
> Great progress!!

Thans.

> 
> (...)
> > +++ b/arch/arm/mach-zynq/Kconfig
> > @@ -9,6 +9,7 @@ config ARCH_ZYNQ
> >         select HAVE_ARM_TWD if SMP
> >         select ICST
> >         select MFD_SYSCON
> > +       select PINCTRL
> 
> Don't you also want to select PINCTRL_ZYNQ or is it
> really optional?

Yep, you're right. I did some testing and it is required. I already have
that included in my work tree.

> 
> >         select SOC_BUS
> >         help
> >           Support for Xilinx Zynq ARM Cortex A9 Platform
> 
> Please split these machine changes into a separate patch. It is hitting
> a totally different subsystem.

OK

> 
> (...)
> > +++ b/drivers/pinctrl/pinctrl-zynq.c
> (...)
> > +static const struct pinctrl_ops zynq_pctrl_ops = {
> > +       .get_groups_count = zynq_pctrl_get_groups_count,
> > +       .get_group_name = zynq_pctrl_get_group_name,
> > +       .get_group_pins = zynq_pctrl_get_group_pins,
> > +       .dt_node_to_map = pinconf_generic_dt_node_to_map_group,
> > +       .dt_free_map = pinctrl_utils_dt_free_map
> > +};
> 
> Nice use of generic functions!

Yeah, but for it to really work I need the changes I made to
pinconf-generic. Otherwise things just don't work well since I would
only be able to either select pin groups or pins in DT.

> 
> > +static int zynq_pinconf_cfg_get(struct pinctrl_dev *pctldev,
> > +                               unsigned pin,
> > +                               unsigned long *config)
> > +{
> > +       u32 reg;
> > +       int ret;
> > +       unsigned int arg = 0;
> > +       unsigned int param = pinconf_to_config_param(*config);
> > +       struct zynq_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> > +
> > +       if (pin > 53)
> > +               return -ENOTSUPP;
> 
> 53 looks a bit magical? #define or comment here to explain what's
> going on?

Yep, I'll add something like ZYNQ_NUM_MIOS

> 
> Apart from these small things this looks like merge material.

That is good to hear, thank you. But before merging this the
pinconf-generic changes need to go through. Even though I didn't order
things that way in this series (I wanted to show how my work proceeded),
proper operation depends of the driver depends on those pinconf-generic
changes.

	Thanks,
	S?ren
