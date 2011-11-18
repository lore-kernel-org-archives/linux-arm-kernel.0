From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2011 17:40:01 +0000
Subject: [PATCH] ARM: unwind: add unwind directives to bitops assembly
 macros
In-Reply-To: <20111117184801.GF3044@localhost.localdomain>
References: <1321553096-11859-1-git-send-email-will.deacon@arm.com>
 <20111117184801.GF3044@localhost.localdomain>
Message-ID: <20111118174001.GF17991@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 06:48:01PM +0000, Dave Martin wrote:
> On Thu, Nov 17, 2011 at 06:04:56PM +0000, Will Deacon wrote:
> > The bitops functions (e.g. _test_and_set_bit) on ARM do not have unwind
> > annotations and therefore the kernel cannot backtrace out of them on a
> > fatal error (for example, NULL pointer dereference).
> > 
> > This patch annotates the bitops assembly macros with UNWIND annotations
> > so that we can produce a meaningful backtrace on error.
> 
> I take it these macros aren't likely ever to get used except in the
> definition of complete functions (as in testsetbit.S etc.)?

Currently they're only used in that way and I don't see why that would
change.

> One way to make the correct behaviour explicit would be to put the
> function boilerplate into the macros instead:
> 
> #include <linux/linkage.h>
> #include <asm/unwind.h>
> 
> 	.macro bitop name, instr
> ENTRY(\name )
> UNWIND(	.fnstart	)
> 	@ stuff
> 	@ bx lr / mov pc,lr
> UNWIND(	.fnend		)
> ENDPROC(\name )
> 	.endm
> 
> That makes it harder to misuse the macros or to typo the ENDPROC()
> directive, as well as allowing a few lines to be eliminated from the
> other .S files.

That's not a bad idea, I'll re-roll the patch next week.

Will
