From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 11 Apr 2013 14:55:06 -0400
Subject: [v2,05/14] thermal: mvebu: Convert to devm_ioremap_resource()
In-Reply-To: <5166E66B.6080406@ti.com>
References: <1363991114-4225-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <5166E66B.6080406@ti.com>
Message-ID: <5167070A.1070809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On 11-04-2013 12:35, Eduardo Valentin wrote:
> Rui,
>
> On 22-03-2013 18:25, Ezequiel Garcia wrote:
>> Convert devm_request_and_ioremap() to the newly introduced
>> devm_ioremap_resource() which provides more consistent error handling.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>
>
> This patch looks correct to me too.
>
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>


I know you have discarded the idea of merging the driver into a single 
driver, but can you please resend this patch on top of 
drivers/thermal/kirkwood_thermal.c file. This change still applies.

>> ---
>> drivers/thermal/mvebu_thermal.c |    8 +++-----
>>   1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/mvebu_thermal.c
>> b/drivers/thermal/mvebu_thermal.c
>> index 1f502ed..2aeaf75 100644
>> --- a/drivers/thermal/mvebu_thermal.c
>> +++ b/drivers/thermal/mvebu_thermal.c
>> @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct
>> platform_device *pdev)
>>       if (!priv)
>>           return -ENOMEM;
>>
>> -    priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
>> -    if (!priv->sensor) {
>> -        dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
>> -        return -EADDRNOTAVAIL;
>> -    }
>> +    priv->sensor = devm_ioremap_resource(&pdev->dev, res);
>> +    if (IS_ERR(priv->sensor))
>> +        return PTR_ERR(priv->sensor);
>>
>>       thermal = thermal_zone_device_register("mvebu_thermal", 0, 0,
>>                              priv, &ops, NULL, 0, 0);
>>
>
>
>
