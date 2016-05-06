From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 08:26:28 +0200
Subject: [RFC v2 09/13] power: pwrseq: Add support for USB hubs with
 external power
In-Reply-To: <3bdf7888-5ed1-2a55-6607-ee8be70e25e7@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-10-git-send-email-k.kozlowski@samsung.com>
 <3bdf7888-5ed1-2a55-6607-ee8be70e25e7@osg.samsung.com>
Message-ID: <572C3914.4040708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 09:52 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> Some USB devices on embedded boards have external power supply which has
>> to be reset in certain conditions. Add pwrseq interface for this.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/power/pwrseq/pwrseq.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pwrseq.h        |  8 ++++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
>> index 495a19d3c30b..306265f55a10 100644
>> --- a/drivers/power/pwrseq/pwrseq.c
>> +++ b/drivers/power/pwrseq/pwrseq.c
>> @@ -52,6 +52,43 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>>  }
>>  EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
>>  
>> +struct pwrseq *pwrseq_alloc(struct device *dev)
>> +{
> 
> This function is USB specific so better to call it usb_pwrseq_alloc() instead.

Indeed it is parsing USB specific bindings so such prefix is needed.

> Although, this function has a lot of duplicated code from mmc_pwrseq_alloc()
> so I think is better to keep the name generic and factorize the common code.
> 
> I expect other devices are also needing some kind of power seq in the future
> so having a single alloc function instead of each for device type makes sense.

Yes, this can be cleaned up and unified.

> 
>> +	struct device_node *np;
>> +	struct pwrseq *p, *ret = NULL;
>> +
>> +	np = of_parse_phandle(dev->of_node, "usb-pwrseq", 0);
> 
> I know this is just an RFC but you should really add DT bindings for this.

Yep, next step.

Best regards,
Krzysztof
