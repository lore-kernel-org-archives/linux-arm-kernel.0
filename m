From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 10:26:51 +0100
Subject: [PATCH 1/1] ARM: thumb: Fix thumb mode compilation problems.
In-Reply-To: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
References: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
Message-ID: <20110516092651.GM30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 12:58:58PM -0700, Vadim Bendebury wrote:
> @@ -99,15 +99,24 @@ void __naked set_fiq_regs(struct pt_regs *regs)
>  	register unsigned long tmp;
>  	asm volatile (
>  	"mov	ip, sp\n\
> -	stmfd	sp!, {fp, ip, lr, pc}\n\
> +	sub	sp, sp, #8\n\
> +	stmfd	sp!, {fp, ip}\n\
> +	str	lr, [sp, #8]\n\
> +	str	pc, [sp, #12]\n\

This breaks the ARM mode backtracing.  ARM mode stack frames must be created
using the three instructions given in the original.

Do we really have any Thumb-2 capable CPUs using FIQ support?
