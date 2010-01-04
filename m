From: ben@simtec.co.uk (Ben Dooks)
Date: Mon, 04 Jan 2010 11:45:32 +0900
Subject: [PATCH] mach-osiris-dvs.c: Convert boolean bit tests to logical
	tests
In-Reply-To: <1262539781.1932.128.camel@Joe-Laptop.home>
References: <1262539781.1932.128.camel@Joe-Laptop.home>
Message-ID: <4B41564C.6080802@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches wrote:
> Bit tests on booleans seem odd, logical tests more appropriate

I think this is ok, don't currently have any hardware on hand to
test it.

> Signed-off-by: Joe Perches <joe@perches.com>

Ackced-by: Ben Dooks <ben-linux@fluff.org>

> diff --git a/arch/arm/mach-s3c2440/mach-osiris-dvs.c b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
> index ad2792d..2367606 100644
> --- a/arch/arm/mach-s3c2440/mach-osiris-dvs.c
> +++ b/arch/arm/mach-s3c2440/mach-osiris-dvs.c
> @@ -69,16 +69,14 @@ static int osiris_dvs_notify(struct notifier_block *nb,
>  
>  	switch (val) {
>  	case CPUFREQ_PRECHANGE:
> -		if (old_dvs & !new_dvs ||
> -		    cur_dvs & !new_dvs) {
> +		if ((old_dvs && !new_dvs) || (cur_dvs && !new_dvs)) {
>  			pr_debug("%s: exiting dvs\n", __func__);
>  			cur_dvs = false;
>  			gpio_set_value(OSIRIS_GPIO_DVS, 1);
>  		}
>  		break;
>  	case CPUFREQ_POSTCHANGE:
> -		if (!old_dvs & new_dvs ||
> -		    !cur_dvs & new_dvs) {
> +		if ((!old_dvs && new_dvs) || (!cur_dvs && new_dvs)) {
>  			pr_debug("entering dvs\n");
>  			cur_dvs = true;
>  			gpio_set_value(OSIRIS_GPIO_DVS, 0);
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
