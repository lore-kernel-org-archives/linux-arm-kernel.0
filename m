From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 3 Oct 2017 00:07:50 +0200
Subject: [PATCH 3/5] firmware: arm_scpi: pre-populate dvfs info in
 scpi_probe
In-Reply-To: <d6578a58-b7ab-9770-d78d-1971d1e702d4@arm.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <c8c0ff86-de14-f157-68e0-9df005defffa@gmail.com>
 <d6578a58-b7ab-9770-d78d-1971d1e702d4@arm.com>
Message-ID: <db4476f4-df96-6ce5-ca5f-95141364fa62@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.10.2017 um 13:17 schrieb Sudeep Holla:
> 
> 
> On 29/09/17 22:44, Heiner Kallweit wrote:
>> Pre-populating the dvfs info data in scpi_probe allows to make all
>> memory allocations device-managed. This helps to simplify scpi_remove
>> and eventually to get rid of scpi_remove completely.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/firmware/arm_scpi.c | 57 ++++++++++++++++++++++++++++-----------------
>>  1 file changed, 35 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>> index d80d11ae..fd79adb5 100644
>> --- a/drivers/firmware/arm_scpi.c
>> +++ b/drivers/firmware/arm_scpi.c
>> @@ -644,35 +644,35 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
>>  }
>>  
>>  static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
>> +{
>> +	if (domain >= MAX_DVFS_DOMAINS)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return scpi_info->dvfs[domain] ?: ERR_PTR(-EINVAL);
>> +}
>> +
>> +static int scpi_dvfs_populate_info(struct device *dev, u8 domain)
>>  {
>>  	struct scpi_dvfs_info *info;
>>  	struct scpi_opp *opp;
>>  	struct dvfs_info buf;
>>  	int ret, i;
>>  
>> -	if (domain >= MAX_DVFS_DOMAINS)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	if (scpi_info->dvfs[domain])	/* data already populated */
>> -		return scpi_info->dvfs[domain];
>> -
>>  	ret = scpi_send_message(CMD_GET_DVFS_INFO, &domain, sizeof(domain),
>>  				&buf, sizeof(buf));
>>  	if (ret)
>> -		return ERR_PTR(ret);
>> +		return ret;
>>  
>> -	info = kmalloc(sizeof(*info), GFP_KERNEL);
>> +	info = devm_kmalloc(dev, sizeof(*info), GFP_KERNEL);
>>  	if (!info)
>> -		return ERR_PTR(-ENOMEM);
>> +		return -ENOMEM;
>>  
>>  	info->count = DVFS_OPP_COUNT(buf.header);
>>  	info->latency = DVFS_LATENCY(buf.header) * 1000; /* uS to nS */
>>  
>> -	info->opps = kcalloc(info->count, sizeof(*opp), GFP_KERNEL);
>> -	if (!info->opps) {
>> -		kfree(info);
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> +	info->opps = devm_kcalloc(dev, info->count, sizeof(*opp), GFP_KERNEL);
>> +	if (!info->opps)
>> +		return -ENOMEM;
>>  
>>  	for (i = 0, opp = info->opps; i < info->count; i++, opp++) {
>>  		opp->freq = le32_to_cpu(buf.opps[i].freq);
>> @@ -682,7 +682,20 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
>>  	sort(info->opps, info->count, sizeof(*opp), opp_cmp_func, NULL);
>>  
>>  	scpi_info->dvfs[domain] = info;
>> -	return info;
>> +	return 0;
>> +}
>> +
>> +static int scpi_dvfs_populate(struct device *dev)
>> +{
>> +	int ret, i;
>> +
>> +	for (i = 0; i < MAX_DVFS_DOMAINS; i++) {
>> +		ret = scpi_dvfs_populate_info(dev, i);
>> +		if (ret)
>> +			break;
> 
> Does it make sense to continue to complete all MAX_DVFS_DOMAINS ?
> Just wondering if there will be any firmware that returns errors for
> few domains(e.g. not supported in initial versions of firmware).
> I don't want to stop probing due to that. Let me know what you think.
> 
The (legacy) SCPI firmware on my system seems to ignore the domain
in CMD_GET_DVFS_INFO. It returns the same dvfs info independent of
the domain parameter. So indeed prepopulating may not be the best idea.

Still we need to do something in the remove callback to deal with the
scenario you describe (error for few domains).

Remove does
for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
and therefore stops at the first unpopulated domain and doesn't free
the memory for further populated domains. I'll provide a patch for it.
