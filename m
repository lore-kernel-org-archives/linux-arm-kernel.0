From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Jul 2011 13:36:27 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <20110711113818.GI3239@n2100.arm.linux.org.uk>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
	<20110708195708.GR4812@n2100.arm.linux.org.uk>
	<20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
	<20110710153759.GI4812@n2100.arm.linux.org.uk>
	<20110710183039.GJ4812@n2100.arm.linux.org.uk>
	<4E1AC7C5.9020909@arm.com>
	<20110711101750.GE3239@n2100.arm.linux.org.uk>
	<4E1ADB1C.80504@arm.com>
	<20110711113818.GI3239@n2100.arm.linux.org.uk>
Message-ID: <4E1AEE4B.3090904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/11 12:38, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 12:14:36PM +0100, Marc Zyngier wrote:
>> And that's exactly what it does:
>> http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg05026.html
>>
>> What I was trying to explain (and obviously failed to) is that the
>> _Linux_ DT _code_ will try to resolve the PPI number and convert it to a
>> _Linux_ IRQ number. Unless of course you don't encode it as an interrupt
>> at all, which seems to be what you're aiming for.
> 
> I'm not aiming for anything.  I'm trying to get you to fully understand
> the issue I've raised with your patches.  So, let's try a new scenario
> based on your statement above.
> 
> You have a device which happens to use a PPI.  You obtain its IRQ number
> from DT, which tells you IRQ 9, because the DT information said PPI 2
> CPU 1.  So you pass IRQ 9 into the IRQ request function, but as you're
> running on CPU 3, you have no access to the hardware for IRQ 9.
> 
> Please describe in detail how, with your patches, PPI 2 CPU 1 gets enabled
> rather than PPI 2 CPU 3 when IRQ 9 is requested.

You simply do not do that. You store the mapping for later use on the
right CPU. My code is buggy as I didn't think of the requesting thread
being preempted, but I never intended to do this sort of cross-CPU request.
-- 
Jazz is not dead. It just smells funny...
