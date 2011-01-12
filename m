From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jan 2011 08:46:44 -0700
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <20110111154833.GF11039@n2100.arm.linux.org.uk>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<20110111104051.GA11039@n2100.arm.linux.org.uk>
	<20110111153630.GB2707@angua.secretlab.ca>
	<20110111154833.GF11039@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 8:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 11, 2011 at 08:36:30AM -0700, Grant Likely wrote:
>> On Tue, Jan 11, 2011 at 10:40:51AM +0000, Russell King - ARM Linux wrote:
>> > On Mon, Jan 10, 2011 at 07:15:53PM -0700, Grant Likely wrote:
>> > > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>> > > index 6bd82d2..9c0e938 100644
>> > > --- a/arch/arm/kernel/head.S
>> > > +++ b/arch/arm/kernel/head.S
>> > > @@ -87,11 +87,6 @@ ENTRY(stext)
>> > > ? movs ? ?r10, r5 ? ? ? ? ? ? ? ? ? ? ? ? @ invalid processor (r5=0)?
>> > > ? THUMB( it ? ? ? eq ) ? ? ? ? ? ?@ force fixup-able long branch encoding
>> > > ? beq ? ? __error_p ? ? ? ? ? ? ? ? ? ? ? @ yes, error 'p'
>> > > - bl ? ? ?__lookup_machine_type ? ? ? ? ? @ r5=machinfo
>> > > - movs ? ?r8, r5 ? ? ? ? ? ? ? ? ? ? ? ? ?@ invalid machine (r5=0)?
>> > > - THUMB( it ? ? ? eq ) ? ? ? ? ? ?@ force fixup-able long branch encoding
>> > > - beq ? ? __error_a ? ? ? ? ? ? ? ? ? ? ? @ yes, error 'a'
>> > > - bl ? ? ?__vet_atags
>> > > ?#ifdef CONFIG_SMP_ON_UP
>> > > ? bl ? ? ?__fixup_smp
>> > > ?#endif
>> >
>> > Don't forget to update the comments as well - there's two of them.
>>
>> I'm not entirely clear on what you're referring to here. ?Are you
>> talking about the secondary cpu entry point? ?I've fixed up that
>> comment now as well as a s/__lookup_machine_type/__lookup_processor_type/
>> typo right before the call to __enable_mmu.
>
> In the above code, __lookup_machine_type is called, which to be
> consistent with __lookup_processor_type, returns its value in r5. ?This
> is then copied to r8, which is the only point that r8 is initialized.
>
> The remainder of the code used to make use of r8 to load various fields
> from the machine record, and so there's a couple of comments indicating
> that this is the case. ?These comments are left behind after your patch
> and so are misleading.

Ah, right.  I'll clean those up.

> Shall I assume that you've already searched the head*.S files to make
> sure that r8 isn't used before you removed its initialization? ;-)

Yup!

Looks like I've hit a hiccup though.  When I remove the first call to
__lookup_machine_type, then it is only called after the MMU is turned
on and the kernel is no longer able to output the list of configured
machine ids when it doesn't recognize the value in r1 (tested with
qemu versatile emulation).  I'm still investigating, so I'll defer
reposting the patch until I've got this issue solved.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
