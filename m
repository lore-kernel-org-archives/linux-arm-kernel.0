From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 11:33:14 +0100
Subject: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada
 XP SOCs
In-Reply-To: <20150310190507.64b3c153@free-electrons.com>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
 <20150310190507.64b3c153@free-electrons.com>
Message-ID: <5502BCEA.7000209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2015 07:05 PM, Thomas Petazzoni wrote:
> Hello Daniel,
>
> I know you suggested a more rigorous method of determining the exit
> latency and target residency times, but would it be nonetheless
> possible to apply this patch, which clearly improves performance a lot,
> and actually makes the code match the values used in the vendor kernel?
>
> I also think this patch should be marked for stable, it fixes values
> introduced in commit b858fbc1919720f7f54360098ece03b383e961fa, and
> should therefore be backported all the way to v3.16.

I applied the patch for v4.1.

I will let you send later an mail to stable@ with the commit-id to ask 
backport. I don't want to put a stable@ tag in the patch as it does not 
enter in the stable kernel rules.

Thanks
   -- Daniel



> On Fri, 13 Feb 2015 15:55:03 +0100 (CET), s. rannou wrote:
>> Originally, the thresholds used in the cpuidle driver for Armada SOCs
>> were temporarily chosen, leaving room for improvements.
>>
>> This commit updates the thresholds for the Armada XP SOCs with values
>> that positively impact performances:
>>
>>                                  without patch  with patch   vendor kernel
>>   - iperf localhost (gbit/sec)   ~3.7           ~6.4         ~5.4
>>   - ioping tmpfs (iops)          ~163k          ~206k        ~179k
>>   - ioping tmpfs (mib/s)         ~636           ~805         ~699
>>
>> The idle power consumption is negatively impacted (proportionally less
>> than the performance gain), and we are still performing better than
>> the vendor kernel here:
>>
>>                                  without patch   with patch  vendor kernel
>>   - power consumption idle (W)   ~2.4            ~3.2        ~4.4
>>   - power consumption busy (W)   ~8.6            ~8.3        ~8.6
>>
>> There is still room for improvement regarding the value of these
>> thresholds, they were chosen to mimic the vendor kernel.
>>
>> This patch only impacts Armada XP SOCs and was tested on Online Labs
>> C1 boards. A similar approach can be taken to improve the performances
>> of the Armada 370 and Armada 38x SOCs.
>>
>> Thanks a lot to Thomas Petazzoni, Gregory Clement and Willy Tarreau
>> for the discussions and tips around this topic.
>>
>> Signed-off-by: Sebastien Rannou <mxs@sbrk.org>
>> ---
>>   drivers/cpuidle/cpuidle-mvebu-v7.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
>> index 38e6861..3716a1f 100644
>> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
>> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
>> @@ -50,17 +50,17 @@ static struct cpuidle_driver armadaxp_idle_driver = {
>>   	.states[0]		= ARM_CPUIDLE_WFI_STATE,
>>   	.states[1]		= {
>>   		.enter			= mvebu_v7_enter_idle,
>> -		.exit_latency		= 10,
>> +		.exit_latency		= 100,
>>   		.power_usage		= 50,
>> -		.target_residency	= 100,
>> +		.target_residency	= 1000,
>>   		.name			= "MV CPU IDLE",
>>   		.desc			= "CPU power down",
>>   	},
>>   	.states[2]		= {
>>   		.enter			= mvebu_v7_enter_idle,
>> -		.exit_latency		= 100,
>> +		.exit_latency		= 1000,
>>   		.power_usage		= 5,
>> -		.target_residency	= 1000,
>> +		.target_residency	= 10000,
>>   		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
>>   		.name			= "MV CPU DEEP IDLE",
>>   		.desc			= "CPU and L2 Fabric power down",
>
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
