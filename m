From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 00:18:58 +0000
Subject: [PATCH 3/4] at91 : remove wait_for_interrupt definition
In-Reply-To: <1327449368-29917-3-git-send-email-daniel.lezcano@linaro.org>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
 <1327449368-29917-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120125001858.GD12326@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 12:56:07AM +0100, Daniel Lezcano wrote:
> All the "wait_for_interrupt" definition are aliases to cpu_do_idle.
> Only the rm9200 has an asm routine to switch to wfi. But the cpu_do_idle
> for this platform has exactly the same asm routine.
> 
> arch/arm/mm/proc-arm920.S
> ...
> ENTRY(cpu_arm920_do_idle)
>         mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
> ...
> 
> Then it is safe to invoke cpu_do_idle for this platform.

No it is not.

Please read Nicolas' post:

http://lists.arm.linux.org.uk/lurker/message/20120112.144129.827ae490.en.html

and think about what "DWB is needed before putting SDRAM into self-refresh
because any subsequent access to SDRAM will force it to resume from
self-refresh state" means.

Consider that if you _branch_ somewhere else, you _could_ cause a cache
line fetch, which will have to come from SDRAM.

>From Nicolas' post, it's pretty clear to me that the AT91RM9200 requires
carefully crafted assembly which can't be separated in this way to work,
which I mostly supplied in this mail:

http://lists.arm.linux.org.uk/lurker/message/20120109.144443.3626e5a6.en.html
