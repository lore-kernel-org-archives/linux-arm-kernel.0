From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 3 Apr 2017 14:11:49 +0100
Subject: [PATCH 1/1] arm64: tegra: fix PPI interrupt flag
In-Reply-To: <6c64238f-a462-9e05-2f04-e989c16553c6@nvidia.com>
References: <7fad40fbcaa94c1ea46328e78b46443b@bgmail102.nvidia.com>
 <6c64238f-a462-9e05-2f04-e989c16553c6@nvidia.com>
Message-ID: <c1e1499e-166f-900b-aa45-773274ed73e8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/17 13:55, Jon Hunter wrote:
> Adding Marc ...
> 
> On 03/04/17 12:19, Aniruddha Banerjee wrote:
>> The interrupt flag for PPI should not be set to any value, since the
>> register is read-only. Fix the flags for the PPI interrupts to
>> IRQ_TYPE_NONE, so that there is no write to the read-only register.
> 
> If the below matches the h/w default, does this really cause a problem?
> 
> Note, we will not attempt to write the type if it matches the current
> programmed type.
> 
> I had thought that the in DT file, the type for the PPI should align
> with the h/w default in the case where it cannot be written. However, I
> guess this is not explicitly stated anywhere I have found, but at the
> same time the binding doc for the arm,gic.txt does not list
> "IRQ_TYPE_NONE" as an option.
> 
> Marc, what are your thoughts?

My immediate answer is "Why?".

As you pointed out, we don't even try to program the GICD_ICFGR1
register if what we read from it is the right thing. Also, the GICv2
spec says in 4.3.13: "For PPIs, it is IMPLEMENTATION DEFINED whether the
most significant bit of the Int_config field is programmable.".

So NONE is always wrong (because there is no such thing in the HW), and
the DT should have a setting that matches the HW even GICD_ICFGR1 is RO
(the OS may need to know how the triggering configuration anyhow).

Aniruddha: what problem are you trying to solve here? The DT you're
touching seems just fine to me...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
