From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 10 Oct 2018 20:06:42 +0200
Subject: [PATCH] clk: mvebu: armada-37xx-tbg: Balance devm_clk_get in probe
In-Reply-To: <153919299293.119890.9655297515756412545@swboyd.mtv.corp.google.com>
 (Stephen Boyd's message of "Wed, 10 Oct 2018 10:36:32 -0700")
References: <20180914153421.7090-1-gregory.clement@bootlin.com>
 <153919299293.119890.9655297515756412545@swboyd.mtv.corp.google.com>
Message-ID: <87va69he19.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
 
 On mer., oct. 10 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-09-14 08:34:21)
>> The parent clock is get only to have its name, and then the clock is no
>> more used, so we can safely free it using devm_clk_put.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/clk/mvebu/armada-37xx-tbg.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
>> index 71f30149e80e..caaa91a41683 100644
>> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
>> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
>> @@ -102,6 +102,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>         parent_name = __clk_get_name(parent);
>> +       devm_clk_put(dev, parent);
>
> So then why use devm_clk_get()? Please replace both so tha
> devm_clk_put() doesn't need to be used..

Indeed between the successful devm_clk_get and the devm_clk_put we don't
exit the function in error so I can use clk_get and clk_put.

Gregory

>
>>  
>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>         reg = devm_ioremap_resource(dev, res);

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
