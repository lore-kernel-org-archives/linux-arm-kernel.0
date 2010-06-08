From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 08 Jun 2010 13:23:06 +0200
Subject: [PATCH] pxa2xx/cpufreq: Fix DRI computation
In-Reply-To: <1275698808-31166-1-git-send-email-marek.vasut@gmail.com> (Marek
	Vasut's message of "Sat, 5 Jun 2010 02:46:48 +0200")
References: <1275698808-31166-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <87ljap7opx.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> The DRI field was incorrectly computed, causing various hangs and weird
> behaviour on PXA2xx machines. This patch introduces the DRI computation
> according to the PXA255 (January 2004) and PXA270 (MV-S301039-00 Rev. A)
> datasheets.
>
> NOTE: The CPU type is checked only once, so the code is a little bit faster now.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/cpufreq-pxa2xx.c |   33 +++++++++++++++++++++++++++++----
>  1 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> index 9e4d981..5373db0 100644
> --- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> +++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> @@ -251,17 +251,42 @@ static void init_sdram_rows(void)
>  	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
>  		drac0 = MDCNFG_DRAC0(mdcnfg);
>  
> -	sdram_rows = 1 << (11 + max(drac0, drac2));
> +	sdram_rows = 11 + max(drac0, drac2);
I don't think that's correct.

>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.0.1275996205.27306.linux-arm-kernel@lists.infradead.org>

that if drac == 2, then the SDRAM row is a number between 0 and (11+drac0) - 1.
That in turn means that the number of SDRAM rows is : 2 ^ (11 + drac0).
Example:
 - drac0 = 2 : row encoded on 13 bits => 2^13 rows (ie. 1 << (11 + 2)).

>  
>  static u32 mdrefr_dri(unsigned int freq)
>  {
>  	u32 dri = 0;
>  
> -	if (cpu_is_pxa25x())
> -		dri = ((freq * SDRAM_TREF) / (sdram_rows * 32));
> +	/* 
> +	 * PXA255 (6.5.3):
> +	 * 	DRI = (Refresh time / rows * memory clock frequency) / 32
> +	 * PXA270 (Table 91):
> +	 * 	DRI = (Refresh time / rows * memory clock frequency - 31) / 32
> +	 * 
> +	 * Memory clock frequency is in MHz here! (Refresh time is in ms).
> +	 */
I don't agree here either. The "freq" variable is in kHz. It comes from
"new_freq_mem = pxa_freq_settings[idx].membus;" in pxa_set_target(). The membus
value is in kHz, as in tables pxaXXX_freqs (see 104000 and 208000, second column
in pxa27x_freqs for example). As refresh time is in ms, there is no need for a
1000th multiplier.

And my understanding is that the legacy formula is incorrect, as you discovered
it. Yet it should be, IMO :
    if (cpu_is_pxa27x())
-       dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
+       dri = ((freq * SDRAM_TREF) / sdram_rows - 31) / 32;

This is the only change to apply IMHO.

Can you confirm my analysis ?

-- 
Robert
