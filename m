From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 23 Jul 2015 21:25:18 +0800
Subject: [PATCH v3 2/2] regulator: mt6311: Add support for mt6311 regulator
In-Reply-To: <1437649445.30329.90.camel@mtksdaap41>
References: <1437622799-28115-1-git-send-email-henryc.chen@mediatek.com>
 <1437622799-28115-3-git-send-email-henryc.chen@mediatek.com>
 <CABxcv=kgvCtHxuu0RDbFWEim+HYX74wEYXh8K7a6tT74R5YSuA@mail.gmail.com>
 <1437649445.30329.90.camel@mtksdaap41>
Message-ID: <CAGS+omBrd4+o4gyLd9e9-f-1Dn9iVvJ9qiS5WeJTZJY6aWnPDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henry,

On Thu, Jul 23, 2015 at 7:04 PM, Henry Chen <HenryC.Chen@mediatek.com> wrote:
>
> On Thu, 2015-07-23 at 11:07 +0200, Javier Martinez Canillas wrote:
>
> > > +
> > > +       if (ret < 0)
> > > +               dev_err(&i2c->dev, "Failed to initialize regulator: %d\n", ret);
> > > +
> >
> > I don't think this is necessary, you are already adding logs for all
> > the error conditions.
>
> Yes, I will remove it.
>
> >
> > > +       return ret;
> > > +}
> > > +
> > > +static const struct i2c_device_id mt6311_i2c_id[] = {
> > > +       {"mt6311", 0},
> > > +       {},
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, mt6311_i2c_id);
> > > +
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id mt6311_dt_ids[] = {
> > > +       { .compatible = "mediatek,mt6311-regulator",
> > > +         .data = &mt6311_i2c_id[0] },
> > > +       {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mt6311_dt_ids);
> > > +#endif
> > > +
> > > +static struct i2c_driver mt6311_regulator_driver = {
> > > +       .driver = {
> > > +               .name = "mt6311",
> > > +               .owner = THIS_MODULE,
> > > +               .of_match_table = of_match_ptr(mt6311_dt_ids),
> >
> > of_match_ptr() is NULL when CONFIG_OF is not defined so you don't need
> > the additional #ifdef
> > CONFIG_OF around mt6311_dt_ids.
>
> If CONFIG_OF is not defined and without #ifdef CONFIG_OF around
> mt6311_dt_ids, it will allocate a struct mt6311_dt_ids but no one used
> on here, right?

Correct, I agree with Henry that it is better to keep the #ifdef
around mt6311_dt_ids table.

-Daniel


>
> Henry
>
> > > +       },
> > > +       .probe = mt6311_i2c_probe,
> > > +       .id_table = mt6311_i2c_id,
> > > +};
> > > +
> > > +module_i2c_driver(mt6311_regulator_driver);
> > > +
> > > +MODULE_AUTHOR("Henry Chen <henryc.chen@mediatek.com>");
> > > +MODULE_DESCRIPTION("Regulator device driver for Mediatek MT6311");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/regulator/mt6311-regulator.h b/drivers/regulator/mt6311-regulator.h
> > > new file mode 100644
> > > index 0000000..5218db4
> > > --- /dev/null
> > > +++ b/drivers/regulator/mt6311-regulator.h
> > > @@ -0,0 +1,65 @@
> > > +/*
> > > + * Copyright (c) 2015 MediaTek Inc.
> > > + * Author: Henry Chen <henryc.chen@mediatek.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#ifndef __MT6311_REGULATOR_H__
> > > +#define __MT6311_REGULATOR_H__
> > > +
> > > +#define MT6311_SWCID              0x01
> > > +
> > > +#define MT6311_TOP_INT_CON        0x18
> > > +#define MT6311_TOP_INT_MON        0x19
> > > +
> > > +#define MT6311_VDVFS11_CON0       0x87
> > > +#define MT6311_VDVFS11_CON7       0x88
> > > +#define MT6311_VDVFS11_CON8       0x89
> > > +#define MT6311_VDVFS11_CON9       0x8A
> > > +#define MT6311_VDVFS11_CON10      0x8B
> > > +#define MT6311_VDVFS11_CON11      0x8C
> > > +#define MT6311_VDVFS11_CON12      0x8D
> > > +#define MT6311_VDVFS11_CON13      0x8E
> > > +#define MT6311_VDVFS11_CON14      0x8F
> > > +#define MT6311_VDVFS11_CON15      0x90
> > > +#define MT6311_VDVFS11_CON16      0x91
> > > +#define MT6311_VDVFS11_CON17      0x92
> > > +#define MT6311_VDVFS11_CON18      0x93
> > > +#define MT6311_VDVFS11_CON19      0x94
> > > +
> > > +#define MT6311_LDO_CON0           0xCC
> > > +#define MT6311_LDO_OCFB0          0xCD
> > > +#define MT6311_LDO_CON2           0xCE
> > > +#define MT6311_LDO_CON3           0xCF
> > > +#define MT6311_LDO_CON4           0xD0
> > > +#define MT6311_FQMTR_CON0         0xD1
> > > +#define MT6311_FQMTR_CON1         0xD2
> > > +#define MT6311_FQMTR_CON2         0xD3
> > > +#define MT6311_FQMTR_CON3         0xD4
> > > +#define MT6311_FQMTR_CON4         0xD5
> > > +
> > > +#define MT6311_PMIC_RG_INT_POL_MASK                      0x1
> > > +#define MT6311_PMIC_RG_INT_EN_MASK                       0x2
> > > +#define MT6311_PMIC_RG_BUCK_OC_INT_STATUS_MASK           0x10
> > > +
> > > +#define MT6311_PMIC_VDVFS11_EN_CTRL_MASK                 0x1
> > > +#define MT6311_PMIC_VDVFS11_VOSEL_CTRL_MASK              0x2
> > > +#define MT6311_PMIC_VDVFS11_EN_SEL_MASK                  0x3
> > > +#define MT6311_PMIC_VDVFS11_VOSEL_SEL_MASK               0xc
> > > +#define MT6311_PMIC_VDVFS11_EN_MASK                      0x1
> > > +#define MT6311_PMIC_VDVFS11_VOSEL_MASK                   0x7F
> > > +#define MT6311_PMIC_VDVFS11_VOSEL_ON_MASK                0x7F
> > > +#define MT6311_PMIC_VDVFS11_VOSEL_SLEEP_MASK             0x7F
> > > +#define MT6311_PMIC_NI_VDVFS11_VOSEL_MASK                0x7F
> > > +
> > > +#define MT6311_PMIC_RG_VBIASN_EN_MASK                    0x1
> > > +
> > > +#endif
> > > diff --git a/include/linux/regulator/mt6311.h b/include/linux/regulator/mt6311.h
> > > new file mode 100644
> > > index 0000000..8473259
> > > --- /dev/null
> > > +++ b/include/linux/regulator/mt6311.h
> > > @@ -0,0 +1,29 @@
> > > +/*
> > > + * Copyright (c) 2015 MediaTek Inc.
> > > + * Author: Henry Chen <henryc.chen@mediatek.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#ifndef __LINUX_REGULATOR_MT6311_H
> > > +#define __LINUX_REGULATOR_MT6311_H
> > > +
> > > +#define MT6311_MAX_REGULATORS  2
> > > +
> > > +enum {
> > > +       MT6311_ID_VDVFS = 0,
> > > +       MT6311_ID_VBIASN,
> > > +};
> > > +
> > > +#define MT6311_E1_CID_CODE    0x10
> > > +#define MT6311_E2_CID_CODE    0x20
> > > +#define MT6311_E3_CID_CODE    0x30
> > > +
> > > +#endif /* __LINUX_REGULATOR_MT6311_H */
> > > --
> >
> > Besides those comments, it looks good to me now.
> >
> > Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >
> > Best regards,
> > Javier
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
