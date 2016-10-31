From: david@lechnology.com (David Lechner)
Date: Mon, 31 Oct 2016 09:48:26 -0500
Subject: [PATCH] ARM: davinci: da850: Fix pwm name matching
In-Reply-To: <b4f6970b-5723-d1ed-088e-3c07129a005f@ti.com>
References: <1477418044-24603-1-git-send-email-david@lechnology.com>
 <b4f6970b-5723-d1ed-088e-3c07129a005f@ti.com>
Message-ID: <3fd93d1b-8ba2-5440-e37d-0c55928e7e51@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 05:18 AM, Sekhar Nori wrote:
> On Tuesday 25 October 2016 11:24 PM, David Lechner wrote:
>> This fixes pwm name matching for DA850 familiy devices. When using device
>> tree, the da850_auxdata_lookup[] table caused pwm devices to have the exact
>> same name, which caused errors when trying to register the devices.
>>
>> The names for clock matching in da850_clks[] also have to be updated to
>> to exactly match in order for the clock lookup to work correctly.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> Tested working on LEGO MINDSTORMS EV3.
>>
>>
>>  arch/arm/mach-davinci/da850.c    | 10 +++++++---
>>  arch/arm/mach-davinci/da8xx-dt.c | 10 +++++-----
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index ed3d0e9..6b78a8f 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -510,9 +510,13 @@ static struct clk_lookup da850_clks[] = {
>>  	CLK("vpif",		NULL,		&vpif_clk),
>>  	CLK("ahci_da850",		NULL,		&sata_clk),
>>  	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
>> -	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
>> -	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
>> -	CLK("ecap",		"fck",		&ecap_clk),
>> +	CLK("ehrpwm.0",		"fck",		&ehrpwm_clk),
>> +	CLK("ehrpwm.0",		"tbclk",	&ehrpwm_tbclk),
>> +	CLK("ehrpwm.1",		"fck",		&ehrpwm_clk),
>> +	CLK("ehrpwm.1",		"tbclk",	&ehrpwm_tbclk),
>> +	CLK("ecap.0",		"fck",		&ecap_clk),
>> +	CLK("ecap.1",		"fck",		&ecap_clk),
>> +	CLK("ecap.2",		"fck",		&ecap_clk),
>
> This has exposed a limitation of DaVinci clock framework. The struct clk
> are stored as a linked list themselves. So a node repeating in the table
> above will create a loop in the linked list. This is easily seen on the
> LCDK board. davinci_clk_disable_unused() never returns. PWMs are unused
> on that board.
>
> There is no "simple" solution to this AFAICS. One solution is to
> separate the iterator from the clock hardware structure and use struct
> clk_hw available in struct clk_lookup.
>
> Or move DaVinci to common clock framework. This is of course preferred
> but much more involved as all 6 supported SoCs have to be moved together.
>
> Thanks,
> Sekhar
>
>

The simple solution for now could be to make child clocks for each of 
these that simply enable the parent clock. e.g. ehrpwm0_clk and 
ehpwm1_clk are children of ehrpwm_clk, etc.

Looking at da830.c, it looks like the solution was to make multiple 
clocks that use the same LPSC, but this does not seem right to me.
