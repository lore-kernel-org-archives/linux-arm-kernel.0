From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Nov 2015 11:27:46 +0100
Subject: Strange message from Kirkwood pinctrl driver
Message-ID: <CACRpkdah4w-=qHS+q_=Ab-RiJyvbCKY-Rp5Ya0x+F=3DL2iuBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

trying to use the Kirkwood pinctrl driver with compatible =
"marvell,88f6192-pinctrl";
on a Pogoplug series 4 yields the following message when instantiating
the driver:

kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 36
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 37
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 38
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 39
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 40
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 41
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 42
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 43
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 44
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 45
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 46
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 47
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 48
kirkwood-pinctrl f1010000.pin-controller: unknown pinctrl group 49
kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver

It looks harmless but seems like a bug and make me uncertain.

The following naive patch fixes it:

diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 0f07dc554a1d..6c7c2c8819b8 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -411,7 +411,7 @@ static struct mvebu_pinctrl_soc_info mv88f6190_info = {
        .controls = mv88f619x_mpp_controls,
        .ncontrols = ARRAY_SIZE(mv88f619x_mpp_controls),
        .modes = mv88f6xxx_mpp_modes,
-       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes),
+       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes) - 14,
        .gpioranges = mv88f619x_gpio_ranges,
        .ngpioranges = ARRAY_SIZE(mv88f619x_gpio_ranges),
 };
@@ -421,7 +421,7 @@ static struct mvebu_pinctrl_soc_info mv88f6192_info = {
        .controls = mv88f619x_mpp_controls,
        .ncontrols = ARRAY_SIZE(mv88f619x_mpp_controls),
        .modes = mv88f6xxx_mpp_modes,
-       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes),
+       .nmodes = ARRAY_SIZE(mv88f6xxx_mpp_modes) - 14,
        .gpioranges = mv88f619x_gpio_ranges,
        .ngpioranges = ARRAY_SIZE(mv88f619x_gpio_ranges),
 };

What is the proper way to fix this?

Yours,
Linus Walleij
