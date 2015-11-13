From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 13 Nov 2015 16:39:10 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <alpine.DEB.2.11.1511131025140.3903@nanos>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
 <5645D5A0.1000502@sigmadesigns.com> <5645F0D0.4060503@linaro.org>
 <5645F616.9060707@sigmadesigns.com>
 <alpine.DEB.2.11.1511131025140.3903@nanos>
Message-ID: <5646041E.4040209@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2015 16:26, Thomas Gleixner wrote:
> On Fri, 13 Nov 2015, Marc Gonzalez wrote:
>> On 13/11/2015 15:16, Daniel Lezcano wrote:
>>> For example:
>>>
>>> struct clockcommon {
>>> 	u32 mult;
>>> 	u32 shift;
>>> 	int rating;
>>> 	void __iomem *base;
>>> 	char *name;
>>> 	int irq;
>>> };
>>>
>>> struct clocksource {
>>> 	struct clockcommon common; /* MUST be the first field */
>>> 	cycle_t (*read)(struct clocksource *cs);
>>> 	cycle_t mask;
>>> 	...
>>> };
>>
>> According to my notes, commit 369db4c952 grouped hot-path data
>> into a single cache line (hence ____cacheline_aligned).
>>
>> (AFAIR, ARMv7 ARCH_MULTIPLATFORM assumes CACHE_LINE=64)
>>
>> Not sure how to make the two concepts (common base struct and
>> grouping hot data) play nicely, without wasting a lot of space
>> on padding.
> 
> It wont play well. We are not going to change the layout of struct
> clocksource because it will hurt the sane use cases for no reason.

You are referring to Daniel's proposed reorg, right?

What about my proposal? I inserted reg after maxadj, but it may be
inserted anywhere in the struct.


diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 278dd279a7a8..03807ca0d54e 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -74,6 +74,9 @@ struct clocksource {
 	u32 shift;
 	u64 max_idle_ns;
 	u32 maxadj;
+#ifdef CONFIG_CLKSRC_MMIO
+	void __iomem *reg;
+#endif
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
