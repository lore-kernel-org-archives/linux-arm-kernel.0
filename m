From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 2 Mar 2018 10:07:52 +0000
Subject: [PATCH] pinctrl: sunxi: always look for apb block
In-Reply-To: <20180301114855.s7rbk7wiealepqrf@flea>
References: <20180301113701.8888-1-andre.przywara@arm.com>
 <20180301114855.s7rbk7wiealepqrf@flea>
Message-ID: <3c781379-0b67-85ed-fbe5-6aa5df585897@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01/03/18 11:48, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Mar 01, 2018 at 11:37:01AM +0000, Andre Przywara wrote:
>> The Allwinner pinctrl device tree binding suggests that a clock named
>> "apb" would drive the pin controller IP. However (for legacy reasons) we
>> rely on this clock actually being the first clock defined.
>> Since named clocks can be in any order, let's explicitly check for a
>> clock called "apb" first, then revert to using the first (and only!)
>> clock to keep compatibility with older DTs.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index 4b6cb25bc796..897ba13e6a03 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1360,10 +1360,21 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>>  			goto gpiochip_error;
>>  	}
>>  
>> -	clk = devm_clk_get(&pdev->dev, NULL);
>> +	clk = devm_clk_get(&pdev->dev, "apb");
>>  	if (IS_ERR(clk)) {
>> -		ret = PTR_ERR(clk);
>> -		goto gpiochip_error;
>> +		/*
>> +		 * If no "apb" clock can be found, try the first one, which
>> +		 * must be the only one defined.
>> +		 */
>> +		if (PTR_ERR(clk) == -ENOENT &&
>> +		    of_count_phandle_with_args(node, "clocks",
>> +					       "#clock-cells") == 1)
>> +			clk = devm_clk_get(&pdev->dev, NULL);
>> +
>> +		if (IS_ERR(clk)) {
>> +			ret = PTR_ERR(clk);
>> +			goto gpiochip_error;
>> +		}
> 
> I guess this can be made slightly less convoluted using something like

                           ^^^^^^^^ that's a slight understatement

> 
> ret = of_count_phandle_with_args(node, "clocks", "#clock-cells");
> clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");

Pah, that's just embarrassing.
I guess I will need to back your Kickstarter now to buy me out of this.

Will send v2 after testing tonight.

Thanks a lot for having a look!

Cheers,
Andre.
