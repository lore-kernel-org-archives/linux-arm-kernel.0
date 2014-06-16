From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon, 16 Jun 2014 09:46:52 +0200
Subject: [PATCH v2 1/7] mfd: add atmel-hlcdc driver
In-Reply-To: <539DB25A.4000201@free-electrons.com>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402329860-27520-2-git-send-email-boris.brezillon@free-electrons.com>
 <539D5F24.1020304@traphandler.com>
 <539DB25A.4000201@free-electrons.com>
Message-ID: <CACh+v5MJ92=jNVkpx=FS3bNYcr+Xw2MUpLDfqwpYsj1zNZOu9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-06-15 16:48 GMT+02:00 Boris BREZILLON <boris.brezillon@free-electrons.com>:
>
>
> Hello JJ,
>
> On 15/06/2014 10:53, Jean-Jacques Hiblot wrote:
> > On 06/09/2014 06:04 PM, Boris BREZILLON wrote:
> >> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
> >> family or sama5d3 family) exposes 2 subdevices:
> >> - a display controller (controlled by a DRM driver)
> >> - a PWM chip
> >>
> >> Add support for the MFD device which will just retrieve HLCDC clocks and
> >> create a regmap so that subdevices can access the HLCDC register range
> >> concurrently.
> >>
> >> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> >> ---
> >>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  41 ++++++++
> >>  drivers/mfd/Kconfig                                |  11 ++
> >>  drivers/mfd/Makefile                               |   1 +
> [...]
> >> +    memset(&config, 0, sizeof(config));
> >> +    config.reg_bits = 32;
> >> +    config.val_bits = 32;
> >> +    config.reg_stride = 4;
> >> +    config.max_register = (resource_size(res) / 4) - 1;
> >> +    hlcdc->regmap = devm_regmap_init_mmio_clk(dev, "periph_clk", regs,
> >> +                                              &config);
> > I don't think it's necessary to use "periph_clk" here. This clock will
> > always be running because the HLCDC needs it to work (it's not just an
> > interface clock). In the end it's just some extra work for each register
> > access.
>
> Yes, I thought about removing this clk from regmap registration too (for
> the exact same reason: avoiding extra enable/disable work when accessing
> registers), but ATM I do not prepare/enable periph_clk in the hlcdc-pwm
> driver, this means the regmap won't work until the hlcdc-dc driver has
> probed the display controller device.
>
> How about preparing/enabling the periph_clk in the MFD device, so that
> PWM and Display Controller subdevices won't have to bother about this
> clk, and the regmap will work as expected ?
> Or, should we just prepare/enable the periph clock in each subdevices ?

I think the latest is the best approach. This way the PWM and the DRM
driver can handle their clock gating independently. BTW it's quite
probable that the PWM don't really needs this clock except for
register access.

>
>
>
> Best Regards,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
