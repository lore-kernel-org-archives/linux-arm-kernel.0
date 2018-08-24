From: tmricht@linux.ibm.com (Thomas-Mich Richter)
Date: Fri, 24 Aug 2018 09:59:22 +0200
Subject: [PATCH] perf annotate: fix parsing aarch64 branch instructions
 after objdump update
In-Reply-To: <20180823191047.9260992844205984b75e6721@arm.com>
References: <20180823191047.9260992844205984b75e6721@arm.com>
Message-ID: <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2018 02:10 AM, Kim Phillips wrote:
> Starting with binutils 2.28, aarch64 objdump adds comments to the
> disassembly output to show the alternative names of a condition code [1].
> 
> It is assumed that commas in objdump comments could occur in other arches
> now or in the future, so this fix is arch-independent.
> 
> The fix could have been done with arm64 specific jump__parse and
> jump__scnprintf functions, but the jump__scnprintf instruction would
> have to have its comment character be a literal, since the scnprintf
> functions cannot receive a struct arch easily.
> 
> This inconvenience also applies to the generic jump__scnprintf, which
> is why we add a raw_comment pointer to struct ins_operands, so the
> __parse function assigns it to be re-used by its corresponding __scnprintf
> function.
> 
> Example differences in 'perf annotate --stdio2' output on an
> aarch64 perf.data file:
> 
> BEFORE: ? b.cs   ffff200008133d1c <unwind_frame+0x18c>  // b.hs, dffff7ecc47b
> AFTER : ? b.cs   18c
> 
> BEFORE: ? b.cc   ffff200008d8d9cc <get_alloc_profile+0x31c>  // b.lo, b.ul, dffff727295b
> AFTER : ? b.cc   31c
> 
> The branch target labels 18c and 31c also now appear in the output:
> 
> BEFORE:        add    x26, x29, #0x80
> AFTER : 18c:   add    x26, x29, #0x80
> 
> BEFORE:        add    x21, x21, #0x8
> AFTER : 31c:   add    x21, x21, #0x8
> 
> The Fixes: tag below is added so stable branches will get the update; it
> doesn't necessarily mean that commit was broken at the time, rather it
> didn't withstand the aarch64 objdump update.
> 
> Tested no difference in output for sample x86_64, power arch perf.data files.

Tested,  no difference in output on s390. Just to let you know.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Gesch?ftsf?hrung: Dirk Wittkopp
Sitz der Gesellschaft: B?blingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
