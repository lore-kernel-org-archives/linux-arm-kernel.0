From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 18 Jun 2010 12:30:42 +0900
Subject: [PATCH] S5PV210 Correct clock register properties
In-Reply-To: <000f01cb0e8e$64d44950$2e7cdbf0$%kim@samsung.com>
References: <1276763596-6175-1-git-send-email-myungjoo.ham@samsung.com>
	<000f01cb0e8e$64d44950$2e7cdbf0$%kim@samsung.com>
Message-ID: <4C1AE862.8000407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/2010 11:31 AM, Kukjin Kim wrote:
> MyungJoo Ham wrote:
>> From: MyungJoo Ham <myungJoo.ham@samsung.com>
>>
> I think you're author of this patch, so no need above 'From'.
> Maybe from wrong e-mail which should be 'myungjoo.ham...'
> 
> Please ensure that your setting of '.gitconfig' is right before submitting.
> 
>> Corrected shift values of I2S and UART clocks (CLK_GATE_IP3).
>>
>> I2S (CLK_GATE_IP3) and UART (CLK_GATE_IP3) had wrong register shift
>> values, which in turn, made them turn on and off wrong clocks.
> 
> Yes..should be fixed.
> 
>> Please note that each clock definition should access different control
>> register; otherwise, the system may suffer lockups. For example, if we
>> have two clock definitions "a" and "b" which access the same register
>> (and the shift value). Then, when we do:
>>
>> 	module B
>> 	1 clk = clk_get("b");
>> 	2 clk->clk_enable(clk);
>> 	3 do something with clk.
>> 	4 clk->clk_disable(clk);
>>
>> 	module A
>> 	1 clk = clk_get("a");
>> 	2 clk->clk_enable(clk);
>> 	3 do something with clk
>> 	4 clk->clk_disable(clk);
>>
>> 	And if the execution order is
>>
>> 	B1->B2->A1->A2->A3->A4->B3 ...
>>
>> 	Then, the system may hang at the point B3.
>>
>>
>> Therefore, there should be no clock definitions with the same contol
>> register/shift. If we need to create "aliases", then, creating child
>> clocks sharing the clock should be fine.
> 
> Yeah, but actually just should be fixed wrong bit.
> 
>> However, we did not mitigate this doppelganger clock problem for "struct
>> clksrc_clk" vs "struct clk"; look at "hsmmc" vs "mmc_bus". In the next
>> patch, we plan to let "struct clksrc_clk" access "CLK_SRC_MASK0" and
>> "CLK_SRC_MASK1"; i.e., clock source enable/disable should mask the clock
>> source itself, not the clock that is supplied by the clock source.
> 
> No need above message in here.
> 
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> ---
>>  arch/arm/mach-s5pv210/clock.c |   12 ++++++------
>>  1 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index 154bca4..ec5ad8c 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>> @@ -406,13 +406,13 @@ static struct clk init_clocks_disable[] = {
>>  		.id		= 0,
>>  		.parent		= &clk_p,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<4),
>> +		.ctrlbit	= (1<<5),
>>  	}, {
>>  		.name		= "i2s_v32",
>>  		.id		= 1,
>>  		.parent		= &clk_p,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<4),
>> +		.ctrlbit	= (1<<6),
> 
> Your point is right..but your updated code was wrong :-(
> 

?

> Should be like below.
> 

It's same code.

> @@ -400,19 +400,19 @@ static struct clk init_clocks_disable[] = {
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pv210_clk_ip3_ctrl,
> -		.ctrlbit	= (1<<4),
> +		.ctrlbit	= (1 << 4),
>  	}, {
>  		.name		= "i2s_v32",
>  		.id		= 0,
>  		.parent		= &clk_p,
>  		.enable		= s5pv210_clk_ip3_ctrl,
> -		.ctrlbit	= (1<<4),
> +		.ctrlbit	= (1 << 5),
>  	}, {
>  		.name		= "i2s_v32",
>  		.id		= 1,
>  		.parent		= &clk_p,
>  		.enable		= s5pv210_clk_ip3_ctrl,
> -		.ctrlbit	= (1<<4),
> +		.ctrlbit	= (1 << 6),
> 
>>  	}
>>  };
>>
>> @@ -429,25 +429,25 @@ static struct clk init_clocks[] = {
>>  		.id		= 0,
>>  		.parent		= &clk_pclk_psys.clk,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<7),
>> +		.ctrlbit	= (1<<17),
>>  	}, {
>>  		.name		= "uart",
>>  		.id		= 1,
>>  		.parent		= &clk_pclk_psys.clk,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<8),
>> +		.ctrlbit	= (1<<18),
>>  	}, {
>>  		.name		= "uart",
>>  		.id		= 2,
>>  		.parent		= &clk_pclk_psys.clk,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<9),
>> +		.ctrlbit	= (1<<19),
>>  	}, {
>>  		.name		= "uart",
>>  		.id		= 3,
>>  		.parent		= &clk_pclk_psys.clk,
>>  		.enable		= s5pv210_clk_ip3_ctrl,
>> -		.ctrlbit	= (1<<10),
>> +		.ctrlbit	= (1<<20),
> 
> How about adding blank on both of '<<' like (1 << x) for easily reading?
> 
>>  	},
>>  };
>>
>> --
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
