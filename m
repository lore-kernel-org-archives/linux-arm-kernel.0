From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 21 Jan 2014 10:52:59 +0000
Subject: [PATCH] ARM: imx: correct usecount of IPG, ARM and MMDC clk on
 i.mx6sl
In-Reply-To: <1390298702.8981.2.camel@weser.hi.pengutronix.de>
References: <1390214690-13564-1-git-send-email-b20788@freescale.com>
 <1390298702.8981.2.camel@weser.hi.pengutronix.de>
Message-ID: <3b67180e26b64b678c0dbc0f2e09b4be@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Lucas
	Thanks for the comment, already improved the comment in V2 patch.

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Lucas Stach [mailto:l.stach at pengutronix.de]
>Sent: Tuesday, January 21, 2014 6:05 PM
>To: Huang Yongcai-B20788
>Cc: shawn.guo at linaro.org; kernel at pengutronix.de; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH] ARM: imx: correct usecount of IPG, ARM and MMDC clk on
>i.mx6sl
>
>Am Montag, den 20.01.2014, 18:44 +0800 schrieb Anson Huang:
>> IPG, ARM and MMDC's clock should be enabled during kernel boot up, so
>> we need to maintain their use count, otherwise, they may be disabled
>> unexpectedly if their children's clock are turned off, which is not
>> allowed.
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>>  arch/arm/mach-imx/clk-imx6sl.c |   15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx6sl.c
>> b/arch/arm/mach-imx/clk-imx6sl.c index 78f3bd6..8d720f9 100644
>> --- a/arch/arm/mach-imx/clk-imx6sl.c
>> +++ b/arch/arm/mach-imx/clk-imx6sl.c
>> @@ -291,6 +291,21 @@ static void __init imx6sl_clocks_init(struct
>device_node *ccm_node)
>>  		pr_warn("%s: failed to set AHB clock rate %d!\n",
>>  			__func__, ret);
>>
>> +	/* Correct usecount of IPG clk */
>
>You don't really correct anything here, so this comment is misleading.
>If those are always on clocks, like you suggest in the commit message, please
>put this in the comment instead.
>
>Regards,
>Lucas
>
>> +	ret = clk_prepare_enable(clks[IMX6SL_CLK_IPG]);
>> +	if (ret)
>> +		pr_warn("%s: failed to enable IPG clock %d\n", __func__, ret);
>> +
>> +	/* Correct usecount of ARM clk */
>> +	ret = clk_prepare_enable(clks[IMX6SL_CLK_ARM]);
>> +	if (ret)
>> +		pr_warn("%s: failed to enable ARM clock %d\n", __func__, ret);
>> +
>> +	/* Correct usecount of MMDC clk */
>> +	ret = clk_prepare_enable(clks[IMX6SL_CLK_MMDC_ROOT]);
>> +	if (ret)
>> +		pr_warn("%s: failed to enable MMDC clock %d\n", __func__, ret);
>> +
>>  	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
>>  		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
>>  		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
>
>--
>Pengutronix e.K.                           | Lucas Stach                 |
>Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
>
