From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 23 Feb 2015 15:45:06 +0000
Subject: [PATCH] drivers/base: cacheinfo: validate device node for all
 the caches
In-Reply-To: <20150223151454.GL9714@leverpostej>
References: <1424095816-4414-1-git-send-email-sudeep.holla@arm.com>
 <20150223151454.GL9714@leverpostej>
Message-ID: <54EB4B02.9070304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/02/15 15:14, Mark Rutland wrote:
> On Mon, Feb 16, 2015 at 02:10:16PM +0000, Sudeep Holla wrote:
>> On architectures that depend on DT for obtaining cache hierarcy, we need
>> to validate the device node for all the cache indices, failing to do so
>> might result in wrong information being exposed to the userspace.
>>
>> This is quite possible on initial/incomplete versions of the device
>> trees. In such cases, it's better to bail out if all the required device
>> nodes are not present.
>>
>> This patch adds checks for the validation of device node for all the
>> caches and doesn't initialise the cacheinfo if there's any error.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Reported-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/base/cacheinfo.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 6e64563361f0..7015bf05c828 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c

[...]

>> @@ -189,8 +195,10 @@ static int detect_cache_attributes(unsigned int cpu)
>>   	 * will be set up here only if they are not populated already
>>   	 */
>>   	ret = cache_shared_cpu_map_setup(cpu);
>> -	if (ret)
>> +	if (ret) {
>> +		pr_err("failed to setup cache hierarcy from DT\n");
>
> It would probably be better if this were something like:
>
> pr_warn("Unable to detect cache hierarcy from DT for CPU %d\n",
> 	cpu);
>

Agreed, will update and send v2.

> Otherwise, this looks sane to me, and it would be nice to have this in
> ASAP so as to avoid exposing erroneous information to userspace. So:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks.

Regards,
Sudeep
