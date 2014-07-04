From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Jul 2014 16:24:38 +0200
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
In-Reply-To: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
References: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
Message-ID: <20140704142438.GA7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:58:24PM +0100, Russell King wrote:
> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).
> 
> We provide a new macro "ret" with all its variants for the condition
> code which will resolve to the appropriate instruction.
> 
> Rather than doing this piecemeal, and miss some instances, change all
> the "mov pc" instances to use the new macro, with the exception of
> the "movs" instruction and the kprobes code.  This allows us to detect
> the "mov pc, lr" case and fix it up - and also gives us the possibility
> of deploying this for other registers depending on the CPU selection.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Works fine on my ARM-v7M machine:

$ objdump -d vmlinux | grep -E 'mov.*pc'
8c000022:	46e7      	mov	pc, ip
8c000028:	46ef      	mov	pc, sp
8c000b26:	46af      	movne	pc, r5
8c0037e0:	4687      	mov	pc, r0
8c0828d2:	4697      	mov	pc, r2
8c1213ee:	469f      	mov	pc, r3

Also boots fine.

Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

but I wonder what is the reason to not use bx if \reg != lr.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
