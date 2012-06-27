From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 27 Jun 2012 14:31:45 +0530
Subject: [PATCH 07/11] I2C: OMAP: Handle error check for pm runtime
In-Reply-To: <874npxv8aj.fsf@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
 <1338288983-15026-8-git-send-email-shubhrajyoti@ti.com>
 <874npxv8aj.fsf@ti.com>
Message-ID: <CAM=Q2cuBh-YT454T7ZtqkcOSCGQLT5Ehp=J8rvj+6=0Gzct84Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 7:13 AM, Kevin Hilman <khilman@ti.com> wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> If PM runtime get_sync fails return with the error
>> so that no further reads/writes goes through the interface.
>> This will avoid possible abort. Add a error message in case
>> of failure with the cause of the failure.
>>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> This patch introduced a regression where the runtime PM usecount will
> never reach zero and so CORE retention is prevented after any xfer
> failures...
>
>> ---
>> -v10 Use IS_ERR_VALUE
>> -v9 Fix the error handling
>>
>> ?drivers/i2c/busses/i2c-omap.c | ? 14 +++++++++++---
>> ?1 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 44e8cfa..c39b72f 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>> ? ? ? int i;
>> ? ? ? int r;
>>
>> - ? ? pm_runtime_get_sync(dev->dev);
>> + ? ? r = pm_runtime_get_sync(dev->dev);<
>> + ? ? if (IS_ERR_VALUE(r))
>> + ? ? ? ? ? ? return r;
>
> This return should be 'goto out' so the runtime PM usecount is
> decremented by the 'put'. ?Otherwise, after failure, the usecount
> remains non-zero, so the device is considered 'active' and keeps the
> containing power domain active.
>
> I found this on a 3730/OveroSTORM where the suspend/resume of MMC fails
> because I2C is already suspended. ?After the suspend though, the CORE
> powerdomain never again hits retention, and I tracked it down to this.
>
> I'll send a separate patch to fix this shortly.

Thanks,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
