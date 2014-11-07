From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 6 Nov 2014 21:30:20 -0400
Subject: [PATCH v17 1/5] thermal: rockchip: add driver for thermal
In-Reply-To: <1414809873-32227-2-git-send-email-caesar.wang@rock-chips.com>
References: <1414809873-32227-1-git-send-email-caesar.wang@rock-chips.com>
 <1414809873-32227-2-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <20141107013017.GA10180@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Caesar,

On Sat, Nov 01, 2014 at 10:44:29AM +0800, Caesar Wang wrote:
> Thermal is TS-ADC Controller module supports
> user-defined mode and automatic mode.
> 
> User-defined mode refers,TSADC all the control signals entirely by
> software writing to register for direct control.
> 
> Automaic mode refers to the module automatically poll TSADC output,
> and the results were checked.If you find that the temperature High
> in a period of time,an interrupt is generated to the processor
> down-measures taken;If the temperature over a period of time High,
> the resulting TSHUT gave CRU module,let it reset the entire chip,
> or via GPIO give PMIC.
> 

First thing, very good progress in this driver! 

> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Just for the sake of code / documentation history, this patch, which
adds the driver, should come after patch 2, which adds dt documentation.

> ---
>  drivers/thermal/Kconfig            |   9 +
>  drivers/thermal/Makefile           |   1 +
>  drivers/thermal/rockchip_thermal.c | 711 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 721 insertions(+)
>  create mode 100644 drivers/thermal/rockchip_thermal.c

<big cut>

> +static int
> +rockchip_thermal_register_sensor(struct platform_device *pdev,
> +				 struct rockchip_thermal_data *thermal,
> +				 struct rockchip_thermal_sensor *sensor,
> +				 enum sensor_id id)
> +{
> +	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
> +	int error;
> +
> +	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
> +	tsadc->set_tshut_temp(id, thermal->regs, thermal->tshut_temp);
> +
> +	sensor->thermal = thermal;
> +	sensor->id = id;
> +	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, id, sensor,
> +						rockchip_thermal_get_temp,
> +						NULL,
> +						rockchip_thermal_set_trips);

So, did I miss something here? Looks like you have extended the of
thermal, and I haven't seen the patch.
  CC [M]  drivers/thermal/rockchip_thermal.o
  drivers/thermal/rockchip_thermal.c: In function
  `rockchip_thermal_register_sensor':
  drivers/thermal/rockchip_thermal.c:482:7: error: too many arguments to
  function `thermal_zone_of_sensor_register'
         rockchip_thermal_set_trips);


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/ae232387/attachment.sig>
