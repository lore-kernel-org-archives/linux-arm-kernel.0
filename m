From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 01:38:17 +0530
Subject: [PATCH 2/5] thermal: exynos: cleanup of clk err check for
 exynos_tmu_work
In-Reply-To: <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-2-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
Message-ID: <CANAwSgTrsOv_cg470tze2vLLNAPEV1oApTEKep6gK8mPzWMiQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 17 July 2018 at 17:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> cleanup err check in exynos_tmu_work as clk internal
>> framework will perform if clk is enable/disable
>> so drop the double check of IS_ERR and other such references.
>
> I do not understand the statement. Clock framework will perform if clk
> is enable/disable? How clock can be "enable" or "disable"? You mean
> gate clock? you mean clock pointer is an ERR pointer?
>

if (!IS_ERR(data->clk_sec))
check if the pointer is valid or not
this check is again performed in
clk_enable.

>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index 0164c9e..2dbde97 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>
>>         mutex_lock(&data->lock);
>>         clk_enable(data->clk);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_enable(data->clk_sec);
>> +       clk_enable(data->clk_sec);
>>
>>         status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>>         if (!status) {
>> @@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>  err:
>>         clk_disable(data->clk);
>>         mutex_unlock(&data->lock);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_disable(data->clk_sec);
>> +       clk_disable(data->clk_sec);
>>  out:
>>         return ret;
>>  }
>> @@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
>>         struct exynos_tmu_data *data = container_of(work,
>>                         struct exynos_tmu_data, irq_work);
>>
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_enable(data->clk_sec);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_disable(data->clk_sec);
>> -
>>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>>
>>         mutex_lock(&data->lock);
>>         clk_enable(data->clk);
>> +       clk_enable(data->clk_sec);
>
> You are changing here the logic completely. Before the "enable" was
> followed immediately by "disable". Now you are moving disable
> somewhere else... All this looks suspicious...

I chose to move enable/disable of clk_sec this under the mutex lock for safe
which dose the same sequence with different order.

Second approach:
We should get rid of clk_enable/disable in exynos_tmu_work
as this looks unnecessary for toggle clk's on every update.

Best Regards
-Anand
