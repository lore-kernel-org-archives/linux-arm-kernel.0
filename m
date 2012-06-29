From: b32955@freescale.com (Huang Shijie)
Date: Fri, 29 Jun 2012 13:52:40 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629020650.GB28932@S2101-09.ap.freescale.net>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
Message-ID: <4FED42A8.40301@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?06?29? 10:06, Shawn Guo ??:
>>   		gpmi_regs + HW_GPMI_TIMING1);
>> >  
>> >    	/* Get the timing information we need. */
>> >  -	nfc->clock_frequency_in_hz = clk_get_rate(r->clock);
>> >  +	nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
>> >    	clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
>> >  
>> >    	gpmi_nfc_compute_hardware_timing(this,&hw);
>> >  @@ -784,8 +812,7 @@ err_out:
>> >  
>> >    void gpmi_end(struct gpmi_nand_data *this)
>> >    {
>> >  -	struct resources *r =&this->resources;
>> >  -	clk_disable_unprepare(r->clock);
>> >  +	gpmi_disable_clk(this);
>> >    }
>> >  
>> >    /* Clears a BCH interrupt. */
>> >  diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> >  index 941cfb7..edda3b1 100644
>> >  --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> >  +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> >  @@ -464,9 +464,59 @@ acquire_err:
>> >    	return -EINVAL;
>> >    }
>> >  
>> >  +static void gpmi_put_clks(struct gpmi_nand_data *this)
>> >  +{
>> >  +	struct resources *r =&this->resources;
>> >  +	struct clk *clk;
>> >  +	int i;
>> >  +
>> >  +	for (i = 0; i<  GPMI_CLK_MAX; i++) {
>> >  +		clk = r->clock[i];
>> >  +		if (clk) {
>> >  +			clk_put(clk);
>> >  +			r->clock[i] = NULL;
>> >  +		}
>> >  +	}
>> >  +}
>> >  +
>> >  +static char *extra_clks_for_mx6q[] = {
>> >  +	"gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
>> >  +};
>> >  +
>> >  +static int __devinit gpmi_get_clks(struct gpmi_nand_data *this)
>> >  +{
>> >  +	struct resources *r =&this->resources;
>> >  +	char **extra_clks = NULL;
>> >  +	struct clk *clk;
>> >  +	int i;
>> >  +
>> >  +	r->clock[0] = clk_get(&this->pdev->dev, NULL);
>> >  +	if (IS_ERR(r->clock[0]))
>> >  +		goto err_clock;
>> >  +
>> >  +	/* Get extra clocks */
>> >  +	if (GPMI_IS_MX6Q(this))
>> >  +		extra_clks = extra_clks_for_mx6q;
> We probably do not need this tweaking.  We can have the driver always
> take all those 5 clocks, and I think the current imx28 clock driver
> can just work with it, because the gpmi-nand clkdev lookup has NULL
> con_id and all those 5 clocks can match the same one on imx28.
>
I think your method makes the code hard to understand.
My code is more clear in logic.

thanks
Huang Shijie
