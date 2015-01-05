From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 05 Jan 2015 16:59:44 +0800
Subject: [PATCH v6 14/17] ARM64 / ACPI: Parse GTDT to initialize arch timer
In-Reply-To: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
References: <D0CF9C94.CD69%suravee.suthikulpanit@amd.com>
Message-ID: <54AA5280.3050802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?05? 15:55, Suthikulpanit, Suravee wrote:
> On 1/4/15, 04:55, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
>
>> Using the information presented by GTDT to initialize the arch
>> timer (not memory-mapped).
>>
>> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>> arch/arm64/kernel/time.c             |   7 ++
>> drivers/clocksource/arm_arch_timer.c | 132
>> ++++++++++++++++++++++++++++-------
>> include/linux/clocksource.h          |   6 ++
>> 3 files changed, 118 insertions(+), 27 deletions(-)
[...]
>> +static void __init arch_timer_of_init(struct device_node *np)
>> +{
>> +	int i;
>> +
>> +	if (arch_timers_present & ARCH_CP15_TIMER) {
>> +		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
>> +		return;
>> +	}
>> +
>> +	arch_timers_present |= ARCH_CP15_TIMER;
>> +	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
>> +		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>> +
>> +	arch_timer_detect_rate(NULL, np);
>> +
>> +	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>> +
>> +	/*
>> +	 * If we cannot rely on firmware initializing the timer registers then
>> +	 * we should use the physical timers instead.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ARM) &&
>> +	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
>> +			arch_timer_use_virtual = false;
>> +
>> +	arch_timer_init();
>> +}
>> +CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer",
>> arch_timer_of_init);
>> +CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer",
>> arch_timer_of_init);
>
> Hanjun,
>
> FYI, it seems that the tree that you have rebased the patch series has an
> issue determining clocksource in ARM64 introduced by this commit.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0
> b46b8a718c6e90910a1b1b0fe797be3c167e186
>
> Here is the fix from Catalin that already went upstream:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drive
> rs/clocksource/arm_arch_timer.c?id=d6ad36913083d683aad4e02e53580c995f1a6ede

This bug fix patch was merged in Dec 30 by Linus, which is the date
after 3.19-rc2 released :)

Thanks
Hanjun
