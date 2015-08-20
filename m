From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 20 Aug 2015 03:18:30 -0500
Subject: [PATCH v3 13/14] drm: bridge/analogix_dp: move hpd detect to
 connector detect function
In-Reply-To: <6E5CEF9B-19D4-4AC4-B5B1-BC667979302D@gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995939-18770-1-git-send-email-ykk@rock-chips.com>
 <6E5CEF9B-19D4-4AC4-B5B1-BC667979302D@gmail.com>
Message-ID: <55D58D56.5070505@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

On 08/20/2015 02:49 AM, Jingoo Han wrote:
> On 2015. 8. 19., at PM 11:52, Yakir Yang <ykk@rock-chips.com> wrote:
>
> What is the reason to make this patch?
>
> Please make commit message including the reason.

Okay, I think the below words would be okay :)

"This change just make a little clean to make code more like
drm core expect, move hdp detect code from bridge->enable(),
and place them into connector->detect()."

Thanks,
- Yakir

> Best regards,
> Jingoo Han
>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v3:
>> - move dp hpd detect to connector detect function.
>>
>> Changes in v2: None
>>
>> drivers/gpu/drm/bridge/analogix_dp_core.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix_dp_core.c
>> index 75dd44a..052b9b3 100644
>> --- a/drivers/gpu/drm/bridge/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
>> @@ -915,12 +915,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>>             DRM_ERROR("failed to disable the panel\n");
>>     }
>>
>> -    ret = analogix_dp_detect_hpd(dp);
>> -    if (ret) {
>> -        /* Cable has been disconnected, we're done */
>> -        return;
>> -    }
>> -
>>     ret = analogix_dp_handle_edid(dp);
>>     if (ret) {
>>         dev_err(dp->dev, "unable to handle edid\n");
>> @@ -953,6 +947,12 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>> static enum drm_connector_status analogix_dp_detect(
>>                 struct drm_connector *connector, bool force)
>> {
>> +    struct analogix_dp_device *dp = connector_to_dp(connector);
>> +
>> +    if (analogix_dp_detect_hpd(dp))
>> +        /* Cable has been disconnected, we're done */
>> +        return connector_status_disconnected;
>> +
>>     return connector_status_connected;
>> }
>>
>> -- 
>> 1.9.1
>>
>>
>
>
