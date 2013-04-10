From: michal.bachraty@streamunlimited.com (Michal Bachraty)
Date: Wed, 10 Apr 2013 16:48:25 +0200
Subject: [PATCH v7] clk: add si5351 i2c common clock driver
In-Reply-To: <51653C3E.2020702@gmail.com>
References: <1365439617-18816-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365586810-6752-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51653C3E.2020702@gmail.com>
Message-ID: <14854575.YAd2OMKOy9@ganymedes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,
This driver doesn't work for me. In my case, u-boot initializes si-5351 and 
power down unused clocks while booting kernel.  there is need for power up 
clocks as was in previous versions of your driver.  
See patch, whre the problem is fixed:

@@ -992,6 +992,10 @@ static long si5351_clkout_round_rate(struct clk_hw *hw, 
unsigned long rate,
 		} while (1);
 	}
 	rate = *parent_rate >> rdiv;
+	
+	/* powerup clkout */
+	si5351_set_bits(hwdata->drvdata, SI5351_CLK0_CTRL + hwdata->num,
+			SI5351_CLK_POWERDOWN, 0);
 
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: rdiv = %u, parent_rate = %lu, rate = %lu\n",

With this lines, driver works well.

Also, 

> > +==Example==
> > +
> > +/* 25MHz reference crystal */
> > +ref25: ref25M {
> > +	compatible = "fixed-clock";
> > +	#clock-cells = <0>;
> > +	clock-frequency = <25000000>;
> > +};
> > +
> > +i2c-master-node {
> > +
> > +	/* Si5351a msop10 i2c clock generator */
> > +	si5351a: clock-generator at 60 {
> > +		compatible = "silabs,si5351a-msop";
> > +		reg = <0x60>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		#clock-cells = <1>;
> > +
> > +		/* connect xtal input to 25MHz reference */
> > +		clocks = <&ref25>;
> > +
> > +		/* connect xtal input as source of pll0 and pll1 */
> > +		silabs,pll-source = <0 0>, <1 0>;
> > +
> > +		/*
> > +		 * overwrite clkout0 configuration with:
> > +		 * - 8mA output drive strength
> > +		 * - pll0 as clock source of multisynth0
> > +		 * - multisynth0 as clock source of output divider
> > +		 * - multisynth0 can change pll0
> > +		 * - set initial clock frequency of 74.25MHz
> > +		 */
> > +		clkout0 {
> > +			reg = <0>;
> > +			silabs,drive-strength = <8>;
> > +			silabs,multisynth-source = <0>;
> > +			silabs,clock-source = <0>;
> > +			silabs,pll-master;
> > +			clock-frequency = <74250000>;
> > +		};
> > +
> > +		/*
> > +		 * overwrite clkout1 configuration with:
> > +		 * - 4mA output drive strength
> > +		 * - pll1 as clock source of multisynth1
> > +		 * - multisynth1 as clock source of output divider
> > +		 * - multisynth1 can change pll1
> > +		 */
> > +		clkout1 {
> > +			reg = <1>;
> > +			silabs,drive-strength = <4>;
> > +			silabs,multisynth-source = <1>;
> > +			silabs,clock-source = <0>;
> > +			pll-master;
> > +		};
> > +
 Is definition of pll-master in clkout1 correct? should not be silabs,pll-
master ?

Best regards,
Michal
