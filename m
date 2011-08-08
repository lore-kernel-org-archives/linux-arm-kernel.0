From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Mon, 8 Aug 2011 14:43:00 +0300
Subject: [PATCH] ARM errata: Possible cache data corruption with
	hit-under-miss enabled
In-Reply-To: <20110808100233.GG29226@e102109-lin.cambridge.arm.com>
References: <1312785148-32531-1-git-send-email-siarhei.siamashka@gmail.com>
	<20110808100233.GG29226@e102109-lin.cambridge.arm.com>
Message-ID: <CACY+gR2_Rf7dh91vagJfEB=qgALJf4nigJbFQJz--DweQkZ+Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 1:02 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Aug 08, 2011 at 07:32:28AM +0100, Siarhei Siamashka wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> This patch is a workaround for the 364296 ARM1136 r0pX erratum (possible
>> cache data corruption with hit-under-miss enabled). It sets the
>> undocumented bit 31 in the auxiliary control register and the FI bit in
>> the control register, thus disabling hit-under-miss without putting the
>> processor into full low interrupt latency mode.
>>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Tested-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
>
> I haven't pushed this workaround in the past as I wasn't sure there is
> production hardware affected. I recall you mentioned Nokia N800, do you
> know which CPU revision does this have?

[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2
(ARMv6TEJ), cr=00e5387f
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction
cache
[    0.000000] Machine: Nokia N810
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP2420

# cat /proc/cpuinfo
Processor       : ARMv6-compatible processor rev 2 (v6l)
BogoMIPS        : 213.72
Features        : swp half thumb fastmult vfp edsp java
CPU implementer : 0x41
CPU architecture: 6TEJ
CPU variant     : 0x0
CPU part        : 0xb36
CPU revision    : 2

Hardware        : Nokia N810
Revision        : 0000
Serial          : 0000000000000000

> The erratum description states that only r0p2 is affected, though the
> patch doesn't test for this revision (needs some improvement).

Agreed. If only r0p2 is affected and not r0pX, then it surely makes
sense to update the patch to check MIDR for the exact match without
masking out revision. Especially considering that this workaround
cripples software prefetch and makes PLD instruction useless, hurting
performance on certain workloads.

I have a reproducible testcase (just running gcc natively on Nokia
N810 to compile glib), which fails without the workaround and starts
to work fine with it, so my guess is that the problem is not extremely
difficult to trigger. The maemo kernel based on 2.6.21 and shipped
with Nokia N800/N810 has this erratum workarounded and the users of
the official firmware are not affected. But apparently there are some
mainline kernel users too:
    http://bu3sch.de/cms/hacking/n810-openwrt.html

Would you be so kind to update the patch? Or should I do it myself?
Also are there any other issues which might need to be addressed on
this hardware (I don't have the errata list for ARM1136)?

-- 
Best regards,
Siarhei Siamashka
