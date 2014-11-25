From: andy.green@linaro.org (Andy Green)
Date: Tue, 25 Nov 2014 21:42:08 +0800
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <54746C74.8020400@arm.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <54746C74.8020400@arm.com>
Message-ID: <CAAfg0W4ntf+yRZnipO+w7beN+EsZcryXCuD1eUJo1RYQNkJ2hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2014 at 19:48, Sudeep Holla <sudeep.holla@arm.com> wrote:

> On 20/11/14 12:35, Vincent Yang wrote:
>>
>> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
>> CPU/CLUSTER power up/down done by SCB over mailbox.
>>
>
>> diff --git a/arch/arm/mach-mb86s7x/smc.S b/arch/arm/mach-mb86s7x/smc.S
>> new file mode 100644
>> index 0000000..a14330b
>> --- /dev/null
>> +++ b/arch/arm/mach-mb86s7x/smc.S
>> @@ -0,0 +1,27 @@
>> +/*
>> + * SMC command interface to set secondary entry point
>> + * Copyright: (C) 2013-2014 Fujitsu Semiconductor Limited
>> + * Copyright: (C) 2014 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +
>> +.arch_extension sec
>> +
>> +/* void mb86s7x_cpu_entry(unsigned long secondary_entry); */
>> +ENTRY(mb86s7x_cpu_entry)
>> +       stmfd   sp!, {r1-r11, lr}
>> +       mov r1, r0
>> +       ldr r0, =1
>> +       mrc p15, 0, r3, c1, c0, 0
>> +       mov r4, r3
>> +       and r3, #0xbfffffff
>> +       mcr p15, 0, r3, c1, c0, 0
>> +       smc #0
>
>
> Interesting, it looks like you have some secure entity running on your
> platform.

Yes, we have a stub "secure firmware" that implements a few critical
functions to allow us to operate the kernel as nonsecure.  It's part
of the bootloader for this platform which is also GPL'd.

> 1. While the CPU is powered down who is taking care of saving it's
>    state as you are doing it in the Linux itself ?

Nothing.  The secure firmware is in a bootloader that is copied to and
runs from secure sram.  When the cpu is reset, he comes back up in
secure mode and gets initialized in the secure firmware, before
entering Non-secure mode and the kernel's secondary entry point.

> 2. Is Linux running in Secure or Non-secure mode ?

Another firmware (unfortunately not GPL) running on an on-die M3
informs the secure firmware on the AP whether he should set the AP cpu
to nonsecure or not before jumping to the kernel... basically it's
decided at runtime and the same kernel binary serves in both modes.

> 3. Why do you need this smc call for secondary boot only ?

The call sets the secondary entry point stored in the secure sram.

The bootloader heuristic is if that's unset (0), and it's what the
bootloader decided should be regarded as the primary cpu, then we do
the real onetime cold boot flow, load the kernel etc.  Non-primary
cpus wait at WFI in the bootloader.  When the primary cpu runs the
code above, he sets the secondary entry point, and later starts to
bring up the other cores who jump to the secondary entry that was set.

-Andy

> Regards,
> Sudeep
>
