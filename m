From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Jul 2016 14:36:12 +0100
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <20160720131606.GJ3847@xsjsorenbubuntu>
References: <20160719181804.GX3847@xsjsorenbubuntu>
 <20160719224713.GA13533@hector.attlocal.net>
 <20160719233440.GG3847@xsjsorenbubuntu> <578F338C.40309@arm.com>
 <20160720131606.GJ3847@xsjsorenbubuntu>
Message-ID: <578F7E4C.9040407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On 20/07/16 14:16, S?ren Brinkmann wrote:
> Hi Marc,

>>>>> Does anybody have similar problems and probably already solved it?
>>>>> Any other suggestions for approaching the problem? Any preferred
>>>>> solution?
>>>>
>>>> I think we have the same problem.  Can you provide more detail on the hardware
>>>> implementation of your wake irq controller?  I presume you have some set of
>>>> registers, an irq maybe, and some other stuff?  And how does it fit into the
>>>> overall architecture from a hardware perspective?
>>>
>>> We have essentially a whole second interrupt controller. All IRQs are
>>> connected to the A53 GIC and this second interrupt controller that is
>>> controlled by the companion core. The companion core is supposed to be
>>> informed about what source the A53 needs to wake up on and will program
>>> this second IRQ controller, etc.
>>
>> So your "special case" is exactly like everyone else's. Implement it as
>> a hierarchical chip on top of the GIC, just like Tegra, OMAP, iMX6,
>> Exynos and a few others. Unless you implement PSCI.
> 
> I didn't really think that our case is unique. I was just looking for
> some pointers into the right direction as the extension mechanism that I
> remembered disappeared and I haven't been following the development
> closely enough to just know what alternatives are available.
> So, you say the approach of letting the secure monitor infer the wake
> IRQ by reading the GIC config is preferred over handling it as
> hierarchical chip within Linux?

The in-kernel approach is a consequence of the firmware-less 32bit
configuration. Hopefully, we won't see anything like that anymore.
Fingers crossed.

So the firmware approach is clearly the preferred one on arm64, as it
simplifies absolutely everything (and your power management has to know
about all of this anyway).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
