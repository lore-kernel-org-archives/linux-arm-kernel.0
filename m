From: trimarchi@gandalf.sssup.it (Michael Trimarchi)
Date: Thu, 02 Dec 2010 13:41:31 +0100
Subject: [RFC PATCH] mxc_timer1 patch on imx25
In-Reply-To: <20101202113219.GI6088@tarshish>
References: <20101117212821.GF8942@pengutronix.de>	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>	<4CEFCC9A.2020500@fqingenieria.es>	<4CEFD139.8090600@gandalf.sssup.it>	<20101126200746.GB25293@pengutronix.de>	<4CF38BE9.1030607@gandalf.sssup.it>	<20101129113846.GD20449@pengutronix.de>	<4CF77C35.5060208@gandalf.sssup.it>
	<20101202113219.GI6088@tarshish>
Message-ID: <4CF793FB.9010903@gandalf.sssup.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 12/02/2010 12:32 PM, Baruch Siach wrote:
> Hi Michael,
>
> On Thu, Dec 02, 2010 at 12:00:05PM +0100, Michael Trimarchi wrote:
>> sleep 1 was around 2 seconds
>> and so on
>>
>> Michael
>>
>> GPT clock source select can be selected from:
>>
>> 000 No clock
>> 001 ipg_clk
>> 010 ipg_clk_highfreq
>> 011 ipp_ind_clkin (external clock from pad)
>> 1xx ipg_clk_32k
>>
>> The clock is gated by ipg_clk so the reference value must be computed
>> using the get_rate_ipg.
> See the discussion at
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/72944.
>
After this discussion is there a proper fix?
If the get_rate_ipg is taken from the par you need to set it
in plat-mxc timer code. If you want to use the ipg clock for gpg yuu need
to take the rate from the ipg_clk. Both works on my board:

- 001 ipg_clk get_rate_ipg
- 010 ipg_clk_high_freq get_rate_par(5)

Michael Trimarchi
> baruch
>
>> Signed-off-by: Michael Trimarchi<trimarchi@gandalf.sssup.it>
>>
>> diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
>> index 9e4a557..0af06d4 100644
>> --- a/arch/arm/mach-mx25/clock.c
>> +++ b/arch/arm/mach-mx25/clock.c
>> @@ -131,7 +131,7 @@ static unsigned long get_rate_nfc(struct clk *clk)
>>
>>   static unsigned long get_rate_gpt(struct clk *clk)
>>   {
>> -	return get_rate_per(5);
>> +	return get_rate_ipg(NULL);
>>   }
>>
>>   static unsigned long get_rate_lcdc(struct clk *clk)
