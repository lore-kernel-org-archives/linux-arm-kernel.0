From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 12:55:26 +0100
Subject: [PATCH 9/9] ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)
In-Reply-To: <1283787775.12076.115.camel@e102109-lin.cambridge.arm.com>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135855.21304.5457.stgit@e102109-lin.cambridge.arm.com>
	<20100831150505.GC13866@shutemov.name>
	<1283787775.12076.115.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100913115526.GE30787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 04:42:55PM +0100, Catalin Marinas wrote:
> +/*
> + * Error-checking SWP macros implemented using ldrex{b}/strex{b}
> + */
> +#define __user_swpX_asm(data, addr, res, B)			\
> +	__asm__ __volatile__(					\
> +	"	mov		r3, %1\n"			\
> +	"0:	ldrex"B"	%1, [%2]\n"			\
> +	"1:	strex"B"	%0, r3, [%2]\n"			\
> +	"	cmp		%0, #0\n"			\
> +	"	movne		%0, %3\n"			\
> +	"2:\n"							\
> +	"	.section	 .fixup,\"ax\"\n"		\
> +	"	.align		2\n"				\
> +	"3:	mov		%0, %4\n"			\
> +	"	b		2b\n"				\
> +	"	.previous\n"					\
> +	"	.section	 __ex_table,\"a\"\n"		\
> +	"	.align		3\n"				\
> +	"	.long		0b, 3b\n"			\
> +	"	.long		1b, 3b\n"			\
> +	"	.previous"					\
> +	: "=&r" (res), "+r" (data)				\
> +	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
> +	: "cc", "r3")

This assembly needs to be cleaned up to avoid using a fixed register.
r3 is the first register gcc choses to use when allocating registers,
so to clobber it almost guarantees making gcc's job a little harder.

Instead, do this:
	unsigned long temp;

and in the asm() output line:

	: "=&r" (res), "+r" (data), "=&r" (temp)

> +static unsigned long long swpcounter;
> +static unsigned long long swpbcounter;
> +static unsigned long long abtcounter;

long long can't be atomically updated - and if you have over 4000000000
faults, do you really care at that point?

> +static long		  previous_pid;

There is a typedef for pids.

Apart from that, the rest looks fine.
