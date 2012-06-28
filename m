From: khilman@ti.com (Kevin Hilman)
Date: Thu, 28 Jun 2012 16:55:08 -0500
Subject: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
In-Reply-To: <CAM=Q2cuLCT2VzcUgrpyRWiX61t1F+iWchO9iLC=Ka9MFVm4_bQ@mail.gmail.com>
 (Shubhrajyoti Datta's message of "Wed, 27 Jun 2012 11:41:47 +0530")
References: <1340761532-27231-1-git-send-email-khilman@ti.com>
 <CAM=Q2cuLCT2VzcUgrpyRWiX61t1F+iWchO9iLC=Ka9MFVm4_bQ@mail.gmail.com>
Message-ID: <87lij7nltv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,

Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:

> Hi Kevin,
> Thanks for the patch ,
> a doubt below

Thanks for the review.

> On Wed, Jun 27, 2012 at 7:15 AM, Kevin Hilman <khilman@ti.com> wrote:
>> In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
>> failure.
> So the failure means that the usecount is incremented. However the
> device was not
> enabled. 

Correct.

> In that case could we consider
>
>    void pm_runtime_put_noidle(struct device *dev);
>     - decrement the device's usage counter
>
> Which will only decrement the counter and does not try to disable it.

No, that is not needed.

> However I am not sure what happens if you try to disable an already
> disabled device.

The runtime PM core already knows that the device is not enabled so will
not need to call the disable hooks.  It already needs this functionality
to support the _get_noresume() and _put_noidle() calls.

I tested this on 3730/OveroSTORM where I was seeing this i2c xfer
failure (and thus a failure in MMC suspend, which uses I2C to control
the regulator.)

Hope that helps clarify,

If so, Wolfram, can you queue this up in your i2c-embedded/for-next
branch since this problem was introduced there.

Thanks,

Kevin

>>
>> Without this, after a failed xfer, the runtime PM usecount will have
>> been incremented, but not decremented
>
> Agree.
>
>> causing the usecount to never
>> reach zero after a failure. ?This keeps the device always runtime PM
>> enabled which keeps the enclosing power domain active, and prevents
>> full-chip retention/off from happening during idle.
>>
>> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> This patch applies to current i2c-embedded/for-next branch
>>
>> ?drivers/i2c/busses/i2c-omap.c | ? ?2 +-
>> ?1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 9895fa7..b105733 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -582,7 +582,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>
>> ? ? ? ?r = pm_runtime_get_sync(dev->dev);
>> ? ? ? ?if (IS_ERR_VALUE(r))
>> - ? ? ? ? ? ? ? return r;
>> + ? ? ? ? ? ? ? goto out;
>>
>> ? ? ? ?r = omap_i2c_wait_for_bb(dev);
>> ? ? ? ?if (r < 0)
>> --
>> 1.7.9.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
