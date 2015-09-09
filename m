From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Sep 2015 01:06:01 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150908200809.GC21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 8 Sep 2015 21:08:09 +0100")
References: <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
 <877fo0x2ur.fsf@belgarion.home>
 <20150908200809.GC21084@n2100.arm.linux.org.uk>
Message-ID: <87mvwvurae.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Sep 08, 2015 at 07:01:00PM +0200, Robert Jarzmik wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> At the point we call into this code, the DACR should be 0x75, which
> should allow us to read the instruction at 0xbf00202c.  But this is
> failing with a permission error - which it would do if it thought
> the kernel domain was in manager mode (iow, 0x55).

Okay Russell, I have a good idea what's happening now. Basically, it boils down
to compiler optimization of get_domain() which is called twice (set_fs() ->
modify_domain() -> get_domain()). See the piece in [1] for a more complete
explanation.

I still haven't finished my work, as I need to disassemble the do_alignment()
function to confirm the DACR read by get_domain() is only done once in the
probe_kernel_address() call, and yet my hopes are high this is the cause as I
traced the DACR modifications, which led me to :
[-0] 0xc0017080: set_domain(0x00000055) => dacr = 0x00000055 => second set_domain()
[-1] 0xc0017080: set_domain(0x00000071) => dacr = 0x00000071 => first set_domain()
[-2] 0xc008a124: set_domain(0x00000051) => dacr = 0x00000051

Once I have my disassembly properly analyzed (ie. the second set_fs() doesn't do
a mrc instruction), I'll have my proof. My setup is too full of traces and
attempts to stall pipeline/prefetch to conclude yet, but there is a fair chance
I'm closer to the solution now.

Cheers.

--
Robert

[1] Current patch
=================
---8<---
>From 07cdda877b1b0c4fcdba3d756f6a22ce035ee672 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 10 Sep 2015 00:32:26 +0200
Subject: [PATCH] ARM: fix domain access

On the pxa310 platform, unaligned accesses are not fixed anymore with
the SW_DOMAIN_PAN configuration activated.

The trouble is that probe_kernel_address() cannot read the faulting
instruction, because of a permission error. The permission error comes
from the DACR register, whose value is incorrectly set to 0x55 instead
of 0x75.

I appears that at least gcc 4.8.2 optmizes the do_alignment() function,
and inside probe_kernel_address(), where set_fs() is called twice,
ie. modify_domain() is called twice, the get_domain() is called only
once, and the first call's value is reused. As a consequence, instead of
changing DACR as 0x51 -> 0x71 -> 0x75, it instead does 0x51 -> 0x71 ->
0x55. This is because instead of doing the last transition as :
 - (as (0x71 & ~0x03) | 0x04 = 0x75)
it does
 - (as (0x51 & ~0x03) | 0x04 = 0x55)

As a consequence, the alignment fault cannot be fixed, and triggers an
Oops:
Unable to handle kernel paging request at virtual address e1c20ec3
pgd = e1ce4000
[e1c20ec3] *pgd=c1c0044e(bad)
Internal error: Oops: 823 [#1] ARM
Modules linked in: unalign(+)
CPU: 0 PID: 610 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #946
Hardware name: CM-X300 module
task: e1c69500 ti: e1cc0000 task.ti: e1cc0000
PC is at u_init+0x2c/0x40 [unalign]
LR is at u_init+0x14/0x40 [unalign]
pc : [<bf00202c>]    lr : [<bf002014>]    psr: a0000013
sp : e1cc1df0  ip : e1c20640  fp : 1e3dffdc
r10: 00000001  r9 : e1c20040  r8 : 00000000
r7 : bf002000  r6 : e1c5ee80  r5 : c0be5b80  r4 : c0be5b80
r3 : e1c20ec0  r2 : 00000004  r1 : a0000013  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: c1ce4018  DAC: 00000051
Process insmod (pid: 610, stack limit = 0xe1cc0198)
Stack: (0xe1cc1df0 to 0xe1cc2000)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/include/asm/domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 10c9a38636ac..47f3b8445237 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -87,7 +87,7 @@ static inline unsigned int get_domain(void)
 {
 	unsigned int domain;
 
-	asm(
+	asm volatile(
 	"mrc	p15, 0, %0, c3, c0	@ get domain"
 	 : "=r" (domain));
 
-- 
2.1.4
