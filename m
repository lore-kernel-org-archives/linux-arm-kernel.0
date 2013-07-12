From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 12 Jul 2013 10:13:52 +0200
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <20130712072650.GC7656@atomide.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
 <20130712072650.GC7656@atomide.com>
Message-ID: <51DFBAC0.5070806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2013 09:26 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [130711 07:30]:
>> OMAP4 no longer boots in legacy mode so the code here is no longer used.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
>>  arch/arm/mach-omap2/twl-common.h |   8 -
>>  2 files changed, 12 insertions(+), 328 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
>> index c05898f..932dea7 100644
>> --- a/arch/arm/mach-omap2/twl-common.c
>> +++ b/arch/arm/mach-omap2/twl-common.c
>> @@ -38,20 +38,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
>>  	.flags		= I2C_CLIENT_WAKE,
>>  };
>>  
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> -static int twl_set_voltage(void *data, int target_uV)
>> -{
>> -	struct voltagedomain *voltdm = (struct voltagedomain *)data;
>> -	return voltdm_scale(voltdm, target_uV);
>> -}
>> -
>> -static int twl_get_voltage(void *data)
>> -{
>> -	struct voltagedomain *voltdm = (struct voltagedomain *)data;
>> -	return voltdm_get_voltage(voltdm);
>> -}
>> -#endif
> 
> Looks like the code above is also needed for omap3 based on the
> if defined?

Yes it is still needed for OMAP3 when booting in legacy. I have moved these
two function down within the #if defined(CONFIG_ARCH_OMAP3) :

 #if defined(CONFIG_ARCH_OMAP3)
@@ -189,6 +160,18 @@ static struct regulator_init_data omap3_vdd2 = {
 	.consumer_supplies		= omap3_vdd2_supply,
 };

+static int twl_set_voltage(void *data, int target_uV)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_scale(voltdm, target_uV);
+}
+
+static int twl_get_voltage(void *data)
+{
+	struct voltagedomain *voltdm = (struct voltagedomain *)data;
+	return voltdm_get_voltage(voltdm);
+}
+
 static struct twl_regulator_driver_data omap3_vdd1_drvdata = {
 	.get_voltage = twl_get_voltage,
 	.set_voltage = twl_set_voltage,
@@ -235,297 +218,6 @@ void __init omap3_pmic_get_config(struct
twl4030_platform_data *pmic_data,
 }
 #endif /* CONFIG_ARCH_OMAP3 */


-- 
P?ter
