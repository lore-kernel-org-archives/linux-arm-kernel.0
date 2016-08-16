From: sricharan@codeaurora.org (Sricharan)
Date: Tue, 16 Aug 2016 17:58:51 +0530
Subject: [PATCH 5/8] drivers: platform: Configure dma operations at probe
 time
In-Reply-To: <14864888.EhQqoi8buh@avalon>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-6-git-send-email-sricharan@codeaurora.org>
 <14864888.EhQqoi8buh@avalon>
Message-ID: <000701d1f7b9$c2c4e8b0$484eba10$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

>Hi Sricharan,
>
>Thank you for the patch.
>
>On Tuesday 09 Aug 2016 04:19:07 Sricharan R wrote:
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/base/dd.c           | 11 +++++++++++
>>  drivers/base/dma-mapping.c  | 11 +++++++++++
>>  include/linux/dma-mapping.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 16688f5..b9978af 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -19,6 +19,7 @@
>>
>>  #include <linux/device.h>
>>  #include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/module.h>
>>  #include <linux/kthread.h>
>>  #include <linux/wait.h>
>> @@ -353,6 +354,10 @@ static int really_probe(struct device *dev, struct
>> device_driver *drv) if (ret)
>>  		goto pinctrl_bind_failed;
>>
>> +	ret = dma_configure_ops(dev);
>
>Your patch doesn't remove the of_dma_configure_ops() from
>of_platform_device_create_pdata(). Unless I'm mistaken, you will then end up
>configuring the DMA ops twice, which at least on ARM will be a no-op the
>second time:
    I did remove both of_dmaconfigure/deconfigure from other places, but
    i did as a separate next patch [1]  (should have been squashed here).
     I will squash for the next repost.

[1] https://www.spinics.net/lists/arm-kernel/msg522510.html

Regards,
 Sricharan
