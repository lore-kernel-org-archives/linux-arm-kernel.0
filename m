From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 14 Feb 2013 11:27:00 +0200
Subject: [PATCH v2 02/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <CAD6h2NRO6N1pRfq_=ybj5TSwC7gieYOffcQmfTyUiP5R_3fWig@mail.gmail.com>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-3-git-send-email-haojian.zhuang@linaro.org>
 <511BA0AF.8040904@compulab.co.il>
 <CAD6h2NRO6N1pRfq_=ybj5TSwC7gieYOffcQmfTyUiP5R_3fWig@mail.gmail.com>
Message-ID: <511CADE4.1000007@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/13 16:55, Haojian Zhuang wrote:
> On 13 February 2013 22:18, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> On 02/03/13 12:15, Haojian Zhuang wrote:
>>> Avoid to use global irq_base in gpio-pxa driver. Define irq_base in each
>>> pxa_gpio_chip instead. Then we can avoid to use macro PXA_GPIO_TO_IRQ() &
>>> MMP_GPIO_TO_IRQ().
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> Ok. This patch breaks the NFS root on my PXA based systems.
>> I still haven't found the cause of the breakage.
>>
> 
> It's so strange. I tested it OK on pxa910 without DT. Could you help
> to check whether your GPIO interrupt still works?

It looks like I've figured this out...
For em-x270 as an example, if I move the IRQ resource assignment to runtime:

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 1b64114..178cc0b 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -210,8 +210,6 @@ static struct resource em_x270_dm9000_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[2] = {
-		.start = EM_X270_ETHIRQ,
-		.end   = EM_X270_ETHIRQ,
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -232,6 +230,9 @@ static struct platform_device em_x270_dm9000 = {
 
 static void __init em_x270_init_dm9000(void)
 {
+	em_x270_dm9000_resource[2].start = gpio_to_irq(GPIO41_ETHIRQ);
+	em_x270_dm9000_resource[2].end = gpio_to_irq(GPIO41_ETHIRQ);
+
 	em_x270_dm9000_platdata.flags |= dm9000_flags;
 	platform_device_register(&em_x270_dm9000);
 }

The Ethernet is alive and NFS root works fine.

So my conclusion, is that we still need to have some work done
before we can switch to using IRQ_DOMAIN.
As you can see from above patch, we at least must deal with the
PXA_GPIO_TO_IRQ macros and alike that have compile time assumptions
which obviously get broken once you switch to the IRQ_DOMAIN.

What do you think?

-- 
Regards,
Igor.
