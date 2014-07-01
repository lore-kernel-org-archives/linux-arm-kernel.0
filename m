From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 18:13:46 +0100
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for
 ARMv6+ (part1)
In-Reply-To: <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
 <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
Message-ID: <20140701171346.GP3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 05:42:42PM +0100, M?ns Rullg?rd wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> writes:
> 
> > ARMv6 and greater introduced a new instruction ("bx") which can be used
> > to return from function calls.  Recent CPUs perform better when the
> > "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> > and this sequence is strongly recommended to be used by the ARM
> > architecture manual (section A.4.1.1).
> >
> > We provide a new macro "ret" with all its variants for the condition
> > code which will resolve to the appropriate instruction.
> 
> When the source register is not "lr" the name "ret" is a misnomer since
> only the "bx lr" instruction is predicted as a function return.  The
> "bx" instruction with other source registers uses the normal prediction
> mechanisms, leaving the return stack alone, and should not be used for
> function returns.  Any code currently using another register to return
> from a function should probably be modified to use lr instead, unless
> there are special reasons for doing otherwise.  If code jumping to an
> address in a non-lr register is not a return, using the "ret" name will
> make for some rather confusing reading.
> 
> I would suggest either using a more neutral name than "ret" or adding an
> alias to be used for non-return jumps so as to make the intent clearer.

If you read the patch, the branches which are changed are those which
do indeed return in some way.  There are those which do this having
moved lr to a different register.

As you point out, "bx lr" /may/ be treated specially (I've actually been
discussing this with Will Deacon over the last couple of days, who has
also been talking to the hardware people in ARM, and Will is happy with
this patch as in its current form.)  This is why I've changed all
"mov pc, reg" instructions which return in some way to use this macro,
and left others (those which are used to call some function and return
back to the same point) alone.

I have thought about introducing a "call" macro for those other sites,
but as there are soo few of them, I've left them as-is for the time
being (this patch is already large enough.)

If there are any in the patch which you have specific concerns about,
please specifically point them out those which give you a concern.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
