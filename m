From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 13 Mar 2018 13:51:28 +0000
Subject: [alsa-devel] [PATCH v4 07/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
 <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
Message-ID: <e2c668dd-aad5-db06-cc92-e27c57cf598e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Rohit for the review,

On 13/03/18 11:29, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>>
> [..]
>> +        if (res->status) {
>> +            dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
>> +                res->opcode, res->status);
>> +        }
>> +        switch (res->opcode) {
>> +        case AFE_PORT_CMD_SET_PARAM_V2:
>> +        case AFE_PORT_CMD_DEVICE_STOP:
>> +        case AFE_PORT_CMD_DEVICE_START:
> 
> case AFE_SVC_CMD_SET_PARAM: needs to be added
thanks for spotting this, Will add this back

>> +            port = afe_find_port(afe, data->token);
>> +            if (port) {
>> +                port->result = *res;
>> +                wake_up(&port->wait);
>> +            }
> [..]
>> +
>> +static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
>> +                   int param_id, int psize)
>> +{

...
>> +    ret = afe_apr_send_pkt(afe, data, port);
>> +    if (ret)
>> +        dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
> 
> we should add %s to distinguish different functions with similar error 
> logs. Also, q6afe_port_set_param_v2() can be called for different 
> purpose.  AFE enable for port 0x%x failed is suitable only for port 
> start failure. Error message needs to be updated here.
> 
q6afe_callback already has a extra level of error message which shows 
the opcode and error code in failure cases.

thanks,
srini

>> +               port_id, ret);
>> +
>> +
>> +    return ret;
>> +}
>> +
