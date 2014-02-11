From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Feb 2014 21:57:46 +0100
Subject: [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device
 registration
In-Reply-To: <1392138636-29240-10-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-10-git-send-email-pawel.moll@arm.com>
Message-ID: <201402112157.46774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 February 2014, Pawel Moll wrote:
> -#define VEXPRESS_HWMON_ATTRS(_name, _label_attr, _input_attr)  \
> -struct attribute *vexpress_hwmon_attrs_##_name[] = {           \
> -       &dev_attr_name.attr,                                    \
> -       &dev_attr_##_label_attr.attr,                           \
> -       &sensor_dev_attr_##_input_attr.dev_attr.attr,           \
> -       NULL                                                    \
> -}
> +#define VEXPRESS_HWMON_ATTR_GROUPS(_name, _label_attr, _input_attr)    \
> +static struct attribute *vexpress_hwmon_##_name##_attrs[] = {          \
> +       &dev_attr_##_label_attr.attr,                                   \
> +       &sensor_dev_attr_##_input_attr.dev_attr.attr,                   \
> +       NULL                                                            \
> +};                                                                     \
> +ATTRIBUTE_GROUPS(vexpress_hwmon_##_name)
>  
>  #if !defined(CONFIG_REGULATOR_VEXPRESS)
>  static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
>                 NULL, 1000);
> -static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
> -static struct attribute_group vexpress_hwmon_group_volt = {
> -       .attrs = vexpress_hwmon_attrs_volt,
> -};
> +VEXPRESS_HWMON_ATTR_GROUPS(volt, in1_label, in1_input);

Maybe it would be a good time to get rid of the obfuscation here and just
open-code the attribute groups rather than defining another macro.

I understand you want to save a few source lines, but it really helps
readability if you can search for the attribute groups when they
are referenced later. Just because the common driver model code uses
macros with string concatenation doesn't mean it's a good idea to
do the same in a device driver.

	Arnd
