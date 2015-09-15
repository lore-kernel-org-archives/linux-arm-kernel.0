From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 14 Sep 2015 19:52:41 -0700
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <55F6AC87.4040301@arm.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
 <55DB4609.5040904@arm.com>
 <CAGS+omBnoitju07KQ1Y7JHTbce6+DO4WqWHTaKz5D+T157zEJA@mail.gmail.com>
 <1441535972.22230.5.camel@mhfsdcap03> <55EEAA24.6080706@arm.com>
 <55EF11E6.7030307@arm.com> <1442051454.5661.12.camel@mhfsdcap03>
 <55F6AC87.4040301@arm.com>
Message-ID: <CAKdAkRSFE2KJOzbUarxAQMNwHOkkyGHXmRLGhn55VTvG-SJ4Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 4:16 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 12/09/15 10:50, maoguang meng wrote:
>> hi Sudeep:
>>
>> I test flowlling your blow suggestions,but the system can not be woken.
>>
>> beacuse,mtk_eint_suspend will mask it.As we know if eint wakeup system
>> it must be unmasked before enter suspend flow.
>>
>> e.x
>>
>> static int __maybe_unused elan_suspend(struct device *dev)
>> {
>>       struct i2c_client *client = to_i2c_client(dev);
>>       struct elan_tp_data *data = i2c_get_clientdata(client);
>>       int ret;
>>
>>       /*
>>        * We are taking the mutex to make sure sysfs operations are
>>        * complete before we attempt to bring the device into low[er]
>>        * power mode.
>>        */
>>       ret = mutex_lock_interruptible(&data->sysfs_mutex);
>>       if (ret)
>>               return ret;
>>
>>       disable_irq(client->irq);
>>
>>       if (device_may_wakeup(dev)) {
>>               ret = elan_sleep(data);
>>               /* Enable wake from IRQ */
>>               data->irq_wake = (enable_irq_wake(client->irq) == 0);
>
> This is wrong assumption in the driver. enable_irq_wake doesn't
> implicitly enable the IRQ. So the disable_irq should be moved to else.
> And the resume patch also needs to be fixed accordingly, otherwise you
> may get unbalanced irq. But this should not be the reason for fixing the
> pinctrl suspend/resume.
>

Elan driver does not want to enable servicing IRQs, it just wants to
configure them as wakeup sources. Hence the current elan_suspend() is
fine. When system wakes up and the device is resumed and the driver is
ready to service interrupts it will enable IRQ again.

IOW enable_irq_wake() and enable_irq() are 2 completely different
calls and it is perfectly fine to disable IRQ and then ebale it as a
wakeup source.

Thanks.

-- 
Dmitry
