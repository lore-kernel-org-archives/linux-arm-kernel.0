From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 3 Mar 2011 14:29:00 +0000
Subject: [PATCH] ARM: Thumb-2: Add local symbols to work around gas
	behaviour
In-Reply-To: <20110303134854.GD25891@n2100.arm.linux.org.uk>
References: <1299155946-3641-1-git-send-email-dave.martin@linaro.org>
	<20110303134854.GD25891@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimmLjtPvUhOCv19TTrdTqmHsncJrv2uH8aJDYnb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2011 at 1:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 03, 2011 at 12:39:06PM +0000, Dave Martin wrote:
>> All current versions of gas at the time of writing have issues
>> fixing up pc-relative instructions which reference global symbols,
>> due to the potential need to support symbol preemption.
>> Even though symbol preemption is not relevant to the Linux kernel,
>> there is no way to inform the tools of this, so we get the problem.
>>
>> Most pc-relative forms in ARM, and all pc-relative forms in
>> Thumb, will cause the assembler to fail with various fixup error
>> messages when used to reference global symbols.
>>
>> The legacy behaviour is for ADR and plain LDR instructions in ARM
>> which reference global symbols to be fixed up silently with no
>> relocation emitted. ?This means that building the kernel in ARM
>> currently works without problems, but it may be a bug, and the
>> behaviour could change in the future.
>>
>> After discussion with Richard Earnshaw, it seems that there is
>> no single obvious remedy for this inconsistent behaviour,
>> so there is not likely to be a comprehensive upstream fix for
>> a while.
>>
>> A workaround which should be valid for all past and all
>> foreseeable future versions of gas is to express the need for
>> a local fixup explicitly, by declaring a shadow local symbol
>> for any global symbol which needs to be addressed using ADR
>> or any pc-relative LDR variant.
>>
>> This patch implements this workaround for the one part of the
>> main kernel currently known to be affected. ?The resulting code
>> builds and works correctly in ARM and Thumb.
>>
>> Similar fixes may be needed in mach-specific assembler.
>
> This all sounds like dumbness on the part of the assembler, and to say
> that this kind of behaviour may change in the future is completely brain
> dead.

Well, in truth I may be exaggerating here -- I haven't heard anyone
suggest that the behaviour _will_ change.  My understanding is simply
that the ARM behaviour of gas in this area is self-inconsistent (i.e.,
newer pc-relative instructions like LDRD don't work as expected, but
some older forms do) and also inconsistent with the Thumb behaviour
(which doesn't allow any of these forms to work with global symbols).
So, something has to change if that inconsistency is to be resolved.

>
> I am *FAR* from happy with this, and as far as I'm concerned, the
> assembler must work as one expects irrespective of whether symbols are
> local or global. ?I've no idea what binutils people are playing at here

Unfortunately, what the user expects is different depending on whether
the tools are used in a dynamic linking environment, or a static
environment such as the kernel.  Currently, there's no way to tell the
assembler which kind of environment is being targeted, since it
doesn't even get to know whether you're trying to generate PIC code or
not.

> but it sounds utterly idiotic and broken. ?I want no part in it. ?If
> that means developing our own assembler, so be it.

Well, FWIW I don't like this patch much either, and am quite happy to
retain it locally ... but I know anyone using CONFIG_THUMB2_KERNEL is
going to need to carry this for the next x years, and anyone
maintaining a mach tree may need similar patches there if they want
CONFIG_THUMB2_KERNEL to work for them.  So although it would be
preferable if there was no problem to solve, the problem is real and
will continue to exist for some time.

My own preference would be for all PC-relative instructions to be
allowed for all pc-relative instructions addressing global symbols in
both ARM and Thumb, as currently happens for ADR and LDR in ARM, since
emitting a relocation is largely useless-- the fixup range for these
instructions is so small that if you need to do a subsquent relocation
it will likely fail; and in any case, careful use of these
instructions would be just one reason among many why the programmer
needs to know what they're doing when writing assembler.  Plus it's a
logical, non-disruptive extension of the traditional behaviour.

However, I'm not confident of that view getting traction upstream, as
least not quickly.  It's not necessarily consistent with the needs of
compiler writers, who need to care about shared libraries and such.
If we can find a way of telling gas it's not building code for a
dynamic linking environment so it can relax its behaviour then that
would be ideal, since that allows us to continue with the traditional
behaviour in static environments such as the kernel.  But even so, it
would take time for that change to propagate into everyone's
toolchain.

Cheers
---Dave
