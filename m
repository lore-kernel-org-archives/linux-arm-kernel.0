From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Dec 2011 11:29:29 +0800
Subject: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <20111220200750.GA2577@n2100.arm.linux.org.uk>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
 <20111220200750.GA2577@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4y8vwrK=UD8a10gf2aN=O3hs_R_jYBKeFYf0v+gk0hiuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
>> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
>> +{
>> + ? ? struct clk *clk;
>> +
>> + ? ? clk = clk_get(&pdev->dev, NULL);
>> + ? ? err = clk_prepare(clk);
>> + ? ? err = clk_enable(clk);
> ...
>> + ? ? clk_disable(clk);
>> +
>> + ? ? dev_info(&pdev->dev, " I2C adapter ready to operate\n");
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
>> +{
>> + ? ? clk_disable(siic->clk);
>> + ? ? clk_unprepare(siic->clk);
>> + ? ? clk_put(siic->clk);
>
> This doesn't look right - look at the state which you leave the clk in
> upon successful probe, and now look at what you do when you do a remove.
>
> It seems that you disable an already disabled clock to me.

Russell, thanks! i will fix that in v5. but i have to wait for Ben's
feedback and add other fixes together before doing that.
Ben seems to have been scheduled out, i hope the state is
TASK_INTERRUPTBILE not TASK_UNINTERRUPTBILE. Then my signal can wake
up him.

Thanks
barry
