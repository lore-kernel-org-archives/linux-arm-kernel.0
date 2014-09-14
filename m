From: xjq@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 10:27:43 +0800
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
In-Reply-To: <20140913163749.GK7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
 <20140913163749.GK7960@sirena.org.uk>
Message-ID: <5414FD1F.6020603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 09/14/2014 12:37 AM, Mark Brown ??:
> On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
> 
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> @@ -423,6 +423,11 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>>  		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
>>  		return PTR_ERR(i2s->hclk);
>>  	}
>> +	ret = clk_prepare_enable(i2s->hclk);
>> +	if (ret) {
>> +		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
>> +		return ret;
>> +	}
> 
> BTW: you're also missing a clk_disable_unprepare() in the remove path
> here, please send a followup fixing that.
remove function has done the clk_disable_unprepare for "hclk".

One more thing, since "i2s_clk" is enabled at runtime_resume, and is disabled in runtime_suspend,
hasn't enable in probe, so do the "i2s_clk" to be disabled in remove ?
The current driver has disable in remove.
> 
