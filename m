From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  5 Aug 2016 10:38:36 +0200
Subject: [PATCH 0/2] Fix Qualcomm 8064/8660 interrupt flags
Message-ID: <1470386318-17694-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This came out after some frustration with trying to flag a PM8058
interrupt line on the APQ8060 (MSM8660) to trigger on falling
edges. It was conflicting badly with predefined contradictory
flags in the device tree for the entire GPIO block. The same
seems to hold for the MPP GPIO IRQs.

This was caused by copy/pasting the solution from APQ8064 and
I suspect the problem is seen there too whenever someon tries to
use an interrupt on any other edge than rising (e.g. falling or
both edges).

These two patches should probably go in as fixes to make it
possible to use these interrupts properly.

This is not the only problem with the SPMI/MPP GPIO IRQs. The
most glaring problem is the numbering of the IRQ lines in the
device tree: if you want to request a GPIO from the GPIO or
MPP block on the PMIC, you have to do something like this:

mpu3050 at 68 {
    compatible = "invn,mpu3050";
    reg = <0x68>;
    /*
     * GPIO17 has interrupt 208 on the
     * PM8058.
     */
    interrupt-parent = <&pm8058_gpio>;
    interrupts = <208 IRQ_TYPE_EDGE_FALLING>;
...

I.e. we're not using the local IRQ HW number (17) instead the
PM-global hw number 208. This is because the GPIO subdriver
does not implement its own irqdomain, and I suspect this
should be fixed by using the hierarchical irqdomain to work
properly.

This patch set does not fix the latter issue, but I want to
highlight it in the current context. My recommendation is for
nodes using these interrupts to refer directly to the PMIC
node for the time being, as the number on the GPIO/MPP nodes
is kind of skewed.

Linus Walleij (2):
  ARM: dts: MSM8064 remove flags from SPMI/MPP IRQs
  ARM: dts: MSM8660 remove flags from SPMI/MPP IRQs

 arch/arm/boot/dts/qcom-apq8064.dtsi | 76 +++++++++++++++++++++++++++----------
 arch/arm/boot/dts/qcom-msm8660.dtsi | 75 +++++++++++++++++++++++++++---------
 2 files changed, 114 insertions(+), 37 deletions(-)

-- 
2.7.4
