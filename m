From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 2 Jul 2014 17:01:04 +0530
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
In-Reply-To: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
References: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
Message-ID: <53B3ED78.1070608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 09:28 PM, Russell King wrote:
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

> ---

>  arch/arm/mach-davinci/sleep.S            |  2 +-

I build, boot and suspend-to-RAM tested on DA850 which should exercise
the path you modified. DaVinci devices are ARMv5 (ARM926) so the new bx
instruction does not really get used.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
