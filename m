From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Mar 2013 17:26:33 +0000
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <20130321110646.GE15279@e106331-lin.cambridge.arm.com>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <20130321110646.GE15279@e106331-lin.cambridge.arm.com>
Message-ID: <20130325172633.GP30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 11:06:47AM +0000, Mark Rutland wrote:
> On TC2 this series leads to using the vexpress 24MHz clock as the sched clock
> in preference to the architected timer:
> 
>   Architected local timer running at 24.00MHz (virt).
>   Switching to timer-based delay loop
>   Registered arch_counter_get_cntvct+0x0/0x14 as sched_clock source
>   sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
>   Registered versatile_read_sched_clock+0x0/0x28 as sched_clock source
> 
> As they both have the same frequency, neither overrides the other, and
> whichever gets registered last is used as the sched_clock. As accesses
> to the architected timer are going to have a much lower overhead, this
> isn't very nice (and it could be better to use it even if it had a lower
> frequency).

I'll remind people that sched_clock() is supposed to be functional at
the point in the boot sequence where the call to sched_init() is called.
That is after setup_arch() and *before* time_init() is called.
