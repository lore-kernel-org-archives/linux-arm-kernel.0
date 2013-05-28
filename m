From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 28 May 2013 14:48:16 +0800
Subject: [PATCH] thermal: cpu_cooling: fix 'descend' check in
 get_property()
In-Reply-To: <1369722152-9732-1-git-send-email-shawn.guo@linaro.org>
References: <1369722152-9732-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1369723696.2083.44.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-28 at 14:22 +0800, Shawn Guo wrote:
> The variable 'descend' is initialized as -1 in function get_property(),
> and will never get any chance to be updated by the following code.
> 
> 	if (freq != CPUFREQ_ENTRY_INVALID && descend != -1)
> 		descend = !!(freq > table[i].frequency);
> 
> This makes function get_property() return the wrong frequency for given
> cooling level if the frequency table is sorted in ascending.  Fix it
> by correcting the 'descend' check in if-condition to 'descend == -1'.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

good catch!
patch applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/cpu_cooling.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index c94bf2e..82e15db 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -167,7 +167,7 @@ static int get_property(unsigned int cpu, unsigned long input,
>  			continue;
>  
>  		/* get the frequency order */
> -		if (freq != CPUFREQ_ENTRY_INVALID && descend != -1)
> +		if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
>  			descend = !!(freq > table[i].frequency);
>  
>  		freq = table[i].frequency;
