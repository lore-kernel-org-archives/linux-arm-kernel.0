From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 6 Jun 2017 17:03:29 +0530
Subject: [PATCH] spi: pxa2xx: Handle return value of clk_prepare_enable
In-Reply-To: <CAHp75Vf+cm_-V4jcqJqcmMRdGA9j19RQYfyjJ8YRz3w1A+gRYQ@mail.gmail.com>
References: <4e16c0aba047b068aaa41c1d180d98ccb441afd0.1496668108.git.arvind.yadav.cs@gmail.com>
 <CAHp75Vf+cm_-V4jcqJqcmMRdGA9j19RQYfyjJ8YRz3w1A+gRYQ@mail.gmail.com>
Message-ID: <e4762e92-2142-56a5-c037-e88e4b5dece6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 06 June 2017 04:24 PM, Andy Shevchenko wrote:
> On Tue, Jun 6, 2017 at 12:44 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> clk_prepare_enable() can fail here and we must check its return value.
>> @@ -1676,7 +1676,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>> -       clk_prepare_enable(ssp->clk);
>> +       status = clk_prepare_enable(ssp->clk);
> This one looks fine.
>
>> @@ -1855,8 +1859,13 @@ static int pxa2xx_spi_resume(struct device *dev)
>>          /* Enable the SSP clock */
>> -       if (!pm_runtime_suspended(dev))
>> -               clk_prepare_enable(ssp->clk);
>> +       if (!pm_runtime_suspended(dev)) {
>> +               status = clk_prepare_enable(ssp->clk);
>> +               if (status) {
>> +                       dev_err(dev, "Failed to prepare clock\n");
>> +                       return status;
>> +               }
> This...
>
>> @@ -1886,8 +1895,7 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
>>   {
>>          struct driver_data *drv_data = dev_get_drvdata(dev);
>>
>> -       clk_prepare_enable(drv_data->ssp->clk);
>> -       return 0;
>> +       return clk_prepare_enable(drv_data->ssp->clk);
> ...and especially this should be carefully checked since there are
> differences in behaviour how system or driver will be resumed.
yes true, here clk_prepare_enable will return 0 on successful attempt.
what do you suggest here, we should not return like this.?
>
> So, the question is how did you test it?
It can fail, I am not able to produce clock failure issue. If you have 
any suggestion.
please let me know.
>
-arvind
