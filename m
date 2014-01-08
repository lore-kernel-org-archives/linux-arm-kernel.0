From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Jan 2014 14:03:58 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <20140108112926.GB2669@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <20140107183853.GE4227@obsidianresearch.com> <20140107230610.GB2592@katana>
 <52CD2529.6090206@free-electrons.com> <20140108112926.GB2669@katana>
Message-ID: <52CD4CBE.6010902@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 12:29, Wolfram Sang wrote:
> On Wed, Jan 08, 2014 at 11:15:05AM +0100, Gregory CLEMENT wrote:
>> Hi Wolfram,
>>
>> On 08/01/2014 00:06, Wolfram Sang wrote:
>>> On Tue, Jan 07, 2014 at 11:38:53AM -0700, Jason Gunthorpe wrote:
>>>> On Tue, Jan 07, 2014 at 05:35:03PM +0100, Gregory CLEMENT wrote:
>>>>> +static struct property i2c_offload_broken = {
>>>>> +	.name = "offload-broken",
>>>>> +};
>>>>> +
>>>>> +static void __init i2c_quirk(void)
>>>>> +{
>>>>> +	struct device_node *np;
>>>>> +	u32 dev, rev;
>>>>> +
>>>>> +	/*
>>>>> +	 * Only revisons more recent than A0 support the offload
>>>>> +	 * mechanism. We can exit only if we are sure that we can
>>>>> +	 * get the SoC revision and it is more recent than A0.
>>>>> +	 */
>>>>> +	if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
>>>>> +		return;
>>>>> +
>>>>> +	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c")
>>>>> +		of_add_property(np, &i2c_offload_broken);
>>>>
>>>> I like this approach.
>>>
>>> Sorry, but I don't.
>>>
>>>> However, when I first read this I thought it should be a -a0 specific
>>>> compatible string, not a 'offload-broken' property - any idea what the
>>>> DT consensus is here? I've seen both approach in use ..
>>>
>>> I prefer the replacement of the compatible string. If it should really
>>> be a seperate property, then it should be a vendor specific property. It
>>> is not generic, at all.
>>
>> Something like "marvell,offload-broken" would be acceptable?
> 
> A tad more, yes. Still, since this is a feature/quirk of the IP core
> revision, it should be deduced from the compatible property IMO. It
> cannot be configured anywhere, so it doesn't change on board level.

So you would prefer using the "marvell,mv78230-a0-i2c" comaptible string and
updating it with the follwing piece of code?

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index e2acff98e750..8c4ecf987e82 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -21,6 +21,8 @@
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
+#include <linux/mvebu-soc-id.h>
+#include <linux/slab.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -45,8 +47,38 @@ static void __init armada_370_xp_timer_and_clk_init(void)
 #endif
 }

+static void __init i2c_quirk(void)
+{
+       struct device_node *np;
+       u32 dev, rev;
+       int i = 0;
+
+       /*
+        * Only revisons more recent than A0 support the offload
+        * mechanism. We can exit only if we are sure that we can
+        * get the SoC revision and it is more recent than A0.
+        */
+       if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
+               return;
+
+       for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
+               struct property *new_compat;
+
+               new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+
+               new_compat->name =  kstrdup("compatible", GFP_KERNEL);
+               new_compat->length =  sizeof("marvell,mv78230-a0-i2c");
+               new_compat->value =  kstrdup("marvell,mv78230-a0-i2c",
+                                               GFP_KERNEL);
+
+               of_update_property(np, new_compat);
+       }
+       return;
+}
+
 static void __init armada_370_xp_dt_init(void)
 {
+       i2c_quirk();
        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }


> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
