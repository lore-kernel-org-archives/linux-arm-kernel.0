From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 21 Dec 2015 16:17:02 +0100
Subject: [PATCH 4/4] ARM: bcm2835: Switch to using the new clock driver
 support.
In-Reply-To: <5677F3C8.5000600@lategoodbye.de>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-5-git-send-email-eric@anholt.net>
 <5677E7BF.3020404@martin.sperl.org> <5677F3C8.5000600@lategoodbye.de>
Message-ID: <03BE10FE-D743-4CD3-8825-112D0F6B2D43@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 21.12.2015, at 13:42, Stefan Wahren <info@lategoodbye.de> wrote:
> 
> Hi Martin,
> 
>> here the corresponding section for i2s in /arch/arm/boot/dts/bcm2835.dtsi:
>>                 i2s: i2s at 7e203000 {
>>                         compatible = "brcm,bcm2835-i2s";
>>                         reg = <0x7e203000 0x20>,
>>                               <0x7e101098 0x02>;
>> 
>>                         dmas = <&dma 2>,
>>                                <&dma 3>;
>>                         dma-names = "tx", "rx";
>>                         status = "disabled";
>>                 };
> 
> unfortunately i don't have a i2s interface, but thanks for the remark.
I received one just today...
> 
> It looks like the i2s driver programm the clock by itself instead of using the clock framework. So the second register entry should be removed from the i2s node.

I started looking and found that drivers/clk/bcm/clk-bcm2835.c
does not include the PWM clock either.

Anyway - looking at: sound/soc/bcm/bcm2835-i2s.c
it seems that right now this driver makes use of
a different parent-clock depending of the requested clock

I guess Eric needs to look into this portion to put it into the generic clock_code?
It is way more complicated than just using a fixed clock...

>> 
>> Note that actually the PCM/I2S reg-range should be (off by 4):
>>     reg = <0x7e203000 0x24>;
>> (see also: https://github.com/raspberrypi/linux/pull/1079)
> 
> Any chance that Robert (patch author) can send a proper patch to linux-rpi-kernel for the of by 4 issue?
as we need to remove the second register-set anyway we need to make
modifications in the same location anyway.

Looks probably something like this for the device-tree:
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..288d678 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -120,8 +120,9 @@
 
 		i2s: i2s at 7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PWM>,
+				 <&clocks BCM2835_CLOCK_VPU>;
 
 			dmas = <&dma 2>,
 			       <&dma 3>;
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm
index d323efa..61f1d20 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -43,5 +43,6 @@
 #define BCM2835_CLOCK_TSENS		27
 #define BCM2835_CLOCK_EMMC		28
 #define BCM2835_CLOCK_PERI_IMAGE	29
+#define BCM2835_CLOCK_PWM		30
 
-#define BCM2835_CLOCK_COUNT		30
+#define BCM2835_CLOCK_COUNT		31

And obviously more changes to the clock driver itself to support it:
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -807,6 +807,17 @@ static const struct bcm2835_clock_data bcm2835_clock_emmc_d
 	.frac_bits = 8,
 };
 
+/* PWM/I2S clock */
+static const struct bcm2835_clock_data bcm2835_clock_pwm_data = {
+	.name = "pwm",
+	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
+	.parents = bcm2835_clock_per_parents,
+	.ctl_reg = CM_PWMCTL,
+	.div_reg = CM_PWMDIV,
+	.int_bits = 4,
+	.frac_bits = 8,
+};
+
 struct bcm2835_pll {
 	struct clk_hw hw;
 	struct bcm2835_cprman *cprman;
@@ -1537,6 +1548,8 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 		bcm2835_register_clock(cprman, &bcm2835_clock_hsm_data);
 	clks[BCM2835_CLOCK_EMMC] =
 		bcm2835_register_clock(cprman, &bcm2835_clock_emmc_data);
+	clks[BCM2835_CLOCK_PWM] =
+		bcm2835_register_clock(cprman, &bcm2835_clock_pwm_data);
 
 	/*
 	 * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
 
 

And obviously many more changes to sound/soc/bcm/bcm2835-i2s.c
to remove the clock code and use the clock framework instead.

The biggest thing is the selection of the clock to use - the current code
either uses the OSC or PLLD.

@Eric: ist there some means to do that?

Thanks,
	Martin
