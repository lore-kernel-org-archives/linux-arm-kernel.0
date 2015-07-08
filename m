From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Jul 2015 11:44:40 +0100
Subject: [PATCH 3/4] irqchip, gicv3: Implement Cavium ThunderX erratum
 23154
In-Reply-To: <20150708102846.GT10428@rric.localhost>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-4-git-send-email-rric@kernel.org>
 <559A5BB6.2040509@arm.com> <20150708102846.GT10428@rric.localhost>
Message-ID: <559CFF18.8090803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 11:28, Robert Richter wrote:
> Marc,
> 
> On 06.07.15 11:43:02, Marc Zyngier wrote:
>> On 30/06/15 15:14, Robert Richter wrote:
>>>  static const struct gic_capabilities gicv3_errata[] = {
>>>  	{
>>> +		.desc	= "GIC: Cavium erratum 23154",
>>> +		.id	= 0xa100034c,	/* ThunderX pass 1.x */
>>> +		.mask	= 0xffff0fff,
>>> +		.init	= gicv3_enable_cavium_thunderx,
>>> +	},
>>> +	{
>>>  	}
>>>  };
>>>  
>>>
>>
>> How does this work when running a guest? Does the virtualized access
>> suffer from the same erratum? If that's the case, we need a better
>> workaround...
> 
> We need to apply the workaround also for guests. So you are right,
> evaluating GICD_IIDR does not enable the workaround then as the
> register is emulated with ARM as implementer.
> 
> We considering MIDR_EL1 as a version check for this errata now. This
> should be the host's cpuid when running as a guest, right?

Yes, that should work, as we don't repaint MIDR_EL1 *yet*. But it also
means that we're going to have a hard time emulating another CPU (such
as A57) on top of ThunderX. Probably not a big deal at the moment...

	M.
-- 
Jazz is not dead. It just smells funny...
