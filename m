From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:41 +0800
Subject: [PATCH v8 00/12] support pinconf in pinctrl single
Message-ID: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v8:
1. Always to check return value of pinctrl_request_gpio().
2. Add pinctrl_overlapped_gpio_range() to handle the case that special
GPIO pins don't have back-end pinctrl interface.
3. Add document of pinctrl single.
4. Replace power source property by drive strength property in pinctrl
single driver since current should be drive strength property.
5. Rebase all the patches.

v7:
1. Discard the method of adding gpio range from pinctrl-single driver.
Use gpiolib driver to support gpio range from DTS instead.
2. Add gpio request function to claim pin in gpio pl061 driver.
3. Adjust the initcall level in gpio pl061 driver.
4. Allocate gpio number from lowest gpio number to highest. The original
implementation is inverted. It's hard to use since it inverted the sequence
of gpio number.
5. Remove the support of pxa910 temporarily since gpio pxa driver need to
be updated for supporting this solution.

v6:
1. Two configuration array will be created for each pin group.
This first array is stored in pcs_function structure. The 32-bit
configruation argument is stored in this array. Driver stores
data while parsing DTS file, and loads these config array if
function selector is indicated.
The second array is stored in pinctrl_map structure. Driver won't
use it directly. So we could avoid to append lookup pinctrl map
method that is introduced in v5.

v5:
1. Move the properties of pinconf into pin group. So those mask
properties could be merged with other pinconf properties.
2. Append lookup pinctrl map method.
3. Append input schmitt disable config parameter.
4. Clean code.

v4:
1. Define gpio range as sub-node, not label. And remove
pinctrl-single,gpio-ranges property.
2. Use new two properties in sub-node, reg &
pinctrl-single,gpio. GPIO number & GPIO function are listed in
the pinctrl-single,gpio property.
3. Reference the names like pinctrl-single,bias.
4. Add compatible name "pinconf-single". If the compatible name is
"pinctrl-single", there's no pinconf. If the compatible name is
"pinconf-single", there's the generic pinconf in pinctrl-single.
5. Update documents.

v3:
1. Add more comments in document.
2. Replace pcs_readl() & pcs_writel() by pcs->read() & pcs->write().
3. Clean code.

v2:
1. Remove "pinctrl-single,gpio-mask". Since GPIO function is one of the
mux function in the pinmux register of both OMAP and PXA/MMP silicons.
Use "pinctrl-single,function-mask" instead.
2. Remove "pinctrl-single,gpio-enable" & "pinctrl-single,gpio-disable".
Use "pinctrl-single,gpio-func" instead. Because GPIO mode is only one
of the mux functions in the pinmux register. Defining "gpio-enable" &
"gpio-disable" are redundant.
3. Define register with __iomem, not u32 type.
4. Remove "pinctrl-single,input-schmit-shift",
"pinctrl-single,power-source-shift", "pinctrl-single,bias-shift". All
these properties could be calculated by mask fields.
5. Return -EPROBE_DEFER if pinmux could be got in device driver. And
the device driver would be probed again deferred.
