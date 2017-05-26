From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 26 May 2017 11:25:25 +0200
Subject: [PATCH] reset: hisilicon: Fix hi6220 module license
In-Reply-To: <CAK8P3a2qLxBNG61BX3g02cEXMg7LVA5ghxbW78n81c0+3ZKkXg@mail.gmail.com>
References: <20170525092232.27960-1-afaerber@suse.de>
 <CAK8P3a2qLxBNG61BX3g02cEXMg7LVA5ghxbW78n81c0+3ZKkXg@mail.gmail.com>
Message-ID: <b4913fa6-84d9-33f3-9de0-a601f88d8e6a@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.05.2017 um 10:44 schrieb Arnd Bergmann:
> On Thu, May 25, 2017 at 11:22 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> The hi6220_reset driver fails to load:
>>
>>   [   10.423640] hi6220_reset: module license 'unspecified' taints kernel.
>>   [   10.423644] Disabling lock debugging due to kernel taint
>>   [   10.423735] hi6220_reset: Unknown symbol regmap_write (err 0)
>>   [   10.423747] hi6220_reset: Unknown symbol devm_kmalloc (err 0)
>>   [   10.423759] hi6220_reset: Unknown symbol syscon_node_to_regmap (err 0)
>>   [   10.423768] hi6220_reset: Unknown symbol reset_controller_register (err 0)
>>   [   10.423784] hi6220_reset: Unknown symbol __platform_driver_register (err 0)
>>
>> Add a MODULE_LICENSE() to fix this.
>>
>> Fixes: 70b3590f639f ("reset: hi6220: fix modular build")
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I wonder why I never ran into this in randconfig testing.

In the bigger picture I also found that PINCTRL_SINGLE needs to be
built-in for the HiKey to proceed beyond earlycon. Usually when an
option can be built as module, we build it as module.

Further to that, I needed the following config for dracut so far:

add_drivers+=" hi6220_reset hi6220-mailbox hi655x-pmic hi655x-regulator"

I'm still not able to boot 4.11 from SD with our config:

https://bugzilla.opensuse.org/show_bug.cgi?id=1040492

Any hints appreciated on what drivers may be missing in the initrd and
why dracut is not picking them up on its own.

And as pointed out at BUD17, it would be really great if Linaro would
actually test modules for 96Boards - be it via Lava or manually once.
Our configs are public on kernel.opensuse.org / GitHub kernel-source.git
in case that aids with your testing - master is for linux.git tags,
vanilla for linux.git master and linux-next for linux-next.git master.

Investigating why the DragonBoard 410c gets stuck is still ongoing, too.

For the Poplar I'm currently running into partition size issues trying
to install additional kernels, so I couldn't verify beyond 4.11 yet.
https://github.com/Linaro/poplar-tools/pull/3#issuecomment-304215367
It also seems to need CONFIG_PINCTRL_SINGLE=y though.

For the HiKey 960 I'm lacking documentation how to get started
bootloader-wise - by default it's uninterruptibly booting AOSP.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
