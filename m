From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Jun 2011 11:29:29 -0700
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <20110628231711.GC23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>	<20110628225523.GA23312@n2100.arm.linux.org.uk>	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
Message-ID: <4E0B6F09.7010401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2011 04:17 PM, Russell King - ARM Linux wrote:
>
> That's why people have proposed hardware-timer based delay loops -
> these screw up the bogomips value (it no longer refers to the CPU
> but to the timer used for the delays) and the code proposed thus far
> probably has a severe negative impact on ARMs running at low clock
> rates (the calculation cost of the number of loops to run becomes
> significant for CPUs below 100MHz for short delays with the existing
> optimized assembler, so moving it into C and introducing function
> pointers will only make it worse.)

Am I people? ;-)

The code I've proposed doesn't seem to have a negative impact on our
targets even when the processor is running at 19.2 Mhz. Before and after
the patches I get the same lpj value (this is all described in the
commit text). I've also shown that rewriting delay.S into C doesn't
negatively affect the hand optimized assembly as the before and after
object code is nearly identical modulo register allocation. The only
issue would be the one function pointer which I haven't heard anyone
complain about until now.

Even if the time to get into the __delay() routine increases by a few
instructions I don't see how this harms anything as udelay() is a
minimum time guarantee. We should strive to make it as close as possible
to the time requested by the caller, but we shouldn't balk at the
introduction of a few more cycles along the setup path. Finally, since
the calibration takes into account most of the new instructions I doubt
it will even be noticeable overhead to have the function pointers.

What more can I do to convince you to take this patch?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
