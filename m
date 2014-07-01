From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 01 Jul 2014 17:42:42 +0100
Subject: [PATCH] ARM: convert all "mov.* pc,
 reg" to "bx reg" for ARMv6+ (part1)
In-Reply-To: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Tue, 01 Jul 2014 17:19:33 +0100")
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
Message-ID: <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).
>
> We provide a new macro "ret" with all its variants for the condition
> code which will resolve to the appropriate instruction.

When the source register is not "lr" the name "ret" is a misnomer since
only the "bx lr" instruction is predicted as a function return.  The
"bx" instruction with other source registers uses the normal prediction
mechanisms, leaving the return stack alone, and should not be used for
function returns.  Any code currently using another register to return
from a function should probably be modified to use lr instead, unless
there are special reasons for doing otherwise.  If code jumping to an
address in a non-lr register is not a return, using the "ret" name will
make for some rather confusing reading.

I would suggest either using a more neutral name than "ret" or adding an
alias to be used for non-return jumps so as to make the intent clearer.

-- 
M?ns Rullg?rd
mans at mansr.com
