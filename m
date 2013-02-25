From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Mon, 25 Feb 2013 07:53:47 -0600
Subject: [PATCH v2] cpufreq: highbank: do not initialize array with a loop
In-Reply-To: <1361790465-21760-1-git-send-email-emilio@elopez.com.ar>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
 <1361790465-21760-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <512B6CEB.1030203@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2013 05:07 AM, Emilio L?pez wrote:
> As uninitialized array members will be initialized to zero, we can
> avoid using a for loop by setting a value to it.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> Note that I don't own any device using this driver, it has only been compile
> tested, but it shouldn't cause any issues.
> 
> Changes v1 -> v2:
>   * Move freq / 1000000 to the array definition as suggested by Viresh Kumar
> 
>  drivers/cpufreq/highbank-cpufreq.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
> index 66e3a71..b61b5a3 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -28,13 +28,7 @@
>  
>  static int hb_voltage_change(unsigned int freq)
>  {
> -	int i;
> -	u32 msg[HB_CPUFREQ_IPC_LEN];
> -
> -	msg[0] = HB_CPUFREQ_CHANGE_NOTE;
> -	msg[1] = freq / 1000000;
> -	for (i = 2; i < HB_CPUFREQ_IPC_LEN; i++)
> -		msg[i] = 0;
> +	u32 msg[HB_CPUFREQ_IPC_LEN] = {HB_CPUFREQ_CHANGE_NOTE, freq / 1000000};
>  
>  	return pl320_ipc_transmit(msg);
>  }
> 
Thanks for the improvement.

Acked-By: Mark Langsdorf <mark.langsdorf@calxeda.com>

--Mark Langsdorf
Calxeda, Inc.
