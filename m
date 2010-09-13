From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 13 Sep 2010 09:34:44 +0530
Subject: [PATCH 03/74] ST SPEAr: Formalized timer support
In-Reply-To: <20100913033704.GB11822@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<eed779f7085ed5686aceb61b48a2c2a7d6af5953.1283161023.git.viresh.kumar@st.com>
	<20100906225536.GD8153@game.jcrosoft.org> <4C8D9909.4040705@st.com>
	<20100913033704.GB11822@game.jcrosoft.org>
Message-ID: <4C8DA2DC.8080502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean,

On 9/13/2010 9:07 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:52 Mon 13 Sep     , Shiraz Hashim wrote:
>> Dear Jean,
>>
>> On 9/7/2010 4:25 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>  
>>>> -#endif
>>>> +static void __init spear3xx_timer_init(void)
>>>> +{
>>>> +	spear_setup_timer();
>>> why not call it directly?
>>
>> A single level of abstraction was provided so that if archs (spear3xx/6xx/13xx)
>> required to do something extra.
>
> it does not seems to be needed at all so for now call it directly is enough
>

OK. So, I think what could be better is to set the parent clock of the gpt in
the arch specific function like spear3xx_timer_init. This would also remove this
part from the timer code.

>>>> +/* following defines the parent clock to be used */
>>>> +#ifdef CONFIG_ARCH_SPEAR13XX
>>>> +static char pclk_name[] = "osc1_24m_clk";
>>>> +#else
>>>> +static char pclk_name[] = "pll3_48m_clk";
>>>> +#endif
>>> why 2 name?
>>
>> spear13xx has different parent clock for gpt than spear3xx/6xx.
> so use a generic name which will be an alias specify on the soc clock
> so here no need to do the ifdef specially if you want to support both of them
> in the same kernel

As described above would move the parent clock selection to the respective timer
init function for archs. Would that be fine ?

>>
>>> it will be better to use clkdev and create an alias
>>
>> This is specifically to chose parent clock, which can be different in different
>> architectures. clkdev corresponding to parent clock is already defined. We use
>> name here to get the clock.
>>
>>> btw how about move the timer to drivers/clocksource?
>>
>> I don't know whether this is the right place. Every body else has placed timer
>> code in his respective mach/plat directory.
>>
>>>> +
>>>>  static void clockevent_set_mode(enum clock_event_mode mode,
>>>>  				struct clock_event_device *clk_event_dev);
>>>>  static int clockevent_next_event(unsigned long evt,
>>>> @@ -215,7 +222,8 @@ static void __init spear_clockevent_init(void)
>>>>  
>>>>  void __init spear_setup_timer(void)
>>>>  {
>>>> -	struct clk *pll3_clk;
>>>> +	struct clk *clk;
>>>> +	int ret;
>>>>  
>>>>  	if (!request_mem_region(SPEAR_GPT0_BASE, SZ_1K, "gpt0")) {
>>>>  		pr_err("%s:cannot get IO addr\n", __func__);
>>>> @@ -234,26 +242,32 @@ void __init spear_setup_timer(void)
>>>>  		goto err_iomap;
>>>>  	}
>>>>  
>>>> -	pll3_clk = clk_get(NULL, "pll3_48m_clk");
>>>> -	if (!pll3_clk) {
>>>> -		pr_err("%s:couldn't get PLL3 as parent for gpt\n", __func__);
>>>> +	/* get the parent clock */
>>>> +	clk = clk_get(NULL, pclk_name);
>>>> +
>>>> +	if (!clk) {
>>>> +		pr_err("%s:couldn't get %s as parent for gpt\n",
>>>> +				__func__, pclk_name);
>>>>  		goto err_iomap;
>>>>  	}
>>>>  
>>>> -	clk_set_parent(gpt_clk, pll3_clk);
>>>> +	clk_set_parent(gpt_clk, clk);
>>> ??
>>> why not do this in the clock file?

Better to be done in timer init function of respective archs like spear3xx_timer_init

>>
>> The functional clock of the timer very much depends on the parent clock it
>> selects. This is a part of the timer itself, hence it is kept here.
>
> it's seems to be more soc depends than timer
>

yes, OK, would above solution be fine.

regards
Shiraz
