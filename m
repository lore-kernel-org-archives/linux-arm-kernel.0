From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 10:49:36 +0200
Subject: [PATCH] soc/tegra: Register SoC device
In-Reply-To: <20170822111922.GA15965@ulmo>
References: <20170817144217.31346-1-thierry.reding@gmail.com>
 <61dde661-313f-0b51-233b-ce957c514a55@arm.com> <20170822111922.GA15965@ulmo>
Message-ID: <CAK8P3a0XHobGzSzP4w5zCJNZ-v2bmZ8yFPs0PudD9XMETJDJdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 1:19 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Aug 22, 2017 at 11:15:21AM +0100, Sudeep Holla wrote:
>>
>>
>> On 17/08/17 15:42, Thierry Reding wrote:
>> > From: Thierry Reding <treding@nvidia.com>
>> >
>> > Move this code from arch/arm/mach-tegra and make it common among 32-bit
>> > and 64-bit Tegra SoCs. This is slightly complicated by the fact that on
>> > 32-bit Tegra, the SoC device is used as the parent for all devices that
>> > are instantiated from device tree.
>> >
>>
>> This seem to be in linux-next and causing the below splat on my platform
>> which is not Tegra :)
>>
>> WARNING: .... at drivers/soc/tegra/fuse/tegra-apbmisc.c:48
>> tegra_get_chip_id+0x30/0x40
>> Modules linked in:
>> CPU: 2 PID: 1 Comm: swapper/0 Not tainted
>> 4.13.0-rc6-next-20170822-00008-g52a8e57512ae #13
>> task: ffff8009768a0000 task.stack: ffff000008038000
>> PC is at tegra_get_chip_id+0x30/0x40
>> LR is at tegra_get_chip_id+0x30/0x40
>>  tegra_get_chip_id+0x30/0x40
>>  tegra_soc_device_register+0x68/0xd0
>>  tegra_init_soc+0x10/0x44
>>  do_one_initcall+0x38/0x120
>>  kernel_init_freeable+0x184/0x224
>>  kernel_init+0x10/0x100
>>  ret_from_fork+0x10/0x18
>
> Indeed. Does the below patch fix this?
>
> Thierry
>
> --- >8 ---
> From 5706cacc2af5e4ef138d1cd9e1269ca4947a447f Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Tue, 22 Aug 2017 13:15:18 +0200
> Subject: [PATCH] soc/tegra: Restrict SoC device registration to Tegra
>
> Commit 8a46828e623c ("soc/tegra: Register SoC device") added an initcall
> to register the SoC device on Tegra. However, that code is unrestricted
> and will run on all platforms, causing unwanted warnings.
>
> Fix this by first checking that we're running on hardware that supports
> the fuses block that we use to provide SoC information.
>
> Fixes: 8a46828e623c ("soc/tegra: Register SoC device")
> Signed-off-by: Thierry Reding <treding@nvidia.com>

I just found the same thing by inspection after running into

drivers/soc/tegra/fuse/fuse-tegra.c:360:0: error: expected ';' at end of input

Please fix that as well.

Lastly, I believe that tegra_init_fuse() has the same bug, it just doesn't lead
to an Oops, just to a harmless warning message, but please add another
check there, or combine the two checks in some form.

     Arnd
