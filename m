From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 22 Feb 2012 21:16:31 +0800
Subject: [PATCH 6/7] rtc: sa1100: enable clk support
In-Reply-To: <201202221229.17934.arnd@arndb.de>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-7-git-send-email-haojian.zhuang@marvell.com>
 <201202221229.17934.arnd@arndb.de>
Message-ID: <CAN1soZyF7jWBctb-8=kzeMq0chXyyDCO4xKY5UMJy9XFoBnm6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 8:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 February 2012, Haojian Zhuang wrote:
>> @@ -306,6 +308,13 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>> ? ? ? ? if (!info)
>> ? ? ? ? ? ? ? ? return -ENOMEM;
>>
>> + ? ? ? info->clk = clk_get(&pdev->dev, NULL);
>> + ? ? ? if (IS_ERR(info->clk)) {
>> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to find rtc clock source\n");
>> + ? ? ? ? ? ? ? ret = PTR_ERR(info->clk);
>> + ? ? ? ? ? ? ? goto err_clk;
>> + ? ? ? }
>> + ? ? ? clk_prepare_enable(info->clk);
>> ? ? ? ? info->iobase = res->start;
>> ? ? ? ? info->iosize = resource_size(res);
>> ? ? ? ? info->irq_1hz = irq_1hz;
>> @@ -379,6 +388,9 @@ err_dev:
>> ? ? ? ? iounmap(info->reg_base);
>> ?err_map:
>> ? ? ? ? platform_set_drvdata(pdev, NULL);
>> + ? ? ? clk_disable_unprepare(info->clk);
>> + ? ? ? clk_put(info->clk);
>> +err_clk:
>> ? ? ? ? kfree(info);
>> ? ? ? ? return ret;
>
> I wonder whether it would be easier to just make the clk handling
> conditional here, like
>
> ? ? ? ?info->clk = clk_get(&pdev->dev, NULL);
> ? ? ? ?if (PTR_ERR(info->clk) == -ENOENT)
> ? ? ? ? ? ? ? ?info->clk = NULL;
> ? ? ? ?if (IS_ERR(info->clk)) {
> ? ? ? ? ? ? ? ?ret = ?PTR_ERR(info->clk);
> ? ? ? ? ? ? ? ?goto err_clk;
> ? ? ? ?}
>
> ? ? ? ?if (info->clk)
> ? ? ? ? ? ? ? ?clk_prepare_enable(info->clk);
> ? ? ? ?...
> ? ? ? ?if (info->clk) {
> ? ? ? ? ? ? ? ?clk_disable_unprepare(info->clk);
> ? ? ? ? ? ? ? ?clk_put(info->clk);
> ? ? ? ?}
>
> With this, you would no longer need to add dummy clocks in platforms
> that really have no clock handling.
>
> ? ? ? ?Arnd

It sounds good. I'll update it.

Thanks
Haojian
