From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Jan 2013 16:46:21 +0100
Subject: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all
 revisions
In-Reply-To: <50E6F0CA.60309@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
 <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
 <50E6F0CA.60309@ti.com>
Message-ID: <50E6F94D.7090706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 04:10 PM, Jon Hunter wrote:
> 
> On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
>> To avoid issues with audio caused by non locked ABE DPLL we should
>> make sure it is locked in all OMAP4 revisions.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> asda d
> 
> Not sure what the above is ;-)

Argh, squashed patches without commit message cleanup...
Paul: can you fix this up, or should I resend?

> 
>> ---
>>  arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
>> index 5789a5e..a2cc046 100644
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>> @@ -2026,14 +2026,13 @@ int __init omap4xxx_clk_init(void)
>>  	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>>  	 * state when turning the ABE clock domain. Workaround this by
>>  	 * locking the ABE DPLL on boot.
>> +	 * Lock the ABE DPLL in any case to avoid issues with audio.
>>  	 */
>> -	if (cpu_is_omap446x()) {
>> -		rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
>> -		if (!rc)
>> -			rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
>> -		if (rc)
>> -			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> -	}
>> +	rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
>> +	if (!rc)
>> +		rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
>> +	if (rc)
>> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>>  
>>  	return 0;
>>  }
> 
> Acked-by: Jon Hunter <jon-hunter@ti.com>
> 
> Cheers
> Jon
> 


-- 
P?ter
