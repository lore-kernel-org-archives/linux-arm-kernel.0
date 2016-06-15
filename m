From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 15 Jun 2016 15:07:02 +0300
Subject: [PATCH 02/10] i2c: designware-platdrv: Gate clk in error path in
 ->probe()
In-Reply-To: <CAPDyKFpqR5a+b68wMmyY086OCmkiK9mvC-kcav8Q2x28z=0ONA@mail.gmail.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org>
 <1465917768.30123.65.camel@linux.intel.com>
 <CAPDyKFpqR5a+b68wMmyY086OCmkiK9mvC-kcav8Q2x28z=0ONA@mail.gmail.com>
Message-ID: <0b2b63b3-6c66-fba2-028d-ab366b9df1af@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 10:16 AM, Ulf Hansson wrote:
> On 14 June 2016 at 17:22, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>>> The call to i2c_dw_probe() may fail in ->probe() in which case the
>>> clock
>>> remains ungated. Fix the error path by gating the clock before the
>>> error
>>> code is returned.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index e39962b..19174e7 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -235,6 +235,7 @@ static int dw_i2c_plat_probe(struct
>>> platform_device *pdev)
>>>       ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>>>       adap->dev.of_node = pdev->dev.of_node;
>>>
>>
>>
>>> +     pm_runtime_get_noresume(&pdev->dev);
>>
>>> +     pm_runtime_put(&pdev->dev);
>>
>> I don't see an explanation of these add-ons.
>
> As we explicitly do clk_disable_unprepare() in the error path, we must
> prevent the ->runtime_suspend() callback to be called during this
> period.
>
> This is a common pattern used by many drivers deploying runtime PM
> support, which is probably why I left out the explanation.
>
What would cause here runtime suspend during probe? Also pairing 
pm_runtime_get_noresume() with pm_runtime_put() instead of 
pm_runtime_put_noidle() looks suspicious to me.

-- 
Jarkko
