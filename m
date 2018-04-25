From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 25 Apr 2018 11:33:42 +0200
Subject: [PATCH 00/11] platform: device tree support for early platform
 drivers
In-Reply-To: <20180424175752.GC3094@brightrain.aerifal.cx>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424175752.GC3094@brightrain.aerifal.cx>
Message-ID: <CAMRc=Mcs4zR4oA3duX7z05x-5ZFfFteFx93Fm-s9gX+tU5vpsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-24 19:57 GMT+02:00 Rich Felker <dalias@libc.org>:
> On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Device tree based systems often use OF_DECLARE() macros for devices
>> that need to be initialized early in the boot process such as clocks,
>> timers etc. However platform devices are more desirable.
>>
>> This series aims at introducing support for early platform drivers for
>> OF-based systems.
>>
>> The idea is to have a special compatible fallback string: "earlydev"
>> that similarily to "syscon" would be added to device nodes that need
>> early probing. We then need to call of_early_platform_populate() early
>> in the boot process to actually probe the registered devices.
>
> This makes no sense to me. It's not the device tree that should
> contain the knowledge that these need to be registered/probed early in
> the boot. That need is a property of the operating system/device
> drivers, and so the *drivers* should be the ones that contain the
> knowledge.
>
>> I am aware that this new compatible does not strictly correspond with
>> the "hardware description only" rule of DT, but we already have many
>> functionalities that break this rule: syscon, gpio hogs etc.
>>
>> The first user of this new functionality will be the DaVinci platform
>> for which we want to probe the pll, psc and timer drivers early in the
>> boot sequence but keep them implemented as platform drivers.
>>
>> In the future, if this series gets accepted, this could become and
>> alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
>> to deprecating of those macros in favor of early platform drivers.
>
> This seems completely unacceptable, in that it would render new
> kernels unable to boot on existing device trees (which may be
> hard-coded in rom on existing devices).
>

Just ot make it clear: by deprecating I meant not accepting any new
users, not blindly replacing the current ones.

Thanks,
Bart
