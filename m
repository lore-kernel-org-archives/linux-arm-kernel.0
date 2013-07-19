From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jul 2013 19:09:57 +0800
Subject: [RFC PATCH 0/5] arm64: initial CPU_HOTPLUG support
In-Reply-To: <20130711163458.GA8303@kartoffel>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
 <51DECAFB.4010800@linaro.org> <20130711163458.GA8303@kartoffel>
Message-ID: <CAGHbJ3ADJ3tKR2DiL8XNh8wZqY1k0OFeOSAHa61ALvUyicmg9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-7-12 0:34, Mark Rutland wrote:
> On Thu, Jul 11, 2013 at 04:10:51PM +0100, Hanjun Guo wrote:
>> Hi Mark,
>
> Hi Hanjun,
>
>>
>> I tested this patch set on the armv8 foundation model, it's panic.
>>
>> I seems that we need to do something more, I'll also checkout
>> what's going on here.
>>
>> Thanks
>> Hanjun
>>
>> dump formation:
>> root at genericarmv8:/sys/devices/system/cpu/cpu3# echo 0 > online
>> CPU3: Booted secondary processor
>> CPU3: shutdown
>> BUG: failure at kernel/time/clockevents.c:284/clockevents_register_device()!
>> Kernel panic - not syncing: BUG!
>> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.10.0+ #2
>> Call trace:
>> [<ffffffc0000873e0>] dump_backtrace+0x0/0x12c
>> [<ffffffc000087520>] show_stack+0x14/0x1c
>> [<ffffffc0003f2e7c>] dump_stack+0x20/0x28
>> [<ffffffc0003efd24>] panic+0xe8/0x214
>> [<ffffffc0000d049c>] clockevents_set_mode+0x0/0x6c
>> [<ffffffc0000d074c>] clockevents_config_and_register+0x24/0x30
>> [<ffffffc0003ef840>] arch_timer_setup+0xd8/0x140
>> [<ffffffc0003ef8f0>] arch_timer_cpu_notify+0x48/0xc8
>> [<ffffffc0000b83e4>] notifier_call_chain+0x48/0x88
>> [<ffffffc0000b8500>] __raw_notifier_call_chain+0xc/0x14
>> [<ffffffc0000973f0>] __cpu_notify+0x30/0x58
>> [<ffffffc00009742c>] cpu_notify+0x14/0x1c
>> [<ffffffc0003ed46c>] notify_cpu_starting+0x14/0x1c
>> [<ffffffc0003ece74>] secondary_start_kernel+0xc0/0xf4
>
> That looks suspicious. It looks like the CPU didn't actually die and jumped
> immediately to secondary_start_kernel. At a guess, did you update your dts with
> a psci node and cpu enable-methods?
>
> I can see the code's broken if you try hotplug with spin-table, because
> cpu_disable and cpu_die are both NULL, and the sanity checking doesn't attempt
> to deal with this case, so the cpu will end up getting into cpu_die, won't call
> anything, and jump straight back into the kernel. I'll fix up the
> op_cpu_disable checks to cover this.
>
> The other possibility is that you're using PSCI but your function id for
> cpu_off is wrong, and thus the psci cpu_off call fails. Did you update your dts
> for PSCI? Below is a patch to do so.

Hi Mark,

Sorry for the late reply.

I updated the boot wrapper and applied the dts patch you provided, and then
I test the cpu online/offline, it works fine on the armv8 foundation model.
It also works fine combined with my ACPI CPU hot-plug driver, I can eject
(hot remove) a CPU now :)

Thanks
Hanjun
