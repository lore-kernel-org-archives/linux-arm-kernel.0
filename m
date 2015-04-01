From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Apr 2015 13:28:38 +0100
Subject: Reading twd_base at run-time
In-Reply-To: <551BDF69.4020205@free.fr>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr>
Message-ID: <551BE476.2060102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/15 13:07, Mason wrote:
> On 27/03/2015 21:53, Russell King - ARM Linux wrote:
> 
>> That's one scenario.  Here's the scenario Mark is describing - one which
>> has real-world examples:
>>
>> Hardware engineer picks address A for rev A and sets CP15 to address A.
>> Everything works.  Hardware engineer then picks address B for rev B, but
>> forgets to update CP15.  It breaks.
> 
> The hardware engineer told me that whatever arbitrary value is chosen
> for PERIPH_BASE is automatically exported through CP15 (which is how
> I thought this worked). So there is no "forgetting to update CP15"
> (for this platform, at least).

Go tell that to the TI guys who created this awesome derivative of the
OMAP4, which reports PERIPH_BASE as 0, despite the peripherals being
mapped somewhere else. What you describe is what happens when someone
properly reconfigures their RTL by running the whole integration thing,
which HW guys are eager to skip. What they often do is to cut and paste
an existing design, and see how many screws are left after doing so.

The cupboard in front of me is full of system presenting similar issues.
As much as I love HW engineers, it is a well known fact that they will
lie to you most of the time! ;-)

It is worth mentioning that PERIPH_BASE is *not* an architected
register, so an implementation is perfectly allowed not to implement it.
Even on Cortex A9, a UP implementation will report PERIPH_BASE as zero.
It is still likely to have a TWD though.

>> If it's in DT, it can be fixed.  It should be there anyway as part of
>> the hardware description.  DT is a description of the hardware.
> 
> I thought DT was supposed to describe hardware that /cannot/ be probed
> or discovered at run-time?

Indeed. And when probing is so unreliable, it is not worth using it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
