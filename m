From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 24 Jan 2012 20:03:33 -0600
Subject: [PATCH v3 1/7] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <CAJOA=zO8SYM2R+JHSfy4_v7Q2T2-ATfVribsxEQmd1fq7Lsi5g@mail.gmail.com>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <1327379854-12403-2-git-send-email-rob.lee@linaro.org>
 <CAJOA=zO8SYM2R+JHSfy4_v7Q2T2-ATfVribsxEQmd1fq7Lsi5g@mail.gmail.com>
Message-ID: <CAMXH7KGwp+Qc=C-NvwnWE5yBJUQOEZqWStgc72GCvdHSALhWow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, thanks for your review.  Comments below.

On Tue, Jan 24, 2012 at 5:46 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Mon, Jan 23, 2012 at 8:37 PM, Robert Lee <rob.lee@linaro.org> wrote:
>> diff --git a/drivers/cpuidle/common.c b/drivers/cpuidle/common.c
>> new file mode 100644
>> index 0000000..dafa758
>> --- /dev/null
>> +++ b/drivers/cpuidle/common.c
>> @@ -0,0 +1,152 @@
>> +/*
>> + * Copyright 2011 Freescale Semiconductor, Inc.
>> + * Copyright 2011 Linaro Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/*
>> + * This code performs provides some commonly used cpuidle setup functionality
>
> s/performs //
>
>> +static struct cpuidle_device __percpu * common_cpuidle_devices;
>
> You can use DECLARE_PER_CPU here.

Ok.  Do you mean that DECLARE_PER_CPU is preferred in this case?

>
> Is there any particular reason to allocate these dynamically? ?You can
> replace the code above with,
>
> static DEFINE_PER_CPU(struct cpuidle_device, common_cpuidle_devices);
>

I was thinking of the single kernel with multiple platform support
case.  In that particular case, it seems better to create the number
of device objects you need at run time.

> I might change the variable name to "cpu_cpuidle_device" in that case
> since you are addressing a single CPU when using the per cpu accessor
> functions and "common_cpuidle_devices" sounds like an array or a list
> or something. ?No big deal to keep the current name though.
>
>> +static int simple_enter(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv, int index)
>> +{
>> + ? ? ? ktime_t time_start, time_end;
>> +
>> + ? ? ? local_irq_disable();
>> +
>> + ? ? ? time_start = ktime_get();
>> +
>> + ? ? ? index = do_idle[index](dev, drv, index);
>> +
>> + ? ? ? time_end = ktime_get();
>> +
>> + ? ? ? local_irq_enable();
>> +
>> + ? ? ? dev->last_residency =
>> + ? ? ? ? ? ? ? (int)ktime_to_us(ktime_sub(time_end, time_start));
>
> Sometimes an attempt to enter some C-state fails and the do_idle will
> return immediately. ?What do you think about having do_idle return
> -EERROR in this case and the conditionally setting last_residency to
> zero in those cases? ?The point is that a C-state's total residency
> time should not increase in the case where the hardware did not
> successfully transition into that C-state. ?I've observed many times
> where a specific low power state was actually achieved in the hardware
> but /sys/devices/system/cpu/cpuN/cpuidle/stateM/time keeps
> incrementing (albeit in very tiny increments). ?Something like,
>
> if (IS_ERR(index))
> ? ? ? ?dev->last_residency = 0;
> else
> ? ? ? ?...
>
> Note: I haven't been through the CPUidle core in a while so maybe the
> above suggestion violates some other requirements/assumptions...
>

Good suggestion.  I'll look into adding this to v4.

>> +
>> + ? ? ? return index;
>> +}
>> +
>> +void common_cpuidle_devices_uninit(void)
>> +{
>> + ? ? ? int cpu_id;
>> + ? ? ? struct cpuidle_device *dev;
>> +
>> + ? ? ? for_each_possible_cpu(cpu_id) {
>> + ? ? ? ? ? ? ? dev = per_cpu_ptr(common_cpuidle_devices, cpu_id);
>> + ? ? ? ? ? ? ? cpuidle_unregister_device(dev);
>> + ? ? ? }
>> +
>> + ? ? ? free_percpu(common_cpuidle_devices);
>
> See note above about statically allocating the per-cpu variables.
>
>> +}
>> +
>> +/**
>> + * common_cpuidle_init() - Provides some commonly used init functionality.
>> + * @pdrv ? ? ? ? ? ? ? Pointer to your cpuidle_driver object.
>> + * @simple ? ? ? ? ? ? Use the common simple_enter wrapper?
>> + * @driver_data_init ? Pointer to your platform function to initialize your
>> + * ? ? ? ? ? ? ? ? ? ? platform specific driver data. ?Use NULL if platform
>> + * ? ? ? ? ? ? ? ? ? ? specific data is not needed.
>> + *
>> + * Common cpuidle init interface to provide common cpuidle functionality
>> + * used by many platforms.
>> + */
>> +int __init common_cpuidle_init(struct cpuidle_driver *pdrv, bool simple,
>> + ? ? ? ? ? ? ? ? ? ? ? ?void (*driver_data_init)(struct cpuidle_device *dev))
>> +{
>> + ? ? ? struct cpuidle_device *dev;
>> + ? ? ? struct cpuidle_driver *drv;
>> + ? ? ? int i, cpu_id, ret;
>> +
>> + ? ? ? if (!pdrv || pdrv->state_count > CPUIDLE_STATE_MAX) {
>> + ? ? ? ? ? ? ? pr_err("%s: Invalid Input\n", __func__);
>> + ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? }
>> +
>> + ? ? ? drv = kmalloc(sizeof(struct cpuidle_driver), GFP_KERNEL);
>> + ? ? ? if (!drv) {
>> + ? ? ? ? ? ? ? pr_err("%s: no memory for cpuidle driver\n", __func__);
>> + ? ? ? ? ? ? ? return -ENOMEM;
>> + ? ? ? }
>> +
>> + ? ? ? *drv = *pdrv;
>> +
>> + ? ? ? for (i = 0; simple && (i < drv->state_count); i++) {
>> + ? ? ? ? ? ? ? do_idle[i] = drv->states[i].enter;
>> + ? ? ? ? ? ? ? drv->states[i].enter = simple_enter;
>> + ? ? ? }
>> +
>> + ? ? ? ret = cpuidle_register_driver(drv);
>> + ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? pr_err("%s: Failed to register cpuidle driver\n", __func__);
>> + ? ? ? ? ? ? ? goto free_drv;
>> + ? ? ? }
>> +
>> + ? ? ? common_cpuidle_devices = alloc_percpu(struct cpuidle_device);
>> + ? ? ? if (common_cpuidle_devices == NULL) {
>> + ? ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? ? goto unregister_drv;
>> + ? ? ? }
>
> See note above about statically allocating these.
>
> Regards,
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
