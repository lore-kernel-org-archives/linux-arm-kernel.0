From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 04 Mar 2015 12:16:49 +0000
Subject: [PATCH 1/5] arm-cci: Rearrange code for splitting PMU vs driver
 code
In-Reply-To: <54F5D4B6.40409@arm.com>
References: <1425295754-13376-1-git-send-email-suzuki.poulose@arm.com>
 <1425295754-13376-2-git-send-email-suzuki.poulose@arm.com>
 <54F5D4B6.40409@arm.com>
Message-ID: <54F6F7B1.1020300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 15:35, Sudeep Holla wrote:
>
>
> On 02/03/15 11:29, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> No functional changes, only code re-arrangements for easier split of the
>> PMU code vs low level driver code. Extracts the port handling code
>> to cci_probe_ports().
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>    drivers/bus/arm-cci.c |  330 +++++++++++++++++++++++++------------------------
>>    1 file changed, 168 insertions(+), 162 deletions(-)
>>
>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>> index 84fd660..f27cf56 100644
>> --- a/drivers/bus/arm-cci.c
>> +++ b/drivers/bus/arm-cci.c
>
> [...]
>
>> @@ -1395,11 +1412,36 @@ static int cci_probe(void)
>>    	sync_cache_w(&cpu_port);
>>    	__sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);
>>    	pr_info("ARM CCI driver probed\n");
>> +
>>    	return 0;
>> +}
>> +
>> +static int cci_probe(void)
>> +{
>> +	int ret;
>> +	struct device_node *np;
>> +	struct resource res;
>> +
>> +	np = of_find_matching_node(NULL, arm_cci_matches);
>> +	if (!np)
>> +		return -ENODEV;
>>
>> -memalloc_err:
>> +	if (!of_device_is_available(np))
>> +		return -ENODEV;
>> +
>> +	ret = of_address_to_resource(np, 0, &res);
>> +	if (!ret) {
>> +		cci_ctrl_base = ioremap(res.start, resource_size(&res));
>> +		cci_ctrl_phys =	res.start;
>> +	}
>> +	if (ret || !cci_ctrl_base) {
>> +		WARN(1, "unable to ioremap CCI ctrl\n");
>> +		ret = -ENXIO;
>> +		goto out;
>
> IMO you can return directly here and get rid of this goto as nothing is
> done there.
>
Yes, you are right. I will fix that in the next revision.

Regards
Suzuki
