From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 19:57:39 +0530
Subject: [PATCH 5/6] mfd: devicetree: bindings: 88pm800: Add DT property
 for dual phase enable
In-Reply-To: <55A3725B.2040801@samsung.com>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-6-git-send-email-vaibhav.hiremath@linaro.org>
 <55A0C2CB.6060209@samsung.com> <55A36DBF.5020100@linaro.org>
 <55A3725B.2040801@samsung.com>
Message-ID: <55A3CADB.7080701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 13 July 2015 01:40 PM, Krzysztof Kozlowski wrote:
> On 13.07.2015 16:50, Vaibhav Hiremath wrote:
>>
>>
>> On Saturday 11 July 2015 12:46 PM, Krzysztof Kozlowski wrote:
>>> W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
>>>> 88PM860 family of device supports dual phase mode on BUCK1 supply
>>>> providing total 6A capacity.
>>>> Note that by default they operate independently with 3A capacity.
>>>>
>>>> This patch adds the devicetree binding to enable this
>>>> feature.
>>>>
>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>> b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>> index ae1311c..c756b31 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>>> @@ -15,6 +15,12 @@ Optional properties :
>>>>          CLK32K3 - for 88pm800
>>>>          CLK32K2 - for 88pm860
>>>>
>>>> +   (Applicable only to PXA910 family):
>>>> +
>>>> + - marvell,88pm860-buck1-dualphase-en    : If set, enable dual phase
>>>> on BUCK1,
>>>> +   providing 6A capacity.
>>>> +   Without this both BUCK1A and BUCK1B operates independently with
>>>> 3A capacity.
>>>> +
>>>
>>> 1. How does this relates to regulator driver? The
>>> drivers/regulator/88pm800.c defines constraints for regulator which may
>>> be contradictory.
>>>
>>> 2. This looks like a job for regulator driver, not MFD. Then you could
>>> use standard regulator bindings (setting maximum current to 6A would
>>> change the regulator to different mode).
>>
>> Make sense. and even better.
>>
>> I believe you are referring to,
>>
>> regulator-min-microamp = <3000000>;
>> regulator-max-microamp = <6000000>;
>>
>> And provide set_current_limit() callback, to set the dualphase.
>>
>> Just to clarify more on this,
>>
>> The DT property would look something like,
>>
>> regulators {
>>      compatible = "marvell,88pm80x-regulator";
>>
>>      buck1a: BUCK1A {
>>          regulator-compatible = "buck1";
>>          regulator-min-microvolt = <600000>;
>>          regulator-max-microvolt = <1800000>;
>>
>>          regulator-min-microamp = <3000000>;
>>          regulator-max-microamp = <6000000>;
>>
>>          regulator-boot-on;
>>          regulator-always-on;
>>      };
>>
>>      buck1b: BUCK1B {
>>          regulator-compatible = "buck1b";
>>          regulator-min-microvolt = <600000>;
>>          regulator-max-microvolt = <1800000>;
>>
>>          regulator-min-microamp = <3000000>;
>>          regulator-max-microamp = <6000000>;
>>
>>          regulator-boot-on;
>>          regulator-always-on;
>>      };
>> };
>>
>>
>> And for the platforms, where dual phase is not required,
>> we can either choose not to set these properties or set it to
>>
>>
>>          regulator-min-microamp = <3000000>;
>>          regulator-max-microamp = <3000000>;
>
> Yes, exactly. I only wonder if regulator core would support properly
> such bindings - setting current limit for a voltage regulator. I didn't
> tried this but it should work.
>

Quickly I created a patch (pasted below) for review,


commit 22e846837d425ff6f98b087b8f93989dd0cfc666
Author: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Date:   Mon Jul 13 19:48:40 2015 +0530

     regulator: 88pm800: Add support for configuration of dual phase on 
BUCK1

     88PM860 device supports dual phase mode on BUCK1 output.
     In normal usecase, BUCK1A and BUCK1B operates independently with 3A
     capacity. And they both can work as a dual phase providing 6A capacity.

     This patch adds support for regulator_ops.set_current_limit() 
callback fn,
     in turn enabling support for current min and max supply constraint 
on BUCK1
     (and optionally on BUCK1B). Based on that driver enables dual-phase 
mode.

     (and optionally on BUCK1B). Based on that driver enables dual-phase 
mode.

     Note that, if max current supply constraint is > 3A on BUCK1(A) 
then driver
     enables the dual-phase mode, irrespective of BUCK1B constraint.

     Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index ee4b370..7596210 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -196,6 +196,42 @@ static int pm800_get_current_limit(struct 
regulator_dev *rdev)
         return info->max_ua;
  }

+/*
+ * 88pm860 device supports dual-phase mode on BUCK1, where BUCK1A and 
BUCK1B can
+ * be used together to supply 6A current.  Note that, independently, 
they can
+ * source 3A each.
+ *
+ * So, this function checks for max_uA for BUCK1 (only), and if it is 
more than
+ * 3A, then enable dual-phase mode.
+ */
+static int pm800_set_current_limit(struct regulator_dev *rdev,
+                               int min_uA, int max_uA)
+{
+       struct pm800_regulators *pm800_data = 
dev_get_drvdata(rdev_get_dev(rdev)->parent);
+       struct pm80x_chip *chip = pm800_data->chip;
+       int ret;
+
+       /* Currently only supported on 88pm860 device */
+       if (chip->type != CHIP_PM860)
+               return 0;
+
+       if (rdev->desc->id == PM800_ID_BUCK1) {
+               /* If max_uA is greater that 3A, enable dual-phase on 
BUCK1 */
+               if (max_uA > 3000000) {
+                       ret = 
regmap_update_bits(chip->subchip->regmap_power,
+                                       PM860_BUCK1_MISC,
+                                       BUCK1_DUAL_PHASE_SEL,
+                                       BUCK1_DUAL_PHASE_SEL);
+                       if (ret) {
+                               dev_err(chip->dev, "failed to access 
registers\n");
+                               return ret;
+                       }
+               }
+       }
+
+       return 0;
+}
+
  static struct regulator_ops pm800_volt_range_ops = {
         .list_voltage = regulator_list_voltage_linear_range,
         .map_voltage = regulator_map_voltage_linear_range,
@@ -205,6 +241,7 @@ static struct regulator_ops pm800_volt_range_ops = {
         .disable = regulator_disable_regmap,
         .is_enabled = regulator_is_enabled_regmap,
         .get_current_limit = pm800_get_current_limit,
+       .set_current_limit = pm800_set_current_limit,
  };

  static struct regulator_ops pm800_volt_table_ops = {
