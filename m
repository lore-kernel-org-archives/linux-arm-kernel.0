From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 28 Jan 2014 10:18:16 -0500
Subject: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
 communication use-cases
References: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
 <20140106132536.GA27282@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EDAD85E@DBDE04.ent.ti.com>
 <87wqhl15wi.fsf@nbsps.com>
 <79CD15C6BA57404B839C016229A409A83EDC1E71@DBDE04.ent.ti.com>
Message-ID: <877g9k16fb.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> You have any other alternative?

>> From: Bill Pringlemeir [mailto:bpringlemeir at nbsps.com]

>> I think you need to put Bhupesh Sharma's comment with this.  The
>> typical sane mode for GIC with TZ is to have the monitor mode toggle
>> the IRQ/FIQ routing bits in the SCR (cp15) bits 1,2.  That is, the
>> IRQ goes direct to core and FIQ goes to monitor from the 'Normal'
>> world.  In the 'Secure' world, the FIQ goes direct to core and IRQ
>> traps to monitor.  The monitor mode vector table has a gateway from
>> secure to normal for IRQ and gateway from normal to secure for FIQ.
>>
>> Now, consider the 'SMC' instruction and what is present in stuff like
>> this,
>>
>> http://lwn.net/Articles/513756/

>> Instead of messing around with the GIC, why not use something even
>> more generic like the 'SMC' instruction.  It has the same sort of
>> 'end game' which is a trap to monitor mode.  The monitor has to be a
>> little smarter to determine which world called but this should always
>> be the case; really you want to check this.
>>
>> Btw, the situation is the same no matter which world Linux is in.  I
>> don't think Linux can be the recipient of an 'SMC' call.  But I think
>> most use cases would put it in the 'normal world' and the SMC is
>> fine.

On 28 Jan 2014, hvaibhav at ti.com wrote:

> May be I am missing something here,

> I find your above two statements contradictory,

> If we want to use SMC as you mentioned, and assuming Secure Monitor
> mode is intelligent enough to determine the calling world (whether
> secure or non-secure), then without Linux being recipient (in any
> world) of an 'SMC' call how can realtime switch possible from secure
> world to non-secure world??

I don't think that using an SMC in either world is any different than
writing to the GIC distributors SGIR?  So, the generation is the same.
The monitor switching should be the same.  The only difference is where
does the world switch ends up.

> Just to clarify,

> The need here is, to switch from secure world to non-secure world on
> any realtime (multiple) hardware events, which in turn gets
> processed/handled in non-secure world.  In certain cases even we do
> not want non-secure world know about the hardware event. In this case,
> the Processing of hardware event completely happens in secure world,
> and different event/trigger/info/message goes to non-secure world.

Ok.  Your needs are backwards to my understanding.  You want the
'secure/non-linux' to send an SGI to the Linux.  Ie, you want the
recipient case for the normal world.  The normal world can always issue
an SMC during boot to register a recipient mechanism.  You can fake
another interrupt chip or use some other mechanism.

> So just manipulating IRQ/FIQ routing will not solve the need here. :)

I didn't mean this would solve your problem.  I meant this keeps the
latency to a minimum when using TrustZone.  If an 'interrupt' (FIQ or
IRQ) source occurs in the destination world, then the path is as per
usual.  It is only when an 'interrupt' occurs in the opposite world when
a world switch is needed; this is a fairly expensive operation.

In your case, it sounds like you want the secure world to handle all
interrupts or at least the majority.  This has a pre-defined destination
in a jump to the vector table of the opposite world.  This is the
'recipient' mechanism.  At the very least a 'multi-chip' IRQ could be
used and you can ldrex/strex with world shareable memory to communicate
interrupt sources to the other world; the world shareable memory acts as
a 'IRQ controller register set'.  With the SMC, you have the opportunity
to transfer some information in registers.  It has a bigger question of
how the schedulers would inter-act.  Do you have a scheduler in the
secure world?

I think these are 'alternatives' as you asked?

Regards,
Bill Pringlemeir.
