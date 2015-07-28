From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 28 Jul 2015 07:27:24 -0700
Subject: [RFCv2 3/3] reset: reset-zynq: Adding support for Xilinx Zynq
 reset controller.
In-Reply-To: <CAAtXAHfgCnH1KPyPBBPHq-amr=npMmyYjs+D9jnB3F9qpD6dbA@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-4-git-send-email-moritz.fischer@ettus.com>
 <1438072680.3193.24.camel@pengutronix.de>
 <CAAtXAHfgCnH1KPyPBBPHq-amr=npMmyYjs+D9jnB3F9qpD6dbA@mail.gmail.com>
Message-ID: <20150728142723.GS2650@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-28 at 07:05AM -0700, Moritz Fischer wrote:
> Philip,
> 
> thanks for your review :)
> 
> On Tue, Jul 28, 2015 at 1:38 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Moritz,
> >
> > Am Freitag, den 24.07.2015, 17:21 -0700 schrieb Moritz Fischer:
> >> This adds a reset controller driver to control the Xilinx Zynq
> >> SoC's various resets.
> >>
> >> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
[...]
> >> +
> >> +/* Offsets into SLCR regmap */
> >> +#define SLCR_RST_CTRL_OFFSET 0x200 /* FPGA Software Reset Control */
> >
> > Maybe get this value from the reg property? I'm not sure if this is ever
> > expected to change.
> I don't think it's going to change. Is there a reason to only expose
> part of the resets?

I think all other users of the syscon (in the Zynq DT) use the 'reg' property
to retrieve an offset into the SLCR. We should probably do that here too and
remove the #define. Who knows, maybe this driver is reusable with some
modifications for the Zynq MPSoC.

> >
> >> +#define NBANKS       18
> >
> > reg = <0x200 0x50> says there are two more registers, are those not used?
> 
> Should be 0x48, you're right. Michal had suggested 0x50, but the last
> two regs are not really resets.
> >
[...]
> >> +static int zynq_reset_status(struct reset_controller_dev *rcdev,
> >> +                          unsigned long id)
> >> +{
> >> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
> >> +
> >> +     int bank = id / BITS_PER_LONG;
> >> +     int offset = id % BITS_PER_LONG;
> >> +     u32 reg;
> >> +
> >> +     regmap_read(priv->slcr, SLCR_RST_CTRL_OFFSET + (bank * 4), &reg);
> >> +
> >> +     return !(reg & BIT(offset));
> >> +}
> 
> Will change to:
>         ret = regmap_read(priv->slcr, SLCR_RST_CTRL_OFFSET + (bank * 4), &reg);
>         if (ret)
>                 return ret;
>         else
>                 return !!(reg & BIT(offset));
> 
> the single '!' was a typo ...

You have an early return on error in the if-branch. No need for the
else.

> 
> >
> > Do I understand this correctly, you write 1 to assert the reset, but the
> > register reads 0 while the reset is asserted and 1 otherwise?
> > Also note that reset_status may return negative ERRNO, so for offset ==
> > 31 you should not return (1<<31).
> >
> >> +static const struct reset_control_ops zynq_reset_ops = {
> >> +     .assert         = zynq_reset_assert,
> >> +     .deassert       = zynq_reset_deassert,
> >> +     .status         = zynq_reset_status,
> >> +};
> >> +
> >> +static int zynq_reset_probe(struct platform_device *pdev)
> >> +{
> >> +     struct zynq_reset_data *priv;
> >> +
> >> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >> +     if (!priv)
> >> +             return -ENOMEM;
> >> +     platform_set_drvdata(pdev, priv);
> >> +
> >> +     priv->slcr = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> >> +             "syscon");
> >
> > I'd just use syscon_node_to_regmap(pdev->dev.of_node->parent) here,
> > which removes the need for the syscon phandle binding.
> 
> See binding doc discussion. I don't have a strong preference either way,
> just tried to be consistent with the pinctrl node.
> We just need a decision one way or the other :)

I personally like the syscon handle better since it would make placing
the node more flexible, while this proposal forces some topology on the
DT. In both cases though, the syscon and this user are tightly coupled
and this driver depends on the syscon. I don't really mind either way -
I think.

	S?ren
