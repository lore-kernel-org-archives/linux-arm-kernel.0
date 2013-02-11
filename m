From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 12 Feb 2013 01:10:47 +0800
Subject: [PATCH v8 00/12] bind pinconf with pinctrl single
Message-ID: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v8:
1. Update allocate irq dynamically in gpio-pl061.
2. Update bias-pullup/bias-pulldown as 4 parameters.
3. Remove bias-disable.
4. Add bias-autopull.
5. Rename input-schmitt-disable to input-schmitt-enable.
6. Discard allocating global gpio number in ascending order.

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
