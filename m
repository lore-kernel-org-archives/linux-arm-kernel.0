From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Fri, 16 Mar 2018 21:52:07 +0100
Subject: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
In-Reply-To: <20180316.152712.1584177628223195375.davem@davemloft.net>
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
 <20180316.152712.1584177628223195375.davem@davemloft.net>
Message-ID: <4593afd4-8578-d724-4eae-dcaaa609120c@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/03/2018 ? 20:27, David Miller a ?crit?:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Wed, 14 Mar 2018 22:09:34 +0100
>
>> diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
>> index 16f9bee992fe..8ee9dfd0e363 100644
>> --- a/drivers/net/ethernet/arc/emac_rockchip.c
>> +++ b/drivers/net/ethernet/arc/emac_rockchip.c
>> @@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
>>   	/* Optional regulator for PHY */
>>   	priv->regulator = devm_regulator_get_optional(dev, "phy");
>>   	if (IS_ERR(priv->regulator)) {
>> -		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
>> -			return -EPROBE_DEFER;
>> +		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
>> +			ret = -EPROBE_DEFER;
>> +			goto out_clk_disable;
>> +		}
> Please build test your changes.
>
> There is no 'ret' variable in this function, perhaps you meant 'err'.
>
Yes, obviously, this is 'err'.

I apologize. I usually build-test all my patches before submission.
This one seems to have gone out of my normal process.

Can you fix it yourself or do you want me to re-submit?

CJ
