From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Sep 2015 11:20:22 +0530
Subject: [PATCH v3 0/2] regulator: Fix pbias regulator enable
In-Reply-To: <20150914202230.GY4215@atomide.com>
References: <1441368025-21182-1-git-send-email-kishon@ti.com>
 <CAPDyKFqCYx0JfXGq0T-44034UcR=v8nvKp7Fww=Zxa7N-z_vFg@mail.gmail.com>
 <20150914202230.GY4215@atomide.com>
Message-ID: <55F7B19E.1010804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 15 September 2015 01:52 AM, Tony Lindgren wrote:
> Hi,
> 
> * Ulf Hansson <ulf.hansson@linaro.org> [150904 05:48]:
>>
>> Okay, just to be clear on the way forward. I spoked with Mark Brown
>> offlist, and he will/has picked up the regulator patch and will send
>> it as fix for the 4.3 rc[n].
>>
>> Regarding the ARM patch here, I guess Tony might as well handle it and
>> send through arm-soc, especially since the regression won't be fixed
>> within my mmc tree anyway.
>>
>> So, I am going to leave my next branch as is - and thus relying on
>> teet the regression for OMAP will be fixed in some the 4.3 rc[n].
> 
> I'm picking up the .dts changes from this series into
> omap-for-v4.3/fixes as those are safe to apply while waiting
> for the pbias-regulator.c fix to hit mainline.
> 
> I'm not yet applying the related dts change "fix address translation
> for pbias" as that depends on the pbias-regulator.c change.
> 
> Howver, when testing all the patches applied, I'm still getting
> the following splat at least on duovero (with MMC working):
> 
> WARNING: CPU: 0 PID: 6 at drivers/regulator/core.c:2105 _regulator_disable+0x13c/0x1d4()
> unbalanced disables for pbias_mmc_omap4
> Modules linked in:
> CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.3.0-rc1-00015-gf5c4173-dirty #1295
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> Workqueue: deferwq deferred_probe_work_func
> [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
> [<c0013a58>] (show_stack) from [<c0346628>] (dump_stack+0x84/0x9c)
> [<c0346628>] (dump_stack) from [<c003e958>] (warn_slowpath_common+0x78/0xb4)
> [<c003e958>] (warn_slowpath_common) from [<c003e9c4>] (warn_slowpath_fmt+0x30/0x40)
> [<c003e9c4>] (warn_slowpath_fmt) from [<c03a4e74>] (_regulator_disable+0x13c/0x1d4)
> [<c03a4e74>] (_regulator_disable) from [<c03a4f3c>] (regulator_disable+0x30/0x6c)
> [<c03a4f3c>] (regulator_disable) from [<c04c55a8>] (omap_hsmmc_set_power+0x158/0x1e8)
> [<c04c55a8>] (omap_hsmmc_set_power) from [<c04c57d0>] (omap_hsmmc_set_ios+0x198/0x318)
> [<c04c57d0>] (omap_hsmmc_set_ios) from [<c04af404>] (mmc_power_up.part.10+0x30/0xf8)
> [<c04af404>] (mmc_power_up.part.10) from [<c04b0310>] (mmc_start_host+0x40/0x7c)
> [<c04b0310>] (mmc_start_host) from [<c04b1424>] (mmc_add_host+0x5c/0x84)
> [<c04b1424>] (mmc_add_host) from [<c04c5010>] (omap_hsmmc_probe+0x5b0/0x9f0)
> [<c04c5010>] (omap_hsmmc_probe) from [<c03e0e9c>] (platform_drv_probe+0x44/0xac)
> [<c03e0e9c>] (platform_drv_probe) from [<c03df550>] (driver_probe_device+0x1f4/0x2f0)
> [<c03df550>] (driver_probe_device) from [<c03dda5c>] (bus_for_each_drv+0x64/0x98)
> [<c03dda5c>] (bus_for_each_drv) from [<c03df2d0>] (__device_attach+0xb0/0x118)
> [<c03df2d0>] (__device_attach) from [<c03de878>] (bus_probe_device+0x88/0x90)
> [<c03de878>] (bus_probe_device) from [<c03deca0>] (deferred_probe_work_func+0x60/0x90)
> [<c03deca0>] (deferred_probe_work_func) from [<c005899c>] (process_one_work+0x1a4/0x558)
> [<c005899c>] (process_one_work) from [<c0058d8c>] (worker_thread+0x3c/0x514)
> [<c0058d8c>] (worker_thread) from [<c005eb1c>] (kthread+0xd4/0xf0)
> [<c005eb1c>] (kthread) from [<c000f710>] (ret_from_fork+0x14/0x24)
> 
> Kishon, can you please take a look?

really weird, since I didn't see any issues with my OMAP4 PANDA. Most
likely it's because the PBIAS register is not showing the correct state
of PBIAS. So we might have to remove using regulator_is_enabled and use
our own bookkeeping pbias_enabled variable. Anyway I'll check this.

Thanks
Kishon
