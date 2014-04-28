From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Apr 2014 20:22:53 +0900
Subject: [PATCH v2 1/5] ARM: dts: Add syscon handle in pmu node for
 exynos5250
In-Reply-To: <535ACBC8.5090703@gmail.com>
References: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
 <1398426857-5097-1-git-send-email-pankaj.dubey@samsung.com>
 <1398426857-5097-2-git-send-email-pankaj.dubey@samsung.com>
 <535ACBC8.5090703@gmail.com>
Message-ID: <535E3A0D.4000501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 04/26/2014 05:55 AM, Tomasz Figa wrote:
> Hi Pankaj,
>
> On 25.04.2014 13:54, Pankaj Dubey wrote:
>> Add "samsung,syscon-phandle" property pointing to PMU node
>> to access PMU register via PMU regmap handle.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5250.dtsi |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi 
>> b/arch/arm/boot/dts/exynos5250.dtsi
>> index 3742331..52801af 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -173,6 +173,7 @@
>>       pmu_system_controller: system-controller at 10040000 {
>>           compatible = "samsung,exynos5250-pmu", "syscon";
>>           reg = <0x10040000 0x5000>;
>> +        samsung,syscon-phandle = <&pmu_system_controller>;
>>       };
>>
>>       watchdog at 101D0000 {
>>
>
> This looks strange. A node that refers back to itself. If I understand 
> correctly, you are relying on the fact that if you don't use platform_driver 
> model for the PMU driver, it won't bind to this node and instead the generic 
> syscon driver will. I'm afraid this is incorrect, because the PMU driver 
> should normally use the driver model.

No, let me explain you, property "samsung, syscon-phandle" referring back to 
it's own node
and I am not using platform_driver model for PMU driver are not related with 
each other.

We added "samsung, syscon-phandle" property to PMU node, as current syscon API's 
to get regmap
such as "syscon_regmap_lookup_by_phandle" expects "property_name" to lookup for 
proper device_node
which has regmap. So if we are passing PMU device_node to such API we should 
have that property under
PMU device node. So even though it's looking strange I do not think it's wrong.

But still since, you pointed out I checked syscon APIs carefully and found that 
we can avoid such property
which refers back to itself if we modify syscon APIs and allow them to accept 
"property" parameter as NULL,
assuming that device_node passed itself has regmap handle, following 
modification worked for me and if
it is acceptable I do not need to add such property in PMU device node.

==========
struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
                      const char *property)
  {
      struct device_node *syscon_np;
      struct regmap *regmap;
-
-    syscon_np = of_parse_phandle(np, property, 0);
-    if (!syscon_np)
-        return ERR_PTR(-ENODEV);
-
-    regmap = syscon_node_to_regmap(syscon_np);
-    of_node_put(syscon_np);
-
+
+    if (property) {
+        syscon_np = of_parse_phandle(np, property, 0);
+        if (!syscon_np)
+            return ERR_PTR(-ENODEV);
+
+        regmap = syscon_node_to_regmap(syscon_np);
+        of_node_put(syscon_np);
+    } else {
+        regmap = syscon_node_to_regmap(np);
+    }
      return regmap;
  }
=============

Other problem as you are seeing that current patch does not uses platform_driver 
model for PMU
is because PMU device node has two compatibility string and "syscon" driver is 
getting registered as
core_initcall, much before PMU registration. So only "syscon" driver's probe is 
getting called. So it does
not depend whether we have this property in PMU device node or we do not have.

>
> I see two possible options to solve this problem:
>
> 1) Instead, the PMU driver should bind to this node and become a syscon 
> provider. This will require a small change in the syscon API, which would be 
> reasonable anyway:
>
>  a) instead of using driver_find_device() and dev_get_drvdata() in 
> syscon_node_to_regmap(), a local list of syscon structs should be kept in this 
> driver and then the look-up would just iterate over this list, that could 
> contain external syscon implementations as well,
>
>  b) syscon_register() function should be provided to register an external 
> syscon provider from other drivers, like Exynos PMU driver.
>
> Another solution would be:
>
> 2) Register a static platform device from Exynos PMU driver, with .of_node set 
> to PMU node and .name to "syscon" to instantiate the syscon device and create 
> a syscon provider, even though the PMU driver would be bound to the node.

I do not understand you here. Will you please explain a bit more here?

How come two driver with same ".name" can be registered? I can see if "syscon" 
driver
registration comes first, static registration from PMU driver, with same .name 
will fail.
Please correct me if I am wrong.


>
> The change mentioned in point 1.a) should be implemented regardless of which 
> solution is chosen, as iterating over all devices in the system and relying on 
> their driver_data is rather a poor practice. A local list would be faster - 
> all syscons to iterate over, instead of all devices in the system, and more 
> flexible - a single device could be a provider of multiple resources.

Your suggestion 1.a) worked well and I modified and tested it also.
So probably I can send that patch separately. Even though I can't see this 
helping me to convert PMU
as platform_driver model.

>
> As for the solution for Exynos PMU itself, I tend to prefer 2), as it wouldn't 
> require additional functions exported from the syscon driver.
>
> Best regards,
> Tomasz
>


-- 
Best Regards,
Pankaj Dubey
