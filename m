From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jun 2016 09:58:14 +0100
Subject: [STLinux Kernel] [[PATCH v2] 08/11] pwm: sti: Initialise PWM
 Capture device data
In-Reply-To: <20160607082807.GC22744@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-9-git-send-email-lee.jones@linaro.org>
 <20160607082807.GC22744@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20160607085814.GA18047@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jun 2016, Peter Griffin wrote:
> On Fri, 22 Apr 2016, Lee Jones wrote:
> 
> > Each PWM Capture device is allocated a structure to hold its own
> > state.  During a capture the device may be partaking in one of 3
> > phases.  Initial (rising) phase change, a subsequent (falling)
> > phase change indicating end of the duty-cycle phase and finally
> > a final (rising) phase change indicating the end of the period.
> > The timer value snapshot each event is held in a variable of the
> > same name, and the phase number (0, 1, 2) is contained in the
> > index variable.  Other device specific information, such as GPIO
> > pin, the IRQ wait queue and locking is also contained in the
> > structure.  This patch initialises this structure for each of
> > the available devices.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/pwm-sti.c | 45 ++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 38 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > index 78979d0..9d597bb 100644
> > --- a/drivers/pwm/pwm-sti.c
> > +++ b/drivers/pwm/pwm-sti.c

[...]

> > @@ -307,10 +318,15 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
> >  	struct device_node *np = dev->of_node;
> >  	struct sti_pwm_compat_data *cdata = pc->cdata;
> >  	u32 num_devs;
> > +	int ret;
> >  
> > -	of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> > -	if (num_devs)
> > -		cdata->num_devs = num_devs;
> > +	ret = of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> > +	if (!ret)
> > +		cdata->pwm_num_devs = num_devs;
> 
> dt binding document documents this as st,pwm-num-chan currently.

It does, but see PATCH 2.

> Why do you need
> this  binding anyway? Why can't you determine how many channels you have based on
> the number of pinctrl groups you are given?

That sounds like a horrible idea; a) I'm not even sure if that's
possible with the Pinctrl Consumer API and b) even if is it physically
possible, it sounds messy.  It's much better for code to be clear and
simple.  Code attempting to use clever inference techniques is usually
pretty hard to understand and maintain.  We use num-<stuff> a lot in
DT, and for good reason.  Besides, not every PWM channel is capable of
capture.

> Also with this series I don't currently understand how the driver is configured to be
> pwm-in or pwm-out. Can you explain how that decision is made?

This patch-set does not concern itself with the platform specific
side.  I have a subsequent patch-set for that.  Perhaps it might be
nice to move the documentation update into this set though.

> For example at the moment I can't see any code in this series for handling the different
> pinctrl groups which presumably are required to have this working.

To ease your curiosity, here is the patch which does that for the 407:

Author: Lee Jones <lee.jones@linaro.org>
Date:   Wed Feb 3 14:24:01 2016 +0000

    ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
    
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..bc22122 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -289,10 +289,12 @@
 			pinctrl_pwm1_chan0_default: pwm1-0-default {
 				st,pins {
 					pwm-out = <&pio3 0 ALT1 OUT>;
+					pwm-capturein = <&pio3 2 ALT1 IN>;
 				};
 			};
 			pinctrl_pwm1_chan1_default: pwm1-1-default {
 				st,pins {
+					pwm-capturein = <&pio4 3 ALT1 IN>;
 					pwm-out = <&pio4 4 ALT1 OUT>;
 				};
 			};
@@ -1030,6 +1032,7 @@
 		pwm0 {
 			pinctrl_pwm0_chan0_default: pwm0-0-default {
 				st,pins {
+					pwm-capturein = <&pio31 0 ALT1 IN>;
 					pwm-out = <&pio31 1 ALT1 OUT>;
 				};
 			};
				
> If I look at pinctrl_pwm1_chan0_default and friends declared in
> stih407-pinctrl.dtsi all are currently named pwm-out, and declared as outputs. For
> pwm-in functionality I was expecting to see another set of pinctrl definitions,
> declaring these pins as inputs, and something in the driver selecting the
> correct pin config depending on how the device has been configured?

See above.

> Maybe an updated dt example / bindings would make this clearer.

Happy to provide the DT documentation in this patch-set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
