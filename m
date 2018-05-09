From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 9 May 2018 07:05:11 +0100
Subject: [PATCH v7 11/24] ASoC: qdsp6: q6afe: Add support to MI2S ports
In-Reply-To: <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-12-srinivas.kandagatla@linaro.org>
 <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
Message-ID: <3e8b4622-81b9-2091-dfd9-22ea035a8b52@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Banajit for review!

On 09/05/18 04:21, Banajit Goswami wrote:
> 
> On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
>> This patch adds support to 4 MI2S ports on LPASS.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe.c | 224 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6afe.h |  13 +++
>>   2 files changed, 237 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
>> index be55b3ab045f..ceb18aaa5af4 100644
>> --- a/sound/soc/qcom/qdsp6/q6afe.c
>> +++ b/sound/soc/qcom/qdsp6/q6afe.c
>> @@ -14,6 +14,10 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/delay.h>
>>   #include <linux/soc/qcom/apr.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include <sound/pcm.h>
> <snip>
> 
>>   union afe_port_config {
>>       struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
>>       struct afe_param_id_slimbus_cfg           slim_cfg;
>> +    struct afe_param_id_i2s_cfg    i2s_cfg;
>>   } __packed;
>>   struct q6afe_port {
>> @@ -210,6 +264,22 @@ static struct afe_port_map 
>> port_maps[AFE_PORT_MAX] = {
>>                   SLIMBUS_4_RX, 1, 1},
>>       [SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
>>                   SLIMBUS_5_RX, 1, 1},
>> +    [QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
>> +                QUATERNARY_MI2S_RX, 1, 1},
>> +    [QUATERNARY_MI2S_TX] = { AFE_PORT_ID_QUATERNARY_MI2S_TX,
>> +                QUATERNARY_MI2S_TX, 0, 1},
>> +    [SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
>> +                SECONDARY_MI2S_RX, 1, 1},
>> +    [SECONDARY_MI2S_TX] = { AFE_PORT_ID_SECONDARY_MI2S_TX,
>> +                SECONDARY_MI2S_TX, 0, 1},
>> +    [TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
>> +                TERTIARY_MI2S_RX, 1, 1},
>> +    [TERTIARY_MI2S_TX] = { AFE_PORT_ID_TERTIARY_MI2S_TX,
>> +                TERTIARY_MI2S_TX, 0, 1},
>> +    [PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
>> +                PRIMARY_MI2S_RX, 1, 1},
>> +    [PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
>> +                PRIMARY_MI2S_RX, 0, 1},
> Can these be added after SLIMBUS_6_RX?
> Also, for better arrangement, please add the port_maps from 
> PRIMARY_MI2S_RX to QUATERNARY_MI2S_TX in the same sequence of definition 
> of AFE ports.
> Otherwise LGTM.
Yep, I have reordered this now!

> Once fixed the above comment add-
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 
