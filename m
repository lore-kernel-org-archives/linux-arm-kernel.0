From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 16 Feb 2016 15:59:09 +0300
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
Message-ID: <56C31D1D.50708@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2016 09:59 PM, Catalin Marinas wrote:
> On Mon, Feb 15, 2016 at 05:28:02PM +0300, Andrey Ryabinin wrote:
>> On 02/12/2016 07:06 PM, Catalin Marinas wrote:
>>> So far, we have:
>>>
>>> KASAN+for-next/kernmap goes wrong
>>> KASAN+UBSAN goes wrong
>>>
>>> Enabled individually, KASAN, UBSAN and for-next/kernmap seem fine. I may
>>> have to trim for-next/core down until we figure out where the problem
>>> is.
>>>
>>> BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x164/0x16a0 at addr ffffffc93665bc8c
>>
>> Can it be related to TLB conflicts, which supposed to be fixed in
>> "arm64: kasan: avoid TLB conflicts" patch from "arm64: mm: rework page
>> table creation" series ?
> 
> I can very easily reproduce this with a vanilla 4.5-rc1 series by
> enabling inline instrumentation (maybe Mark's theory is true w.r.t.
> image size).
> 
> Some information, maybe you can shed some light on this. It seems to
> happen only for secondary CPUs on the swapper stack (I think allocated
> via fork_idle()). The code generated looks sane to me, so KASAN should
> not complain but maybe there is some uninitialised shadow, hence the
> error.
> 
> The report:
>

Actually, the first report is a bit more useful. It shows that shadow memory was corrupted:

  ffffffc93665bc00: f1 f1 f1 f1 00 f4 f4 f4 f2 f2 f2 f2 00 00 f1 f1
> ffffffc93665bc80: f1 f1 00 00 00 00 f3 f3 00 f4 f4 f4 f3 f3 f3 f3
                      ^
F1 - left redzone, it indicates start of stack frame
F3 - right redzone, it should be the end of stack frame.

But here we have the second set of F1s without F3s which should close the first set of F1s.
Also those two F3s in the middle cannot be right.

So shadow is corrupted.
Some hypotheses:

1) We share stack between several tasks (e.g. stack overflow, somehow corrupted SP).
    But this probably should cause kernel crash later, after kasan reports.

2) Shadow memory wasn't cleared. GCC poison memory on function entrance and unpoisons it before return.
     If we use some tricky way to exit from function this could cause false-positives like that.
     E.g. some hand-written assembly return code.

3) Screwed shadow mapping. I think the patch below should uncover such problem.
It boot-tested on qemu and didn't show any problem


---
 arch/arm64/mm/kasan_init.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index cf038c7..25d685c 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -117,6 +117,59 @@ static void __init cpu_set_ttbr1(unsigned long ttbr1)
 	: "r" (ttbr1));
 }
 
+static void verify_shadow(void)
+{
+	struct memblock_region *reg;
+	int i = 0;
+
+	for_each_memblock(memory, reg) {
+		void *start = (void *)__phys_to_virt(reg->base);
+		void *end = (void *)__phys_to_virt(reg->base + reg->size);
+		int *shadow_start, *shadow_end;
+
+		if (start >= end)
+			break;
+		shadow_start = (int *)((unsigned long)kasan_mem_to_shadow(start) & ~(PAGE_SIZE - 1));
+		shadow_end =  (int *)kasan_mem_to_shadow(end);
+		for (; shadow_start < shadow_end; shadow_start += PAGE_SIZE/sizeof(int)) {
+			*shadow_start = i;
+			i++;
+		}
+	}
+
+	i = 0;
+	for_each_memblock(memory, reg) {
+		void *start = (void *)__phys_to_virt(reg->base);
+		void *end = (void *)__phys_to_virt(reg->base + reg->size);
+		int *shadow_start, *shadow_end;
+
+		if (start >= end)
+			break;
+		shadow_start = (int *)((unsigned long)kasan_mem_to_shadow(start) & ~(PAGE_SIZE - 1));
+		shadow_end =  (int *)kasan_mem_to_shadow(end);
+		for (; shadow_start < shadow_end; shadow_start += PAGE_SIZE/sizeof(int)) {
+			if (*shadow_start != i) {
+				pr_err("screwed shadow mapping %d, %d\n", *shadow_start, i);
+				goto clear;
+			}
+			i++;
+		}
+	}
+clear:
+	for_each_memblock(memory, reg) {
+		void *start = (void *)__phys_to_virt(reg->base);
+		void *end = (void *)__phys_to_virt(reg->base + reg->size);
+		unsigned long shadow_start, shadow_end;
+
+		if (start >= end)
+			break;
+		shadow_start =  ((unsigned long)kasan_mem_to_shadow(start) & ~(PAGE_SIZE - 1));
+		shadow_end =  (unsigned long)kasan_mem_to_shadow(end);
+		memset((void *)shadow_start, 0, shadow_end - shadow_start);
+	}
+
+}
+
 void __init kasan_init(void)
 {
 	struct memblock_region *reg;
@@ -159,6 +212,8 @@ void __init kasan_init(void)
 	cpu_set_ttbr1(__pa(swapper_pg_dir));
 	flush_tlb_all();
 
+	verify_shadow();
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
-- 
