From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Sep 2012 08:40:08 +0200
Subject: [PATCH V3 1/6] arm: cache-l2x0: make outer_cache_fns a field
 of l2x0_of_data
In-Reply-To: <20120915203539.GK12245@n2100.arm.linux.org.uk>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-2-git-send-email-gregory.clement@free-electrons.com>
 <20120915203539.GK12245@n2100.arm.linux.org.uk>
Message-ID: <505ABA48.1090208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2012 10:35 PM, Russell King - ARM Linux wrote:> On Wed, Sep 05, 2012 at 03:44:32PM +0200, Gregory CLEMENT wrote:
>> Instead of having multiple functions belonging to outer_cache and
>> filling this structure on the fly, use a outer_cache_fns field inside
>> l2x0_of_data and just memcopy it into outer_cache depending of the
>> type of the l2x0 cache. For non DT case, the former code was kept.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
>> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
>
> Just tried pulling this and got conflicts, so I looked a little deeper
> at this.  This patch advertises itself as merely changing the way
> outer_cache is initialized:
>
>> +#ifndef CONFIG_OF
>>  	outer_cache.inv_range = l2x0_inv_range;
>>  	outer_cache.clean_range = l2x0_clean_range;
>>  	outer_cache.flush_range = l2x0_flush_range;
>> @@ -383,6 +384,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>>  	outer_cache.flush_all = l2x0_flush_all;
>>  	outer_cache.inv_all = l2x0_inv_all;
>>  	outer_cache.disable = l2x0_disable;
>> +#endif
>
> It disables this assignment...
>
>>  static const struct l2x0_of_data pl310_data = {
> ...
>> +	.outer_cache = {
>> +		.resume      = pl310_resume,
>
> moves the resume here...

At the end of l2x0_of_init(), resume were assigned in the
outer_cache. It is the only place where this field is used.This patch
introduces an outer_cache_fn field. It seemed logical to use it. I
don't see where is the problem here.

>
>> +		.inv_range   = l2x0_inv_range,
>> +		.clean_range = l2x0_clean_range,
>> +		.flush_range = l2x0_flush_range,
>> +		.sync        = l2x0_cache_sync,
>> +		.flush_all   = l2x0_flush_all,
>> +		.inv_all     = l2x0_inv_all,
>> +		.disable     = l2x0_disable,
>
> initializes all these values that were previously set...

Well if CONFIG_OF is not set then these part of the code is not
compiled. The values arr not initialized here. If CONFIG_OF is set
then these values are not assigned before (due to the #ifndef
CONFIG_OF).

>
>> +		.set_debug   = pl310_set_debug,
>
> and adds one extra, which gets added because we blat over the assignment
> of it in l2x0_init() after we read the ID from the device.

As set_debug is also a field of outer_cache_fn field, it seemed
logical to assign it here.

>
> Plus, doesn't this patch break systems which may enable CONFIG_OF, but
> don't supply a DT file, relying on the old way to initialize the L2 cache
> operations functions?

Right I didn't think that we would want enable CONFIG_OF without using
a DT file. But indeed it is still possible. I can replace the ifndef
CONFIG_OF by a flag set in l2x0_of_init.

What do you think about this, then:



>From 76ab86c053edd47459332665ba032ca93826f23c Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Tue, 7 Aug 2012 10:39:41 +0200
Subject: [PATCH] arm: cache-l2x0: make outer_cache_fns a field of
 l2x0_of_data

Instead of having multiple functions belonging to outer_cache and
filling this structure on the fly, use a outer_cache_fns field inside
l2x0_of_data and just memcopy it into outer_cache depending of the
type of the l2x0 cache. For non DT case, the former code was kept.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>

Cc: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/cache-l2x0.c |   55 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2a8e380..8b9c0ae 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -39,8 +39,9 @@ struct l2x0_regs l2x0_saved_regs;
 struct l2x0_of_data {
 	void (*setup)(const struct device_node *, u32 *, u32 *);
 	void (*save)(void);
-	void (*resume)(void);
+	struct outer_cache_fns outer_cache;
 };
+static bool of_init = false;

 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
@@ -376,13 +377,15 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}

-	outer_cache.inv_range = l2x0_inv_range;
-	outer_cache.clean_range = l2x0_clean_range;
-	outer_cache.flush_range = l2x0_flush_range;
-	outer_cache.sync = l2x0_cache_sync;
-	outer_cache.flush_all = l2x0_flush_all;
-	outer_cache.inv_all = l2x0_inv_all;
-	outer_cache.disable = l2x0_disable;
+	if (!of_init) {
+		outer_cache.inv_range = l2x0_inv_range;
+		outer_cache.clean_range = l2x0_clean_range;
+		outer_cache.flush_range = l2x0_flush_range;
+		outer_cache.sync = l2x0_cache_sync;
+		outer_cache.flush_all = l2x0_flush_all;
+		outer_cache.inv_all = l2x0_inv_all;
+		outer_cache.disable = l2x0_disable;
+	}

 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
@@ -533,15 +536,34 @@ static void pl310_resume(void)
 }

 static const struct l2x0_of_data pl310_data = {
-	pl310_of_setup,
-	pl310_save,
-	pl310_resume,
+	.setup = pl310_of_setup,
+	.save  = pl310_save,
+	.outer_cache = {
+		.resume      = pl310_resume,
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.sync        = l2x0_cache_sync,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+		.disable     = l2x0_disable,
+		.set_debug   = pl310_set_debug,
+	},
 };

 static const struct l2x0_of_data l2x0_data = {
-	l2x0_of_setup,
-	NULL,
-	l2x0_resume,
+	.setup = l2x0_of_setup,
+	.save  = NULL,
+	.outer_cache = {
+		.resume      = l2x0_resume,
+		.inv_range   = l2x0_inv_range,
+		.clean_range = l2x0_clean_range,
+		.flush_range = l2x0_flush_range,
+		.sync        = l2x0_cache_sync,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+		.disable     = l2x0_disable,
+	},
 };

 static const struct of_device_id l2x0_ids[] __initconst = {
@@ -581,9 +603,12 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (data->save)
 		data->save();

+	/* */
+	of_init = true;
 	l2x0_init(l2x0_base, aux_val, aux_mask);

-	outer_cache.resume = data->resume;
+	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
+
 	return 0;
 }
 #endif
-- 
1.7.9.5
