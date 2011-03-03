From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 13:59:27 +0000
Subject: Compiling a kernel for armv5 + armv6
In-Reply-To: <20110303132056.GB18351@pengutronix.de>
References: <20110303132056.GB18351@pengutronix.de>
Message-ID: <20110303135927.GE25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 02:20:57PM +0100, Sascha Hauer wrote:
> Doing so currently breaks with:
> 
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:196: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:228: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:286: Error: selected processor does not support `strex r1,r2,[sp]'
> arch/arm/kernel/entry-armv.S:323: Error: selected processor does not support `strex r1,r2,[sp]'
> 
> These are used in svc_exit and restore_user_regs.
> 
> Is there a way to fix this or do we have to live with this?

As I've mentioned before, ARMv3-ARMv5 is fine.  ARMv6-ARMv7 is fine (with
patches).  ARMv5->ARMv6 is too big an architecture change to live together.

Compiling the above file for ARMv6 doesn't fix the problem because then
you'll be executing ARMv6 instructions on ARMv5 CPUs, which will fault.
Omitting those instructions makes ARMv6 behaviour unpredictable - as it
means no barriers could be used, no exclusive operations, etc.

Certainly ARMv5 + ARMv6MP is totally out of the question.
