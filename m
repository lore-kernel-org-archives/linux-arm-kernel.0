From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 13 Oct 2015 08:11:59 +0530
Subject: [PATCH 1/3] ARM: dts: exynos5422-odroidxu3: use cd-gpio method to
 detect sd-card
In-Reply-To: <561C4C88.2040004@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <561B3739.4040701@samsung.com> <561B3A83.6090607@samsung.com>
 <1111856990.2419183.1444661252893.JavaMail.yahoo@mail.yahoo.com>
 <561C4C88.2040004@samsung.com>
Message-ID: <CANAwSgT=jc9dAM-2oFTLg-7m3Tc5hEJH97vnu=EFf=+WdJhLaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 13 October 2015 at 05:42, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 12.10.2015 23:47, Anand Moon wrote:
>>>
>>> Anand,
>>>
>>> You essentially reverted here af6ad88acbd6 ("ARM: dts: Mux XMMCnDATA[0]
>>> pad correctly for Exynos5420 boards"). Why? There is no explanation in
>>> the commit message about this.
>>
>> I don't remember to send the patch relevant to this. Hmm...
>> Well, Is this patch really signed-off by me?
>>
>> Best Regards,
>>
>> Jaehoon Chung
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>>>
>>
>>
>> Some how I don't receive these mail on my email id.
>>
>> I have picked up these changes from tizen repository for OdroidXU3.
>> I have tested with this changes to detect UHS-I micro cd cards.
>> That's the reason for this email.
>
> ... and you applied it blindly without looking at actual existing
> contents and at previous commits.
>
> That is not how patches from different repositories should be cherry picked.

Sorry But I did not change it right way. By looking at the diff.
If the changes are wrong I will drop that changes.

I have to dig in my logs to find out why I have changes this setting.
Here is the log below, I will check If I am able to reproduce this bug
in the current kernel.

Sorry for the mess I have created.
---------------------------------------------------------------------------------------

Oct  6 08:23:21 odroidxu4 kernel: [    6.559940]
======================================================
Oct  6 08:23:21 odroidxu4 kernel: [    6.559943] [ INFO: possible
circular locking dependency detected ]
Oct  6 08:23:21 odroidxu4 kernel: [    6.559947] 4.2.0-xu4hkdn #7 Not tainted
Oct  6 08:23:21 odroidxu4 kernel: [    6.559950]
-------------------------------------------------------
Oct  6 08:23:21 odroidxu4 kernel: [    6.559954] swapper/0/1 is trying
to acquire lock:
Oct  6 08:23:21 odroidxu4 kernel: [    6.559972]
(&map->mutex){+.+...}, at: [<c04a9414>] regmap_lock_mutex+0x1c/0x20
Oct  6 08:23:21 odroidxu4 kernel: [    6.559975]
Oct  6 08:23:21 odroidxu4 kernel: [    6.559975] but task is already
holding lock:
Oct  6 08:23:21 odroidxu4 kernel: [    6.559987]
(prepare_lock){+.+.+.}, at: [<c05b468c>] clk_prepare_lock+0x20/0x108
Oct  6 08:23:21 odroidxu4 kernel: [    6.559990]
Oct  6 08:23:21 odroidxu4 kernel: [    6.559990] which lock already
depends on the new lock.
Oct  6 08:23:21 odroidxu4 kernel: [    6.559990]
Oct  6 08:23:21 odroidxu4 kernel: [    6.559993]
Oct  6 08:23:21 odroidxu4 kernel: [    6.559993] the existing
dependency chain (in reverse order) is:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560004]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560004] -> #1 (prepare_lock){+.+.+.}:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560019]        [<c06b90d0>]
mutex_lock_nested+0x84/0x4e4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560026]        [<c05b46cc>]
clk_prepare_lock+0x60/0x108
Oct  6 08:23:21 odroidxu4 kernel: [    6.560033]        [<c05b84a8>]
clk_unprepare+0x28/0x38
Oct  6 08:23:21 odroidxu4 kernel: [    6.560044]        [<c0542ba8>]
exynos5_i2c_xfer+0x2dc/0x3a4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560051]        [<c053e1b4>]
__i2c_transfer+0x160/0xc60
Oct  6 08:23:21 odroidxu4 kernel: [    6.560057]        [<c053ed28>]
i2c_transfer+0x74/0xa0
Oct  6 08:23:21 odroidxu4 kernel: [    6.560065]        [<c04b2be4>]
regmap_i2c_read+0x58/0x74
Oct  6 08:23:21 odroidxu4 kernel: [    6.560072]        [<c04ac38c>]
_regmap_raw_read+0x130/0x654
Oct  6 08:23:21 odroidxu4 kernel: [    6.560078]        [<c04ac8e4>]
_regmap_bus_read+0x34/0x6c
Oct  6 08:23:21 odroidxu4 kernel: [    6.560083]        [<c04ab350>]
_regmap_read+0x7c/0x350
Oct  6 08:23:21 odroidxu4 kernel: [    6.560090]        [<c04ab674>]
regmap_read+0x50/0x70
Oct  6 08:23:21 odroidxu4 kernel: [    6.560100]        [<c04043a0>]
regulator_is_enabled_regmap+0x30/0xa4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560107]        [<c03ff73c>]
_regulator_is_enabled.part.10+0x2c/0x38
Oct  6 08:23:21 odroidxu4 kernel: [    6.560113]        [<c04000c4>]
_regulator_do_set_voltage+0x720/0x9d0
Oct  6 08:23:21 odroidxu4 kernel: [    6.560119]        [<c0400438>]
regulator_set_voltage+0xc4/0x150
Oct  6 08:23:21 odroidxu4 kernel: [    6.560129]        [<c0589d6c>]
dw_mci_switch_voltage+0x98/0xbc
Oct  6 08:23:21 odroidxu4 kernel: [    6.560136]        [<c0570dc0>]
mmc_power_up.part.16+0x6c/0x108
Oct  6 08:23:21 odroidxu4 kernel: [    6.560143]        [<c0571e44>]
mmc_start_host+0x54/0x78
Oct  6 08:23:21 odroidxu4 kernel: [    6.560149]        [<c0573194>]
mmc_add_host+0x6c/0x90
Oct  6 08:23:21 odroidxu4 kernel: [    6.560156]        [<c058ae84>]
dw_mci_probe+0x660/0xc98
Oct  6 08:23:21 odroidxu4 kernel: [    6.560162]        [<c058c978>]
dw_mci_pltfm_register+0x9c/0xa8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560168]        [<c058d014>]
dw_mci_exynos_probe+0x30/0x38
Oct  6 08:23:21 odroidxu4 kernel: [    6.560176]        [<c048de40>]
platform_drv_probe+0x54/0xb4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560183]        [<c048b9d8>]
driver_probe_device+0x184/0x2c0
Oct  6 08:23:21 odroidxu4 kernel: [    6.560189]        [<c048bbb8>]
__driver_attach+0xa4/0xa8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560195]        [<c0489b90>]
bus_for_each_dev+0x78/0xac
Oct  6 08:23:21 odroidxu4 kernel: [    6.560202]        [<c048b498>]
driver_attach+0x2c/0x30
Oct  6 08:23:21 odroidxu4 kernel: [    6.560208]        [<c048b0a4>]
bus_add_driver+0x1b0/0x228
Oct  6 08:23:21 odroidxu4 kernel: [    6.560214]        [<c048ce6c>]
driver_register+0x88/0x108
Oct  6 08:23:21 odroidxu4 kernel: [    6.560221]        [<c048dd6c>]
__platform_driver_register+0x64/0x6c
Oct  6 08:23:21 odroidxu4 kernel: [    6.560229]        [<c0995abc>]
dw_mci_exynos_pltfm_driver_init+0x1c/0x20
Oct  6 08:23:21 odroidxu4 kernel: [    6.560237]        [<c0009820>]
do_one_initcall+0x9c/0x1e8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560245]        [<c095efa8>]
kernel_init_freeable+0x250/0x2f4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560252]        [<c06b3774>]
kernel_init+0x1c/0xf8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560259]        [<c000fe58>]
ret_from_fork+0x14/0x3c
Oct  6 08:23:21 odroidxu4 kernel: [    6.560269]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560269] -> #0 (&map->mutex){+.+...}:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560277]        [<c008ac00>]
lock_acquire+0x128/0x378
Oct  6 08:23:21 odroidxu4 kernel: [    6.560284]        [<c06b90d0>]
mutex_lock_nested+0x84/0x4e4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560290]        [<c04a9414>]
regmap_lock_mutex+0x1c/0x20
Oct  6 08:23:21 odroidxu4 kernel: [    6.560296]        [<c04ab664>]
regmap_read+0x40/0x70
Oct  6 08:23:21 odroidxu4 kernel: [    6.560304]        [<c05bd62c>]
s2mps11_clk_is_prepared+0x30/0x4c
Oct  6 08:23:21 odroidxu4 kernel: [    6.560310]        [<c05b4bc8>]
clk_unprepare_unused_subtree+0x84/0x564
Oct  6 08:23:21 odroidxu4 kernel: [    6.560316]        [<c05b7940>]
clk_disable_unused+0xb8/0x148
Oct  6 08:23:21 odroidxu4 kernel: [    6.560322]        [<c0009820>]
do_one_initcall+0x9c/0x1e8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560328]        [<c095efa8>]
kernel_init_freeable+0x250/0x2f4
Oct  6 08:23:21 odroidxu4 kernel: [    6.560334]        [<c06b3774>]
kernel_init+0x1c/0xf8
Oct  6 08:23:21 odroidxu4 kernel: [    6.560340]        [<c000fe58>]
ret_from_fork+0x14/0x3c
Oct  6 08:23:21 odroidxu4 kernel: [    6.560343]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560343] other info that might
help us debug this:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560343]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560346]  Possible unsafe
locking scenario:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560346]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560349]        CPU0
         CPU1
Oct  6 08:23:21 odroidxu4 kernel: [    6.560351]        ----
         ----
Oct  6 08:23:21 odroidxu4 kernel: [    6.560358]   lock(prepare_lock);
Oct  6 08:23:21 odroidxu4 kernel: [    6.560365]
         lock(&map->mutex);
Oct  6 08:23:21 odroidxu4 kernel: [    6.560371]
         lock(prepare_lock);
Oct  6 08:23:21 odroidxu4 kernel: [    6.560378]   lock(&map->mutex);
Oct  6 08:23:21 odroidxu4 kernel: [    6.560380]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560380]  *** DEADLOCK ***
Oct  6 08:23:21 odroidxu4 kernel: [    6.560380]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560384] 1 lock held by swapper/0/1:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560397]  #0:
(prepare_lock){+.+.+.}, at: [<c05b468c>] clk_prepare_lock+0x20/0x108
Oct  6 08:23:21 odroidxu4 kernel: [    6.560400]
Oct  6 08:23:21 odroidxu4 kernel: [    6.560400] stack backtrace:
Oct  6 08:23:21 odroidxu4 kernel: [    6.560405] CPU: 2 PID: 1 Comm:
swapper/0 Not tainted 4.2.0-xu4hkdn #7
Oct  6 08:23:21 odroidxu4 kernel: [    6.560408] Hardware name:
SAMSUNG EXYNOS (Flattened Device Tree)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560418] [<c00189bc>]
(unwind_backtrace) from [<c0014608>] (show_stack+0x20/0x24)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560424] [<c0014608>]
(show_stack) from [<c06b64f8>] (dump_stack+0x8c/0xcc)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560430] [<c06b64f8>]
(dump_stack) from [<c0083c34>] (print_circular_bug+0x218/0x340)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560436] [<c0083c34>]
(print_circular_bug) from [<c0089d14>] (__lock_acquire+0x1c40/0x227c)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560441] [<c0089d14>]
(__lock_acquire) from [<c008ac00>] (lock_acquire+0x128/0x378)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560447] [<c008ac00>]
(lock_acquire) from [<c06b90d0>] (mutex_lock_nested+0x84/0x4e4)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560453] [<c06b90d0>]
(mutex_lock_nested) from [<c04a9414>] (regmap_lock_mutex+0x1c/0x20)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560458] [<c04a9414>]
(regmap_lock_mutex) from [<c04ab664>] (regmap_read+0x40/0x70)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560464] [<c04ab664>]
(regmap_read) from [<c05bd62c>] (s2mps11_clk_is_prepared+0x30/0x4c)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560471] [<c05bd62c>]
(s2mps11_clk_is_prepared) from [<c05b4bc8>]
(clk_unprepare_unused_subtree+0x84/0x564)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560477] [<c05b4bc8>]
(clk_unprepare_unused_subtree) from [<c05b7940>]
(clk_disable_unused+0xb8/0x148)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560482] [<c05b7940>]
(clk_disable_unused) from [<c0009820>] (do_one_initcall+0x9c/0x1e8)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560487] [<c0009820>]
(do_one_initcall) from [<c095efa8>] (kernel_init_freeable+0x250/0x2f4)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560493] [<c095efa8>]
(kernel_init_freeable) from [<c06b3774>] (kernel_init+0x1c/0xf8)
Oct  6 08:23:21 odroidxu4 kernel: [    6.560498] [<c06b3774>]
(kernel_init) from [<c000fe58>] (ret_from_fork+0x14/0x3c)

-Anand Moon

>
> Best regards,
> Krzysztof
>
