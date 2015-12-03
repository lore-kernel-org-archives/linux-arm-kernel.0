From: ben@smart-cactus.org (Ben Gamari)
Date: Thu, 03 Dec 2015 15:37:44 +0100
Subject: [PATCH 11/12] cpufreq: arm-big-little: clarify frequency units
In-Reply-To: <1449152534.2817.26.camel@linaro.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <1449091167-20758-12-git-send-email-ben@smart-cactus.org>
 <1449152534.2817.26.camel@linaro.org>
Message-ID: <87egf338ef.fsf@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Jon Medhurst (Tixy)" <tixy@linaro.org> writes:

> On Wed, 2015-12-02 at 22:19 +0100, Ben Gamari wrote:
>> The frequency units are very confusing in this area as OPPs use Hz
>> whereas cpufreq uses kHz. Be explicit about this in variable naming.
>> 
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
>> ---
>>  drivers/cpufreq/arm_big_little.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index 855599b..2d5761c 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -130,14 +130,14 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
>>  }
>>  
>>  static int
>> -bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>> +bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
>>  {
>>  	unsigned long volt = 0, volt_old = 0;
>>  	long freq_Hz;
>>  	u32 old_rate;
>
> IMO variable renaming doesn't seem necessary, if cpufreq uses kHz then
> in a cpufreq driver adding 'kHz' to variable seems redundant, especially
> if Hz values like freq_Hz above are named especially to signal their
> different units.
> 
Correct; it isn't strictly necessary but it would have saved me half an
hour of poking around trying work out the intent of this code.

> However, if renaming is going to happen it should at
> least be consistent within the same function i.e. also rename the old
> old_rate variable above.
>
That's a reasonable objection. I'd be happy to do that.

snip
>>  static unsigned int
>> -bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>> +bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate_kHz)
>>  {
>>  	u32 new_rate, prev_rate;
>
> Ditto. Rename these too to add '_kHz' ?
>
Sure.
>>  	int ret;
>> @@ -209,13 +209,13 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>>  
>>  	if (bLs) {
>>  		prev_rate = per_cpu(cpu_last_req_freq, cpu);
>> -		per_cpu(cpu_last_req_freq, cpu) = rate;
>> +		per_cpu(cpu_last_req_freq, cpu) = rate_kHz;
>>  		per_cpu(physical_cluster, cpu) = new_cluster;
>>  
>>  		new_rate = find_cluster_maxfreq(new_cluster);
>>  		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
>>  	} else {
>> -		new_rate = rate;
>> +		new_rate = rate_kHz;
>>  	}
>>  
>>  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
>> @@ -236,7 +236,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>>  	} else if (ret && bLs) {
>>  		per_cpu(cpu_last_req_freq, cpu) = prev_rate;
>>  		per_cpu(physical_cluster, cpu) = old_cluster;
>> -	} 
>> +	}
>
> There's a spurious whitespace change here. I know the space you deleted
> shouldn't have been there, but doing tidyups like that generally isn't
> done in patches that don't otherwise affect the code in question.
>
Alright, I can drop that change.

Cheers,

- Ben

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/f9c0b9e2/attachment.sig>
