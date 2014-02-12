From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Wed, 12 Feb 2014 09:44:49 +0000
Subject: [PATCH 2/2] ARM: imx: add speed grading check for i.mx6 soc
In-Reply-To: <20140212093926.GB24834@S2101-09.ap.freescale.net>
References: <1392191777-15703-1-git-send-email-b20788@freescale.com>
 <1392191777-15703-2-git-send-email-b20788@freescale.com>
 <20140212093926.GB24834@S2101-09.ap.freescale.net>
Message-ID: <1660e5d9d8eb44cfbc29d504604db12d@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right, will improve it in V2, thanks.

Best Regards.
Anson Huang
?
Freescale Semiconductor Shanghai
Tel:021-28937058

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Wednesday, February 12, 2014 5:39 PM
>To: Huang Yongcai-B20788
>Cc: kernel at pengutronix.de; devicetree at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH 2/2] ARM: imx: add speed grading check for i.mx6 soc
>
>On Wed, Feb 12, 2014 at 03:56:17PM +0800, Anson Huang wrote:
>> The fuse map of speed_grading[1:0] defines the max speed of ARM, see
>> below the definition:
>>
>> 2b'11: 1200000000Hz;
>> 2b'10: 996000000Hz;
>> 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
>> 2b'00: 792000000Hz;
>>
>> Need to remove all illegal setpoints according to fuse map.
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>>  arch/arm/mach-imx/mach-imx6q.c |   22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx6q.c
>> b/arch/arm/mach-imx/mach-imx6q.c index f9cbbf9..ad9da1f 100644
>> --- a/arch/arm/mach-imx/mach-imx6q.c
>> +++ b/arch/arm/mach-imx/mach-imx6q.c
>> @@ -219,8 +219,10 @@ static void __init imx6q_init_machine(void)
>>  #define OCOTP_CFG3			0x440
>>  #define OCOTP_CFG3_SPEED_SHIFT		16
>>  #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
>> +#define OCOTP_CFG3_SPEED_996MHZ		0x2
>> +#define OCOTP_CFG3_SPEED_852MHZ		0x1
>>
>> -static void __init imx6q_opp_check_1p2ghz(struct device *cpu_dev)
>> +static void __init imx6q_opp_check_speed_grading(struct device
>> +*cpu_dev)
>>  {
>>  	struct device_node *np;
>>  	void __iomem *base;
>> @@ -238,11 +240,27 @@ static void __init imx6q_opp_check_1p2ghz(struct
>device *cpu_dev)
>>  		goto put_node;
>>  	}
>>
>> +	/*
>> +	 * SPEED_GRADING[1:0] defines the max speed of ARM:
>> +	 * 2b'11: 1200000000Hz;
>> +	 * 2b'10: 996000000Hz;
>> +	 * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
>> +	 * 2b'00: 792000000Hz;
>> +	 * We need to set the max speed of ARM according to fuse map.
>> +	 */
>>  	val = readl_relaxed(base + OCOTP_CFG3);
>>  	val >>= OCOTP_CFG3_SPEED_SHIFT;
>
>	val &= 0x3;
>
>Then you do not need to do it in every if-clause below.
>
>>  	if ((val & 0x3) != OCOTP_CFG3_SPEED_1P2GHZ)
>>  		if (dev_pm_opp_disable(cpu_dev, 1200000000))
>>  			pr_warn("failed to disable 1.2 GHz OPP\n");
>> +	if ((val & 0x3) < OCOTP_CFG3_SPEED_996MHZ)
>> +		if (dev_pm_opp_disable(cpu_dev, 996000000))
>> +			pr_warn("failed to disable 996 MHz OPP\n");
>> +	if (cpu_is_imx6q()) {
>> +		if ((val & 0x3) != OCOTP_CFG3_SPEED_852MHZ)
>
>	if (cpu_is_imx6q() && val != OCOTP_CFG3_SPEED_852MHZ)
>
>Shawn
>
>> +			if (dev_pm_opp_disable(cpu_dev, 852000000))
>> +				pr_warn("failed to disable 852 MHz OPP\n");
>> +	}
>>
>>  put_node:
>>  	of_node_put(np);
>> @@ -268,7 +286,7 @@ static void __init imx6q_opp_init(void)
>>  		goto put_node;
>>  	}
>>
>> -	imx6q_opp_check_1p2ghz(cpu_dev);
>> +	imx6q_opp_check_speed_grading(cpu_dev);
>>
>>  put_node:
>>  	of_node_put(np);
>> --
>> 1.7.9.5
>>
>>
