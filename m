From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 11 Jan 2012 19:55:37 +0530
Subject: [PATCH RFC] OMAP: I2C: Fix the mismatch of pm_runtime enable
 and disable
In-Reply-To: <CANOLnONdYYybbSP143+TeLxjfdEg1krcZjHwf140Fm5Y8rHogA@mail.gmail.com>
References: <1326288104-10544-1-git-send-email-shubhrajyoti@ti.com>
 <CANOLnONdYYybbSP143+TeLxjfdEg1krcZjHwf140Fm5Y8rHogA@mail.gmail.com>
Message-ID: <4F0D9BE1.6070209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012 07:29 PM, Grazvydas Ignotas wrote:
> On Wed, Jan 11, 2012 at 3:21 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>> Currently the i2c driver calls the pm_runtime_enable and never
>> the disable. This may cause a warning when pm_runtime_enable
>> checks for the count match.Attempting to fix the same by calling
>> pm_runtime_disable in the error and the remove path.
> I remember seeing Felipe doing the reverse to musb here:
> http://marc.info/?l=linux-omap&m=132432610700952&w=2
> so I'm confused here.
Strange however  I see many drivers doing the same in the kernel
on greping . Besides I expect a warn to come up.

Felipe could you explain the issue?


>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 12d402c..abc7b5b 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -1070,6 +1070,7 @@ err_unuse_clocks:
>>        omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>        pm_runtime_put(dev->dev);
>>        iounmap(dev->base);
>> +       pm_runtime_disable(&pdev->dev);
>>  err_free_mem:
>>        platform_set_drvdata(pdev, NULL);
>>        kfree(dev);
>> @@ -1085,6 +1086,7 @@ omap_i2c_remove(struct platform_device *pdev)
>>        struct omap_i2c_dev     *dev = platform_get_drvdata(pdev);
>>        struct resource         *mem;
>>
>> +       pm_runtime_disable(&pdev->dev);
>>        platform_set_drvdata(pdev, NULL);
>>
>>        free_irq(dev->irq, dev);
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
