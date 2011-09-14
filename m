From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 14 Sep 2011 23:26:49 +0530
Subject: [PATCH v3 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance
	to non-dt build
In-Reply-To: <20110914162633.GL3134@ponder.secretlab.ca>
References: <1315852165-32402-1-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-2-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-3-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-4-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-5-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-6-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-7-git-send-email-thomas.abraham@linaro.org>
	<20110914162633.GL3134@ponder.secretlab.ca>
Message-ID: <CAJuYYwRX20_qB69--dz2a9WrShN3hpUc_wSepdQ14D0Vr5QXoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 14 September 2011 21:56, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Sep 12, 2011 at 11:59:25PM +0530, Thomas Abraham wrote:
>> The pl330 device instances and associated platform data is required only
>> for non-device-tree builds. With device tree enabled, the data about the
>> platform is obtained from the device tree. For images that include both
>> dt and non-dt platforms, an addditional check is added to ensure that
>> static amba device registrations is applicable to only non-dt platforms.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
>> index c3c0d17..3203a31 100644
>> --- a/arch/arm/mach-exynos4/dma.c
>> +++ b/arch/arm/mach-exynos4/dma.c
>> @@ -24,6 +24,7 @@
>> ?#include <linux/dma-mapping.h>
>> ?#include <linux/amba/bus.h>
>> ?#include <linux/amba/pl330.h>
>> +#include <linux/of.h>
>>
>> ?#include <asm/irq.h>
>> ?#include <plat/devs.h>
>> @@ -138,6 +139,11 @@ struct amba_device exynos4_device_pdma1 = {
>>
>> ?static int __init exynos4_dma_init(void)
>> ?{
>> +#ifdef CONFIG_OF
>> + ? ? if (of_have_populated_dt())
>> + ? ? ? ? ? ? return 0;
>> +#endif
>> +
>
> Drop the #ifdef. ?of_have_populated_dt() has an empty stub for
> !CONFIG_OF. ?Otherwise looks good to me. ?Well done not breaking
> non-DT support when CONFIG_OF is enabled. ?:-)

Ok. I will drop the #ifdef. Well, I actually learnt from you on not
breaking non-dt support because of your comments on my earlier patches
which did break non-dt support. Thanks.

>
> The other patches in this series look good to me too.
>
> g.

Thanks for your review. I will do the changes you have recommended for
the pl330 dt support patches and resubmit. I would like to add your
Ack to the patches when resubmitting.

Regards,
Thomas.
