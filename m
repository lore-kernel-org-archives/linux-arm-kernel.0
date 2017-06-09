From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 9 Jun 2017 15:05:52 -0700
Subject: Drivers taking different actions depending on sleep state
In-Reply-To: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
Message-ID: <9d929be0-67af-22f9-6412-424e258ac9d4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 08:20 AM, Mason wrote:
> Hello,
> 
> I read the "Sleep States" documentation:
> https://www.kernel.org/doc/Documentation/power/states.txt
> 
> It mentions /sys/power/mem_sleep but I don't have that in 4.9
> # ll /sys/power/
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_async
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_freeze_timeout
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 state
> -rw-r--r--    1 root     root          4096 Jan  1 00:31 wakeup_count
> 
> # cat /sys/power/state 
> freeze mem
> 
> Currently my platform's "mem" is a true suspend-to-RAM trigger,
> where drivers are supposed to save their state (register values
> will be lost), then Linux hands control over to firmware which
> enables RAM self-refresh and powers the chip down. When the system
> resumes, drivers restore their state from their copy in memory.
> 
> One driver is responsible for loading/unloading microcode running
> on the DSPs. This operation is required only when powering down
> the chip, but it should be avoided for "low-latency" sleeps.

Yes, makes sense, the STB SoCs I work with have similar requirements,
and we could benefit from being able to skip/bypass re-initialization
while entering/leaving S2 for instance.

> 
> The problem is that, if I understand correctly, drivers have no way
> of knowing which sleep state is being entered/exited?
> 
> How can I have the microcode driver take different decisions
> based on the sleep state?

Ideally, pm_message_t could have reflected the system suspend/resume
state you are entering/leaving, but that does not appear to be the case
(unlike say, PCI).

I am not sure why that's not the case, but since most platform drivers
use the "SIMPLE_DEV_PM_OPS" if we were to actually make pm_message_t
reflect the system sleep state (PM_SUSPEND_STANDBY, PM_SUSPEND_MEM etc.)
-- 
Florian
