From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Feb 2014 23:37:16 +0100
Subject: [PATCH 08/12] clk: samsung: add clock controller driver for
 s3c2410, s3c2440 and s3c2442
In-Reply-To: <5643318.r2EB20boll@phil>
References: <201312131356.40755.heiko@sntech.de>
 <201312131401.52029.heiko@sntech.de> <52F7D842.5060609@gmail.com>
 <5643318.r2EB20boll@phil>
Message-ID: <53028F1C.7090806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2014 22:05, Heiko St?bner wrote:
> Hi Tomasz,
>
> Am Sonntag, 9. Februar 2014, 20:34:26 schrieb Tomasz Figa:
>>> +/*
>>> + * fixed rate clocks generated outside the soc
>>> + * Only necessary until the devicetree-move is complete
>>> + */
>>> +struct samsung_fixed_rate_clock s3c2410_common_frate_clks[] __initdata =
>>> {
>>> +	FRATE(XTI, "xti", NULL, CLK_IS_ROOT, 0),
>>
>> Do you need to assign this clock an ID? When DT is used, it's defined as
>> a separate clock provider using fixed clock bindings, so it is not
>> provided by this driver.
>
> I think that I'll need this (and similar on the s3c2412). This is due to the
> cpufreq driver for the earlier SoCs needing the xtal-frequency to calculate
> the pll lock time (s3c24xx-cpufreq.c s3c_cpufreq_update_loctkime).
>
> Or do you have an idea on how to fix up the cpufreq driver in an easy way?

OK, I get the problem here. So you need the ID to register an alias.

Still, the ID would be invalid when booted with DT and xti clock 
registered using fixed rate clock bindings. So I'd suggest moving the 
XTI clock ID definition from your DT binding header back to your driver, 
leaving a comment in the header that this ID is reserved.

What do you think?

Best regards,
Tomasz
