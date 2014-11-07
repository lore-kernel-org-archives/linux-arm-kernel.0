From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 7 Nov 2014 19:39:58 -0400
Subject: [PATCH v17 1/5] thermal: rockchip: add driver for thermal
In-Reply-To: <20141107015728.GF34214@dtor-ws>
References: <1414809873-32227-1-git-send-email-caesar.wang@rock-chips.com>
 <1414809873-32227-2-git-send-email-caesar.wang@rock-chips.com>
 <20141107013017.GA10180@developer> <20141107015728.GF34214@dtor-ws>
Message-ID: <20141107233956.GA27665@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dmitry,

On Thu, Nov 06, 2014 at 05:57:28PM -0800, Dmitry Torokhov wrote:
> Hi Eduardo,
> 
> On Thu, Nov 06, 2014 at 09:30:20PM -0400, Eduardo Valentin wrote:
> > Hello Caesar,
> > 
> > On Sat, Nov 01, 2014 at 10:44:29AM +0800, Caesar Wang wrote:
> > > Thermal is TS-ADC Controller module supports
> > > user-defined mode and automatic mode.
> > > 
> > > User-defined mode refers,TSADC all the control signals entirely by
> > > software writing to register for direct control.
> > > 
> > > Automaic mode refers to the module automatically poll TSADC output,
> > > and the results were checked.If you find that the temperature High
> > > in a period of time,an interrupt is generated to the processor
> > > down-measures taken;If the temperature over a period of time High,
> > > the resulting TSHUT gave CRU module,let it reset the entire chip,
> > > or via GPIO give PMIC.
> > > 
> > 
> > First thing, very good progress in this driver! 
> > 
> > > Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> > > Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> > > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Just for the sake of code / documentation history, this patch, which
> > adds the driver, should come after patch 2, which adds dt documentation.
> > 
> > > ---
> > >  drivers/thermal/Kconfig            |   9 +
> > >  drivers/thermal/Makefile           |   1 +
> > >  drivers/thermal/rockchip_thermal.c | 711 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 721 insertions(+)
> > >  create mode 100644 drivers/thermal/rockchip_thermal.c
> > 
> > <big cut>
> > 
> > > +static int
> > > +rockchip_thermal_register_sensor(struct platform_device *pdev,
> > > +				 struct rockchip_thermal_data *thermal,
> > > +				 struct rockchip_thermal_sensor *sensor,
> > > +				 enum sensor_id id)
> > > +{
> > > +	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
> > > +	int error;
> > > +
> > > +	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
> > > +	tsadc->set_tshut_temp(id, thermal->regs, thermal->tshut_temp);
> > > +
> > > +	sensor->thermal = thermal;
> > > +	sensor->id = id;
> > > +	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, id, sensor,
> > > +						rockchip_thermal_get_temp,
> > > +						NULL,
> > > +						rockchip_thermal_set_trips);
> > 
> > So, did I miss something here? Looks like you have extended the of
> > thermal, and I haven't seen the patch.
> >   CC [M]  drivers/thermal/rockchip_thermal.o
> >   drivers/thermal/rockchip_thermal.c: In function
> >   `rockchip_thermal_register_sensor':
> >   drivers/thermal/rockchip_thermal.c:482:7: error: too many arguments to
> >   function `thermal_zone_of_sensor_register'
> >          rockchip_thermal_set_trips);
> 
> Yes, it relies on patch by Mikko Perttunen adding support for
> hardware-supported trip points. It allows us to reduce polling frequency
> while still being able to react when we cross the tripping point.
> 
> See https://lkml.org/lkml/2014/6/27/76
> 

Yeah, that thread needs to be re-taken. Today I merged nvidia's driver,
but only a simpler version of it. I expect that they take the missing
parts through after updating / refreshing the patches.

And on that front, as I requested, there must be also equivalent mapping
in the thermal core, to avoid spreading / growing of-thermal as a
secondary thermal API.

One thing for sure that must be done is a little refactoring in the
of-thermal registration functions. I had a similar discussion about this
with Lukasz, who is also interested in improving the of-thermal
callbacks.

Cheers,

> Thanks.
> 
> -- 
> Dmitry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/53498e5b/attachment.sig>
