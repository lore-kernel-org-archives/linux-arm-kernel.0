From: vigneshr@ti.com (Vignesh R)
Date: Sun, 24 Sep 2017 18:38:23 +0530
Subject: [PATCH v3 5/5] mtd: spi-nor: cadence-quadspi: Add runtime PM
 support
In-Reply-To: <3a1160f9-a0ae-c84c-d209-af97c3c3b0f6@gmail.com>
References: <20170924105924.23923-1-vigneshr@ti.com>
 <20170924105924.23923-6-vigneshr@ti.com>
 <3a1160f9-a0ae-c84c-d209-af97c3c3b0f6@gmail.com>
Message-ID: <4ee69ea4-14cc-4305-bf3f-8fe76d43bf6b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/24/2017 5:31 PM, Marek Vasut wrote:
> On 09/24/2017 12:59 PM, Vignesh R wrote:
>> Add pm_runtime* calls to cadence-quadspi driver. This is required to
>> switch on QSPI power domain on TI 66AK2G SoC during probe.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Are you planning to add some more fine-grained PM control later?

Yes, I will need to add fine-grained PM control at some point. But, for
now SoC does not really support low power mode or runtime power saving
option.
The fact that driver still uses clk_prepare_*() calls to enable/disable
clocks instead of pm_*() calls makes it a bit tricky though.

Just figured out I forgot to add cleanup code in error handling path of
probe(). Will fix that and send a v4.

> 
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index d9629e8f4798..2c8e6226d267 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/sched.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/timer.h>
>> @@ -1224,6 +1225,13 @@ static int cqspi_probe(struct platform_device *pdev)
>>  		return -ENXIO;
>>  	}
>>  
>> +	pm_runtime_enable(&pdev->dev);
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(&pdev->dev);
>> +		return ret;
>> +	}
>> +
>>  	ret = clk_prepare_enable(cqspi->clk);
>>  	if (ret) {
>>  		dev_err(dev, "Cannot enable QSPI clock.\n");
>> @@ -1275,6 +1283,9 @@ static int cqspi_remove(struct platform_device *pdev)
>>  
>>  	clk_disable_unprepare(cqspi->clk);
>>  
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>>  	return 0;
>>  }
>>  
>>
> 
> 
