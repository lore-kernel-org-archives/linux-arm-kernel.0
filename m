From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 7 Jun 2016 14:00:55 +0100
Subject: [PATCH 1/3] firmware: arm_scpi: add support for device power
 state management
In-Reply-To: <1465304305.2833.13.camel@linaro.org>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-2-git-send-email-sudeep.holla@arm.com>
 <1465304305.2833.13.camel@linaro.org>
Message-ID: <5756C587.7090105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/06/16 13:58, Jon Medhurst (Tixy) wrote:
> On Mon, 2016-06-06 at 16:53 +0100, Sudeep Holla wrote:
>> SCPI protocol supports device power state management. This deals with
>> power states of various peripheral devices in the system other than the
>> core compute subsystem.
>>
>> This patch adds support for the power state management of those
>> peripheral devices.
>>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/firmware/arm_scpi.c   | 29 +++++++++++++++++++++++++++++
>>   include/linux/scpi_protocol.h |  2 ++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>> index 51c6db0774cc..ca6afd2217a8 100644
>> --- a/drivers/firmware/arm_scpi.c
>> +++ b/drivers/firmware/arm_scpi.c
>> @@ -231,6 +231,11 @@ struct sensor_value {
>>   	__le32 hi_val;
>>   } __packed;
>>
>> +struct dev_pstate_set {
>> +	u16 dev_id;
>> +	u8 pstate;
>> +} __packed;
>> +
>>   static struct scpi_drvinfo *scpi_info;
>>
>>   static int scpi_linux_errmap[SCPI_ERR_MAX] = {
>> @@ -537,6 +542,28 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
>>   	return ret;
>>   }
>>
>> +static int scpi_device_get_power_state(u16 dev_id)
>> +{
>> +	int ret;
>> +	u8 pstate;
>> +
>> +	ret = scpi_send_message(SCPI_CMD_GET_DEVICE_PWR_STATE, &dev_id,
>> +				sizeof(dev_id), &pstate, sizeof(pstate));
>
> Don't you need to run translate dev_id to little-endian before sending
> it? You remembered to do that next function...
>

Good catch, that's the reason I added the get_power_state call in
scpi_genpd code to cover testing but still I failed.

Thanks for catching this.

-- 
Regards,
Sudeep
