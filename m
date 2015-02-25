From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Feb 2015 11:01:54 +0100
Subject: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada
 XP SOCs
In-Reply-To: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
Message-ID: <54ED9D92.90506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 03:55 PM, s. rannou wrote:
> Originally, the thresholds used in the cpuidle driver for Armada SOCs
> were temporarily chosen, leaving room for improvements.
>
> This commit updates the thresholds for the Armada XP SOCs with values
> that positively impact performances:
>
>                                  without patch  with patch   vendor kernel
>   - iperf localhost (gbit/sec)   ~3.7           ~6.4         ~5.4
>   - ioping tmpfs (iops)          ~163k          ~206k        ~179k
>   - ioping tmpfs (mib/s)         ~636           ~805         ~699
>
> The idle power consumption is negatively impacted (proportionally less
> than the performance gain), and we are still performing better than
> the vendor kernel here:
>
>                                  without patch   with patch  vendor kernel
>   - power consumption idle (W)   ~2.4            ~3.2        ~4.4
>   - power consumption busy (W)   ~8.6            ~8.3        ~8.6
>
> There is still room for improvement regarding the value of these
> thresholds, they were chosen to mimic the vendor kernel.
>
> This patch only impacts Armada XP SOCs and was tested on Online Labs
> C1 boards. A similar approach can be taken to improve the performances
> of the Armada 370 and Armada 38x SOCs.
>
> Thanks a lot to Thomas Petazzoni, Gregory Clement and Willy Tarreau
> for the discussions and tips around this topic.

Hi Sebastien,

trying to tune the target residency and the exit latency is a good idea 
but you can have multiple results. If you increase the exit latency and 
the target residency, then the governor will choose a shallow state, 
thus improving the performance and degrading the power consumption. If 
you reduce the values, then the performance will degrade but the power 
saving will increase in an acceptable interval (until going to this 
state does not consume more energy).

If you have the possibility, I would suggest to apply the right 
methodology to find the right values by using the description in the 
wiki page [1]. If you can access to the energy values to enter / exit 
the state and the power consumed in each idle state, then you can 
mathematically compute the right values.

   -- Daniel

[1] 
https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/ComputingTargetResidency

>
> Signed-off-by: Sebastien Rannou <mxs@sbrk.org>
> ---
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
> index 38e6861..3716a1f 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -50,17 +50,17 @@ static struct cpuidle_driver armadaxp_idle_driver = {
>   	.states[0]		= ARM_CPUIDLE_WFI_STATE,
>   	.states[1]		= {
>   		.enter			= mvebu_v7_enter_idle,
> -		.exit_latency		= 10,
> +		.exit_latency		= 100,
>   		.power_usage		= 50,
> -		.target_residency	= 100,
> +		.target_residency	= 1000,
>   		.name			= "MV CPU IDLE",
>   		.desc			= "CPU power down",
>   	},
>   	.states[2]		= {
>   		.enter			= mvebu_v7_enter_idle,
> -		.exit_latency		= 100,
> +		.exit_latency		= 1000,
>   		.power_usage		= 5,
> -		.target_residency	= 1000,
> +		.target_residency	= 10000,
>   		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
>   		.name			= "MV CPU DEEP IDLE",
>   		.desc			= "CPU and L2 Fabric power down",
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
