From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 13:00:05 -0700
Subject: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
In-Reply-To: <20180726192651.GK10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
 <20180726192651.GK10686@lunn.ch>
Message-ID: <609726a2-e5ec-fe1d-4ee6-39db3d71b1f2@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

On 18-07-26 12:26 PM, Andrew Lunn wrote:
>> +static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
>> +{
>> +	u32 val;
>> +	u32 divisor;
>> +
>> +	if (md->core_clk) {
>> +		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
> 
> /**
>  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>  * 		  This is only valid once the clock source has been enabled.
>  * @clk: clock source
>  */
> unsigned long clk_get_rate(struct clk *clk);
> 
> It is generally good practice to call clk_prepare_enable() sometime
> before clk_get_rate() to ensure the clock is ticking, and to show this
> driver is making use of the clock, so it does not get turned off.

Will add 'clk_prepare_enable()' to the probe.

Thanks
Arun

> 
>> +		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
>> +		val = divisor;
>> +		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
>> +		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
>> +		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
>> +	}
>> +}
