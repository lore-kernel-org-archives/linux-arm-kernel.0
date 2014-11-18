From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 18 Nov 2014 12:04:20 +0100
Subject: [BUG] blocked task after exynos_drm_init
In-Reply-To: <546B2508.8070409@samsung.com>
References: <1415264811.27478.4.camel@AMDC1943> <546B228E.6030500@samsung.com>
 <546B2508.8070409@samsung.com>
Message-ID: <546B27B4.4040808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 11:52 AM, Inki Dae wrote:
> On 2014? 11? 18? 19:42, Andrzej Hajda wrote:
>> On 11/06/2014 10:06 AM, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> On last next (next-20141104, next-20141105) booting locks after
>>> initializing Exynos DRM (Trats2 board):
>>>
>>> [    2.028283] [drm] Initialized drm 1.1.0 20060810
>>> [  240.505795] INFO: task swapper/0:1 blocked for more than 120 seconds.
>>> [  240.510825]       Not tainted 3.18.0-rc3-next-20141105 #794
>>> [  240.516418] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> [  240.524173] swapper/0       D c052534c     0     1      0 0x00000000
>>> [  240.530527] [<c052534c>] (__schedule) from [<c0525b34>] (schedule_preempt_disabled+0x14/0x20)
>>> [  240.539030] [<c0525b34>] (schedule_preempt_disabled) from [<c0526d44>] (mutex_lock_nested+0x1c4/0x464)
>>> [  240.548320] [<c0526d44>] (mutex_lock_nested) from [<c02be908>] (__driver_attach+0x48/0x98)
>>> [  240.556562] [<c02be908>] (__driver_attach) from [<c02bcc00>] (bus_for_each_dev+0x54/0x88)
>>> [  240.564717] [<c02bcc00>] (bus_for_each_dev) from [<c02bdce0>] (bus_add_driver+0xe4/0x200)
>>> [  240.572876] [<c02bdce0>] (bus_add_driver) from [<c02bef94>] (driver_register+0x78/0xf4)
>>> [  240.580864] [<c02bef94>] (driver_register) from [<c029e99c>] (exynos_drm_platform_probe+0x34/0x234)
>>> [  240.589890] [<c029e99c>] (exynos_drm_platform_probe) from [<c02bfcf0>] (platform_drv_probe+0x48/0xa4)
>>> [  240.599090] [<c02bfcf0>] (platform_drv_probe) from [<c02be680>] (driver_probe_device+0x13c/0x37c)
>>> [  240.607940] [<c02be680>] (driver_probe_device) from [<c02be954>] (__driver_attach+0x94/0x98)
>>> [  240.616360] [<c02be954>] (__driver_attach) from [<c02bcc00>] (bus_for_each_dev+0x54/0x88)
>>> [  240.624517] [<c02bcc00>] (bus_for_each_dev) from [<c02bdce0>] (bus_add_driver+0xe4/0x200)
>>> [  240.632679] [<c02bdce0>] (bus_add_driver) from [<c02bef94>] (driver_register+0x78/0xf4)
>>> [  240.640667] [<c02bef94>] (driver_register) from [<c029e938>] (exynos_drm_init+0x70/0xa0)
>>> [  240.648739] [<c029e938>] (exynos_drm_init) from [<c00089b0>] (do_one_initcall+0xac/0x1f0)
>>> [  240.656914] [<c00089b0>] (do_one_initcall) from [<c074bd90>] (kernel_init_freeable+0x10c/0x1d8)
>>> [  240.665591] [<c074bd90>] (kernel_init_freeable) from [<c051eabc>] (kernel_init+0x8/0xec)
>>> [  240.673661] [<c051eabc>] (kernel_init) from [<c000f268>] (ret_from_fork+0x14/0x2c)
>>> [  240.681196] 3 locks held by swapper/0/1:
>>> [  240.685091]  #0:  (&dev->mutex){......}, at: [<c02be908>] __driver_attach+0x48/0x98
>>> [  240.692732]  #1:  (&dev->mutex){......}, at: [<c02be918>] __driver_attach+0x58/0x98
>>> [  240.700367]  #2:  (&dev->mutex){......}, at: [<c02be908>] __driver_attach+0x48/0x98
>>
>>
>> This is caused by patch moving platform devices to
>> /sys/devices/platform[1]. Since this patch registering platform
>> drivers/devices in probe of platform device causes deadlocks. I guess
>> now all driver registration should be moved to exynos_drm_init and it
>> seems better location for it IMHO.
> 
> Thanks. It might be a chance that we could separate sub drivers of
> Exynos drm into independent modules so that they can be called
> independently because if we move them to exynos_drm_init then the
> deferred probe wouldn't work correctly.

For full separation of sub-drivers component matching code should be
fixed first. Now it usually works because components are probed before
exynos_drm_match_add and this is because components are probed during
sub-driver registrations.

Regards
Andrzej

> 
> Thanks,
> Inki Dae
> 
>>
>> Regards
>> Andrzej
>>
>> [1]: http://www.spinics.net/lists/devicetree/msg56101.html
>>
>>
>>
>>>
>>> Full dmesg and config attached.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel at lists.freedesktop.org
>>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
