From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Apr 2014 08:25:56 +0100
Subject: [PATCH V3 4/5] mfd: palmas: support IRQ inversion at the board
 level
In-Reply-To: <CAAVeFuJY67zdoHiZufxDbkaw=xt8YwxyDAwHW_T7UZeSOt35NA@mail.gmail.com>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
 <1393876300-3061-4-git-send-email-swarren@wwwdotorg.org>
 <CAAVeFuJY67zdoHiZufxDbkaw=xt8YwxyDAwHW_T7UZeSOt35NA@mail.gmail.com>
Message-ID: <20140410072556.GB4214@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Stephen, any news about this patch? I'm waiting for it to be merged in
> order to resend some Tegra DTs, but still cannot see it in -next.

I doubt it's been applied.

No one got back to me with reference to how to deal with the set [1],
so I certainly didn't apply it.

[1] http://www.spinics.net/lists/arm-kernel/msg312694.html

> On Tue, Mar 4, 2014 at 4:51 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> >
> > Implement the new DT property ti,irq-externally-inverted, and add an
> > equivalent platform data field to match. This allows the driver to
> > correctly automatically configure the IRQ output polarity when the board
> > or SoC contains an inverter between the Palmas IRQ output and IRQ
> > controller input.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > v3:
> > * Use an IRQD flag to represent the data, rather than a custom DT property.
> > v2:
> > * Split V1's patch 1/2 into separate patches 1/3 and 2/3.
> > ---
> >  drivers/mfd/palmas.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> > index d280d789e55a..3281d4103e9d 100644
> > --- a/drivers/mfd/palmas.c
> > +++ b/drivers/mfd/palmas.c
> > @@ -292,7 +292,8 @@ static int palmas_set_pdata_irq_flag(struct i2c_client *i2c,
> >                 return -EINVAL;
> >         }
> >
> > -       pdata->irq_flags = irqd_get_trigger_type(irq_data);
> > +       pdata->irq_flags = irqd_get_trigger_type(irq_data) |
> > +                          irqd_get_src_dst_inverted(irq_data);
> >         dev_info(&i2c->dev, "Irq flag is 0x%08x\n", pdata->irq_flags);
> >         return 0;
> >  }
> > @@ -447,6 +448,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
> >                 reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
> >         else
> >                 reg = 0;
> > +       if (pdata->irq_flags & IRQ_SRC_DST_INVERTED)
> > +               reg ^= PALMAS_POLARITY_CTRL_INT_POLARITY;
> >         ret = palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
> >                         PALMAS_POLARITY_CTRL, PALMAS_POLARITY_CTRL_INT_POLARITY,
> >                         reg);
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
