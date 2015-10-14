From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 10:49:07 +0100
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <alpine.DEB.2.11.1510141100280.3785@nanos>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos> <5618D3EC.6050501@huawei.com>
 <20151010110942.52d34a4b@arm.com> <alpine.DEB.2.11.1510111150270.6097@nanos>
 <20151011120331.09093ffc@arm.com> <alpine.DEB.2.11.1510111335150.6097@nanos>
 <561E1886.2050305@arm.com> <alpine.DEB.2.11.1510141100280.3785@nanos>
Message-ID: <561E2513.1030901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 10:17, Thomas Gleixner wrote:
> Marc,
> 
> On Wed, 14 Oct 2015, Marc Zyngier wrote:
>> To me, it feels like we're spreading the complexity across multiple
>> layers instead of keeping it localized. It also means that next time
>> some crazy HW dude comes up with a similar idea (and I have little doubt
>> this will happen sooner than later), we'll have to replicate the same
>> thing again (though we could put all that behind another abstraction layer).
>>
>> I would have preferred a solution where the MSI domain is allowed to be
>> sandwiched between two non-MSI domains, and expose the top level
>> irqchip. This means fixing the following:
>>
>> - Either find a way to prevent DT doing these early IRQ allocations
>> (this could be easily done by simply not registering the irqchip), or be
>> able to elegantly reuse them.
> 
> The reuse part makes me shudder. We really should not go there. It's a
> blatant layering violation.
> 
>> - Add an API allowing an MSI domain to be the parent of another domain.
>>
>> Once we have this, we can use the platform MSI layer for the mbigen
>> without much complexity (well, not more that any other stacked irqchip,
>> the madness of the mbigen programming interface notwithstanding), and
>> drivers stay untouched. It would also give us a 'standard' way to deal
>> with the above HW dude. I'd be happy to prototype it.
> 
> Ok, I have a better understanding of it now.
> 
> I have no objections to your approach as long as it provides us a
> clean way to use a full hierarchy without weird interfaces to reuse
> irq descriptors etc. If you can find a way which just follows the
> proper hierarchy design, I'm certainly not in your way.
> 
> OTOH, the platform msi driver is not a huge amount of code and from my
> understanding of the hardware it looks weird to have this intermediate
> layer. Making mbigen a direct child of ITS feels just more natural to
> me. I'm pretty sure that this can be done without the earlier proposed
> horrible modifications to ITS. It just should fall into place.
> 
> It would be really great just to have shell implementations,
> i.e. without the mbigen specific stuff - for both models so we can
> compare and contrast the results. That means just the interfaces and
> the hookup to the various layers.

OK, let's do that. I'll try to post something before Friday so that we
can really evaluate what the knock-on effect is.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
