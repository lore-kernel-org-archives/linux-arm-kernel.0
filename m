From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 01 Jul 2014 18:24:43 +0100
Subject: [PATCH] ARM: convert all "mov.* pc,
 reg" to "bx reg" for ARMv6+ (part1)
In-Reply-To: <20140701171346.GP3705@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 1 Jul 2014 18:13:46 +0100")
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
 <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
 <20140701171346.GP3705@n2100.arm.linux.org.uk>
Message-ID: <yw1xzjgtdmas.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Jul 01, 2014 at 05:42:42PM +0100, M?ns Rullg?rd wrote:
>> Russell King <rmk+kernel@arm.linux.org.uk> writes:
>> 
>> > ARMv6 and greater introduced a new instruction ("bx") which can be used
>> > to return from function calls.  Recent CPUs perform better when the
>> > "bx lr" instruction is used rather than the "mov pc, lr" instruction,
>> > and this sequence is strongly recommended to be used by the ARM
>> > architecture manual (section A.4.1.1).
>> >
>> > We provide a new macro "ret" with all its variants for the condition
>> > code which will resolve to the appropriate instruction.
>> 
>> When the source register is not "lr" the name "ret" is a misnomer since
>> only the "bx lr" instruction is predicted as a function return.  The
>> "bx" instruction with other source registers uses the normal prediction
>> mechanisms, leaving the return stack alone, and should not be used for
>> function returns.  Any code currently using another register to return
>> from a function should probably be modified to use lr instead, unless
>> there are special reasons for doing otherwise.  If code jumping to an
>> address in a non-lr register is not a return, using the "ret" name will
>> make for some rather confusing reading.
>> 
>> I would suggest either using a more neutral name than "ret" or adding an
>> alias to be used for non-return jumps so as to make the intent clearer.
>
> If you read the patch, the branches which are changed are those which
> do indeed return in some way.  There are those which do this having
> moved lr to a different register.

The patch is huge, and it wasn't obvious (to me) from the diff context
what the non-lr jumps were doing.

> As you point out, "bx lr" /may/ be treated specially (I've actually been

Most, if not all, Cortex-A cores do this according the public TRMs.
They also do the same thing for "mov pc, lr" so there will probably be
no performance gain from this change.  It's still a good idea though,
since we don't know what future cores will do.

> discussing this with Will Deacon over the last couple of days, who has
> also been talking to the hardware people in ARM, and Will is happy with
> this patch as in its current form.)  This is why I've changed all
> "mov pc, reg" instructions which return in some way to use this macro,
> and left others (those which are used to call some function and return
> back to the same point) alone.

In that case the patch should be fine.  Your patch description didn't
make it clear that only actual returns were being changed.

-- 
M?ns Rullg?rd
mans at mansr.com
