From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 5 Jan 2012 12:13:26 +0100
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <4F0584B5.60908@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk> <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk>
 <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
 <4F0584B5.60908@arm.com>
Message-ID: <CAMQu2gxuBNRWYKyKRdzvv_m49DyLoODVbC=rKDHDAMTnxe+6+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 12:08 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 05/01/12 00:00, Linus Walleij wrote:
>> However IIRC this situation does not occur in the ARM reference
>> designs, notably Versatile Express since it simply isn't designed to
>> be power-agressive in this way and does not gate the clock or
>> power down the CPU power domain, it's always on, always
>> clocked (albeit with shifting frequency).
>>
>> The Vexpress seem to register a clockevent for its SP804
>> timer, and even though I've never used this machine I guess
>> it would tick a few ticks during boot and then as TWD is
>> registered it switches to that (due to higher .rate) and
>> no IRQ is ever fired on the SP804 again.
>>
>> Does this correspond to what is seen in /proc/interrupts
>> on the Vexpress?
>
> Yes. You get about 8 ticks worth of SP804, and then switch to TWD for good.
>
>> And does the system really work if you simply delete the
>> code registering the SP804 clockevent from
>> mach-vexpress/ct-ca9x4.c?
>
> No, because you need the global timer to calibrate the TWD on this
> platform. But on the VE with a Cortex-A15 tile, the system works
> perfectly with the architected timers being the only one in the system
> (the SP804 is left unconfigured).
>
> But now that your cpufreq-aware patches are in -next, I can boot a Panda
> without a single tick of the global timer (OMAP4 provides the "smp-twd"
> clock).
>
That's only because CPUIDLE low power states are not enabled. You
do that and without global timer, system will just die
