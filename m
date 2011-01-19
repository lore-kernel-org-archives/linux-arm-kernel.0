From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 09:23:15 +0530
Subject: [PATCH V4 05/62] ST SPEAr: Formalized timer support
In-Reply-To: <20110118235029.GA2209@gallagher>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<b14dc485b365aa736f07bf0f684198e66ef06e16.1295333958.git.viresh.kumar@st.com>
	<20110118235029.GA2209@gallagher>
Message-ID: <4D36602B.4040006@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Jamie,

Thanks for reviewing our patches.

On 01/19/2011 05:20 AM, Jamie Iles wrote:
> Hi,
> 
> On Tue, Jan 18, 2011 at 12:41:33PM +0530, Viresh Kumar wrote:
>> --- a/arch/arm/mach-spear3xx/spear3xx.c
>> +++ b/arch/arm/mach-spear3xx/spear3xx.c
>> @@ -523,5 +523,35 @@ struct pmx_dev pmx_plgpio_45_46_49_50 = {
>>  	.mode_count = ARRAY_SIZE(pmx_plgpio_45_46_49_50_modes),
>>  	.enb_on_reset = 1,
>>  };
>> +#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
>>  
>> -#endif
>> +static void __init spear3xx_timer_init(void)
>> +{
>> +	char pclk_name[] = "pll3_48m_clk";
>> +	struct clk *gpt_clk, *pclk;
>> +
>> +	/* get the system timer clock */
>> +	gpt_clk = clk_get_sys("gpt0", NULL);
>> +	if (!gpt_clk) {
>> +		pr_err("%s:couldn't get clk for gpt\n", __func__);
>> +		BUG();
>> +	}
>> +
>> +	/* get the suitable parent clock for timer*/
>> +	pclk = clk_get(NULL, pclk_name);
>> +	if (!pclk) {
>> +		pr_err("%s:couldn't get %s as parent for gpt\n",
>> +				__func__, pclk_name);
>> +		BUG();
>> +	}
> 
> These should probably be using IS_ERR() rather than checking against NULL to 
> be consistent with the API.
> 

Ok.

> [...]
>> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
>> index daff8d0..bdd5b76 100644
>> --- a/arch/arm/mach-spear6xx/spear600_evb.c
>> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
>> @@ -42,10 +42,11 @@ static void __init spear600_evb_init(void)
>>  		amba_device_register(amba_devs[i], &iomem_resource);
>>  }
>>  
>> +
> 
> Nitpick, why the extra newline?
> 

Will be removed.

>>  MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
>>  	.boot_params	=	0x00000100,
>>  	.map_io		=	spear6xx_map_io,
>>  	.init_irq	=	spear6xx_init_irq,
>> -	.timer		=	&spear_sys_timer,
>> +	.timer		=	&spear6xx_timer,
>>  	.init_machine	=	spear600_evb_init,
>>  MACHINE_END
>> diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
>> index f2fe14e..ea4c356 100644
>> --- a/arch/arm/mach-spear6xx/spear6xx.c
>> +++ b/arch/arm/mach-spear6xx/spear6xx.c
>> @@ -155,3 +155,34 @@ void __init spear6xx_map_io(void)
>>  	/* This will initialize clock framework */
>>  	clk_init();
>>  }
>> +
>> +static void __init spear6xx_timer_init(void)
>> +{
>> +	char pclk_name[] = "pll3_48m_clk";
>> +	struct clk *gpt_clk, *pclk;
>> +
>> +	/* get the system timer clock */
>> +	gpt_clk = clk_get_sys("gpt0", NULL);
>> +	if (!gpt_clk) {
>> +		pr_err("%s:couldn't get clk for gpt\n", __func__);
>> +		BUG();
>> +	}
>> +
>> +	/* get the suitable parent clock for timer*/
>> +	pclk = clk_get(NULL, pclk_name);
>> +	if (!pclk) {
>> +		pr_err("%s:couldn't get %s as parent for gpt\n",
>> +				__func__, pclk_name);
>> +		BUG();
>> +	}
> 
> As above, IS_ERR() would be better here.
> 

Ok.

-- 
viresh
